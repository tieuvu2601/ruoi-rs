package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.FeedbackCategoryBean;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.*;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.FeedbackCategoryValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
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
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 10:57 AM
 */
@Controller
public class FeedbackCategoryController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private FeedbackCategoryService feedbackCategoryService;

    @Autowired
    private FeedbackCategoryValidator feedbackCategoryValidator;

   

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
    }

    @RequestMapping("/admin/feedbackcategory/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) FeedbackCategoryBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/feedbackcategory/edit");
        String crudaction = bean.getCrudaction();
        FeedbackCategory pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                feedbackCategoryValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getFeedbackCategoryID() != null && pojo.getFeedbackCategoryID() >0 ){
                        this.feedbackCategoryService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        this.feedbackCategoryService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getFeedbackCategoryID() != null){
            try{
                bean.setPojo(feedbackCategoryService.findById(bean.getPojo().getFeedbackCategoryID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/feedbackcategory/list.html"})
    public ModelAndView list(FeedbackCategoryBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/feedbackcategory/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = feedbackCategoryService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }
    
    
    private void executeSearch(FeedbackCategoryBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        Object[] results = this.feedbackCategoryService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<FeedbackCategory>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
    
}
