package com.banvien.portal.vms.util;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.task.Task;
import org.springframework.context.support.ApplicationObjectSupport;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.service.MailEngine;
import com.banvien.portal.vms.service.UserService;

public class JbpmUtils extends ApplicationObjectSupport{
	
	private final static Log log = LogFactory.getLog(JbpmUtils.class);
	
	public static ProcessInstance startProcess(JbpmSpringService jbpmSpringService, User user, Long contentID){
		String userGroupCode = user.getUserGroup().getCode();
		if(StringUtils.isNotEmpty(userGroupCode)){
			String processKey = "";
			if(userGroupCode.equals(Constants.GROUP_AUTHOR)){
				processKey = Constants.CONTENT_PAGEFLOW_PROCESS_KEY;
			}else if(userGroupCode.equals(Constants.GROUP_EDITOR)){
				processKey = Constants.EDITOR_PAGEFLOW_PROCESS_KEY;
			}else if(userGroupCode.equals(Constants.GROUP_APPROVER)){
				processKey = Constants.APPROVER_PAGEFLOW_PROCESS_KEY;
			}else if(userGroupCode.equals(Constants.GROUP_PUBLISHER)){
				processKey = Constants.PUBLISHER_PAGEFLOW_PROCESS_KEY;
			}
			if(StringUtils.isNotEmpty(processKey)){
				return jbpmSpringService.startProcess(processKey, contentID.toString());
			}
		}
		return null;
	}
	
	public static Task runProcess(JbpmSpringService jbpmSpringService, ContentService contentService, User user, Content content, String decision){
		return assignAddExecute(jbpmSpringService, contentService, user, content, decision, null);
	}

    public static Task runProcess(JbpmSpringService jbpmSpringService, ContentService contentService, User user, Content content, String decision, Timestamp publishedDate){
		return assignAddExecute(jbpmSpringService, contentService, user, content, decision, publishedDate);
	}
	
	private static Task assignAddExecute(JbpmSpringService jbpmSpringService, ContentService contentService, User user, Content content, String transitionName, Timestamp publishedDate){
		if (publishedDate == null) {
            publishedDate = new Timestamp(System.currentTimeMillis());
        }
        if(content.getCreatedBy().getUserID().equals(user.getUserID()) && transitionName.equals("reject")){
			return null;
		}
		if(!content.getCreatedBy().getUserID().equals(user.getUserID()) && transitionName.equals("accept") && user.getUserGroup().getCode().equals(Constants.GROUP_PUBLISHER)){ 
			return null;
		}
		boolean isUpdated = false;
		Task currentTask = null;
		List<Task> taskInstances = jbpmSpringService.getTaskListOfGroupOfUser(user.getUsername());
		for(Task task : taskInstances){
			String processID = task.getExecutionId();
            Long contentID = Long.valueOf(processID.split("\\.")[1]);
			if(contentID.equals(content.getContentID())){
				if(StringUtils.isEmpty(task.getAssignee())){  
                    jbpmSpringService.assignTask2User(task, user.getUsername());
                }
				jbpmSpringService.completeTask(task.getId(), transitionName);
				
    			isUpdated = true;
    			currentTask = task;
				break;
			}
		}
		
		if(isUpdated){
			try {
				content.setModifiedDate(new Timestamp(System.currentTimeMillis()));
				content.setModifiedBy(user);
				if(transitionName.equals("accept") && (user.getUserGroup().getCode().equals(Constants.GROUP_APPROVER) || user.getUserGroup().getCode().equals(Constants.GROUP_PUBLISHER) )){
					content.setStatus(Constants.CONTENT_PUBLISH);
					content.setPublishedDate(publishedDate);
				}else if(transitionName.equals("reject")){
					content.setStatus(Constants.CONTENT_REJECT);
				}
				
				contentService.update(content);
				
			} catch (Exception e) {
				log.error("JbpmUtils.java - Update content error", e);
			}
			
			return currentTask;
		}
		return null;
	}
}
