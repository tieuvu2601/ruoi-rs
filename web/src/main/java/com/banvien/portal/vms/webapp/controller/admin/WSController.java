package com.banvien.portal.vms.webapp.controller.admin;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jbpm.api.task.Task;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Sms;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.service.MailEngine;
import com.banvien.portal.vms.service.SmsService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;

@Controller
public class WSController extends ApplicationObjectSupport{
	private transient final Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ContentService contentService;
	
	@Autowired
	private JbpmSpringService jbpmSpringService;
	
	@Autowired
	private MailEngine mailEngine;
	
	@Autowired
	private SmsService smsService;
	
	@RequestMapping("/mobile/test.html")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView("test");
		return mav;
	}
	
	@RequestMapping("/ajax/message.html")
	public void sendMessage(HttpServletRequest request, HttpServletResponse response) {
		try{
			String phone = request.getParameter("phone");
			String message = request.getParameter("message");
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			JSONObject object = new JSONObject();
			object.put("success", true);
			object.put("message", errorDetailMap.get(validateMessage(phone, message, request)));
            out.print(object);
            out.flush();
            out.close();
		}catch(Exception e){
			logger.error("WCController", e);
		}
	}
	
	private String validateMessage(String phone, String message, HttpServletRequest request){
		try{
			if(!StringUtils.isNotEmpty(phone)){
				return PHONE_EMPTY;
			}else{
				phone = phone.trim();
			}
			if(!StringUtils.isNotEmpty(message)){
				return MESSAGE_EMPTY;
			}else{
				message = message.trim();
			}
			List<User> users = userService.findProperty("mobileNumber", phone);
			User currentUser = null;
			if(users.size() < 1){
				return PHONE_NOT_FOUND;
			}else{
				currentUser = users.get(0);
			}
			
			String[] messages = message.split(" ");
			if(messages.length != 2){
				return MESSAGE_WRONG_SYNTAX;
			}else{
				Long contentID = null;
				String decision = messages[1];
				try{
					contentID = Long.valueOf(messages[0].trim());
				}catch(Exception e){
					logger.error("Content ID not a number");
					return CONTENT_ID_NOT_NUMBER;
				}
				Content content = null;
				try {
					content = contentService.findById(contentID);
				} catch (ObjectNotFoundException e) {
					logger.error("Content not found ID=" + contentID);
					return CONTENT_NOT_FOUND;
				}
				
				if(!decision.equalsIgnoreCase(DECISION_APPROVED) && !decision.equalsIgnoreCase(DECISION_REJECT)){
					return DECISION_WRONG_SYNTAX;
				}
				
				Object [] objRes = jbpmSpringService.getContentIDsAndTaskMap(currentUser.getUsername());
				Map<Long, Task> taskMap = (Map<Long, Task>)objRes[1];
		        List<Long> contentIds = (List<Long>)objRes[0];
		        if(!contentIds.contains(contentID)){
		        	return NOT_HAVE_PERMISSION;
		        }else{
		        	Task task = (Task)taskMap.get(contentID);
		        	
		        	String transition = "";
		        	if(task.getName().equals("composeContent")){
		        		transition = "approve";
		        	}else{
		        		if(decision.equals(DECISION_APPROVED)){
		        			transition = "accept";
		        		}else{
		        			transition = "reject";
		        		}
		        	}
		        	
		        	if(currentUser.getUserGroup() != null && currentUser.getUserGroup().getCode().equals(Constants.GROUP_PUBLISHER)){
	        			content.setStatus(Constants.CONTENT_PUBLISH);
	        			contentService.update(content);
		        	}
		        	if(StringUtils.isEmpty(task.getAssignee())){
		        		jbpmSpringService.assignTask2User(task, currentUser.getUsername());
		        	}
	                jbpmSpringService.completeTask(task.getId(), transition);
	                
	                insertIntoSms(phone, message, content);
	                
	                try{
	                	sendMail2RelatePeople(transition, currentUser.getUserGroup().getCode(), task, currentUser.getEmail(), request, contentID);
	                }catch(Exception e){
	                	logger.error("Send mail error");
	                }
		        }
			}
		}catch(Exception e){
			logger.error("System error", e);
			return SYSTEM_ERROR;
		}
		
		return SEND_SUCCESS;
	}
	
	private void insertIntoSms(String phone, String message, Content content){
		Sms sms = new Sms();
		sms.setContent(content);
		sms.setMobileNumber(phone);
		sms.setSmsContent(message);
		sms.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		sms.setStatus(Constants.PENDING);
		try {
			smsService.save(sms);
		} catch (DuplicateException e) {
			logger.error("Can not insert to Sms Table", e);
		}
	}
	
	private void sendMail2RelatePeople(String transition, String userGroupCode, Task task, String senderMail, HttpServletRequest request, Long contentID){
    	String[] recipients = null;
    	String template = "content_approve_mail.vm";
    	String subject = this.getMessageSourceAccessor().getMessage("content.approve.mail.subject");
    	if(transition.equals("accept") || transition.equals("approve")){
    		String mail2NextGroupCode = "";
    		if(userGroupCode.equals(Constants.GROUP_AUTHOR)){
    			mail2NextGroupCode = Constants.GROUP_APPROVER;
    		}else if(userGroupCode.equals(Constants.GROUP_APPROVER)){
    			mail2NextGroupCode = Constants.GROUP_EDITOR;
    		}else if(userGroupCode.equals(Constants.GROUP_EDITOR)){
    			mail2NextGroupCode = Constants.GROUP_PUBLISHER;
    		}
    		List<User> recipientUsers = new ArrayList<User>();
    		if(StringUtils.isNotEmpty(mail2NextGroupCode)){
    			recipientUsers = userService.findByGroupCode(userGroupCode);
    		}else{
    			List<String> userNames = jbpmSpringService.getHistAssignee(task.getExecutionId());
        		recipientUsers = userService.findByListUserName(userNames);
    		}
    		
    		recipients = new String[recipientUsers.size()]; 
        	for(int i = 0; i < recipientUsers.size(); i++){
        		recipients[i] = recipientUsers.get(i).getEmail();
        	}
    	}else{
    		List<String> userNames = jbpmSpringService.getHistAssignee(task.getExecutionId());
    		List<User> recipientUsers = userService.findByListUserName(userNames);
    		recipients = new String[recipientUsers.size()]; 
    		for(int i = 0; i < recipientUsers.size(); i++){
    			recipients[i] = recipientUsers.get(i).getEmail();
    		}
    		template = "content_reject_mail.vm";
    		subject = this.getMessageSourceAccessor().getMessage("content.reject.mail.subject");
    	}
    	if(recipients != null && recipients.length > 0){
    		try{
    			HashMap<String, String> model = new HashMap<String, String>();
    	        model.put("targetUrl", RequestUtil.getAppURL(request)+ "/admin/content/view.html?pojo.contentID="+contentID);
    			mailEngine.sendMessage(recipients, senderMail, subject, template, model, null, null);
        	}catch(Exception e){
        		logger.error(e.getMessage(), e);
        	}
    	}
    }
	
	
	
	private static final String DECISION_APPROVED = "A";
	private static final String DECISION_REJECT = "R";
	/**
	 * Error codes
	 */
	private static final String SYSTEM_ERROR = "E00";
	private static final String PHONE_EMPTY = "E01";
	private static final String MESSAGE_EMPTY = "E02";
	private static final String PHONE_NOT_FOUND = "E03";
	private static final String MESSAGE_WRONG_SYNTAX = "E04";
	private static final String CONTENT_ID_NOT_NUMBER = "E05";
	private static final String CONTENT_NOT_FOUND = "E06";
	private static final String DECISION_WRONG_SYNTAX = "E07";
	private static final String NOT_HAVE_PERMISSION = "E08";
	private static final String SEND_SUCCESS = "E09";
	
	private static Map<String, String> errorDetailMap = new HashMap<String, String>();
	static{
		errorDetailMap.put(SYSTEM_ERROR, "System error");
		errorDetailMap.put(PHONE_EMPTY, "Phone empty");
		errorDetailMap.put(MESSAGE_EMPTY, "Message empty");
		errorDetailMap.put(PHONE_NOT_FOUND, "Phone not found");
		errorDetailMap.put(MESSAGE_WRONG_SYNTAX, "Message wrong syntax");
		errorDetailMap.put(CONTENT_ID_NOT_NUMBER, "Content ID must be a number");
		errorDetailMap.put(CONTENT_NOT_FOUND, "Content ID not found");
		errorDetailMap.put(DECISION_WRONG_SYNTAX, "Decision wrong syntax");
		errorDetailMap.put(NOT_HAVE_PERMISSION, "Do not have permission");
		errorDetailMap.put(SEND_SUCCESS, "This content perform successful");
	}
}
