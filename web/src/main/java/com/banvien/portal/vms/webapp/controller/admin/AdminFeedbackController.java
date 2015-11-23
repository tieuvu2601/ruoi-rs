package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.FeedbackBean;
import com.banvien.portal.vms.bean.FeedbackReplyBean;
import com.banvien.portal.vms.domain.Feedback;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.FeedbackReply;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.FeedbackCategoryService;
import com.banvien.portal.vms.service.FeedbackReplyService;
import com.banvien.portal.vms.service.FeedbackService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.FeedbackReplyValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class AdminFeedbackController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private FeedbackReplyService feedbackReplyService;

    @Autowired
    private FeedbackReplyValidator feedbackReplyValidator;

    @Autowired
    private FeedbackCategoryService feedbackCategoryService;
   

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Timestamp.class, new CustomDateEditor());
    }

    @RequestMapping("/admin/feedback/reply.html")
    public ModelAndView reply(@ModelAttribute(Constants.FORM_MODEL_KEY) FeedbackReplyBean bean, BindingResult bindingResult, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/feedback/reply");
        String crudaction = bean.getCrudaction();
        FeedbackReply pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("reply")) {
            try{
                feedbackReplyValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getFeedbackReplyID() != null && pojo.getFeedbackReplyID() >0 ){
                        this.feedbackReplyService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        User user = new User();
                        user.setUserID(SecurityUtils.getLoginUserId());
                        pojo.setCreatedBy(user);
                        pojo.setFeedback(bean.getFeedback());
                        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                        this.feedbackReplyService.saveItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getFeedback() != null){
            //Load feedback and feedback reply
            executeSearchFeedBackReply(bean, request);
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/feedback/list.html"})
    public ModelAndView list(FeedbackBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/feedback/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = feedbackService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        mav.addObject("feedbackCategories", feedbackCategoryService.findAll());
        return mav;
    }
    
    
    private void executeSearch(FeedbackBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            properties.put("title", bean.getPojo().getTitle());
        }
        if (bean.getPojo().getStatus() != null) {
            properties.put("status", bean.getPojo().getStatus());
        }
        if (bean.getPojo().getDepartment() != null) {
            properties.put("department.departmentID", bean.getPojo().getDepartment().getDepartmentID());
        }
        if (bean.getPojo().getFeedbackCategory() != null) {
            properties.put("feedbackCategory.feedbackCategoryID", bean.getPojo().getFeedbackCategory().getFeedbackCategoryID());
        }
        Object[] results = this.feedbackService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Feedback>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void executeSearchFeedBackReply(FeedbackReplyBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();

        try
        {
            Feedback feedback = feedbackService.findById(bean.getPojo().getFeedback().getFeedbackID());
            if(bean.getPojo().getFeedback() != null && bean.getPojo().getFeedback().getFeedbackID() > 0)
            {
                properties.put("feedback.feedbackID", bean.getPojo().getFeedback().getFeedbackID());
            }
            Object[] results = this.feedbackReplyService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
            bean.setListResult((List<FeedbackReply>)results[1]);
            bean.setTotalItems(Integer.valueOf(results[0].toString()));
            bean.setFeedback(feedback);
        }
        catch (ObjectNotFoundException ex)
        {
            ex.printStackTrace();
        }
    }
    
}
