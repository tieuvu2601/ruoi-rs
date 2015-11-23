package com.banvien.portal.vms.webapp.controller.admin;


import com.banvien.portal.vms.bean.OpinionBean;
import com.banvien.portal.vms.domain.Opinion;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.OpinionService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.OpinionValidator;
import com.banvien.portal.vms.webapp.validator.UserGroupValidator;
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


@Controller
public class OpinionController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private OpinionService opinionService;

    @Autowired
    private OpinionValidator opinionValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Timestamp.class, new CustomDateEditor());
	}

    @RequestMapping(value = "/dong-gop-y-kien.html")
    public ModelAndView dongGopYKien(@ModelAttribute(Constants.FORM_MODEL_KEY) OpinionBean bean, BindingResult bindingResult) throws DuplicateException {
        ModelAndView mav = new ModelAndView("/web/page/donggopykien");

        String crudaction = bean.getCrudaction();

        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert")){
            try{
                opinionValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    Opinion pojo = bean.getPojo();
                    Timestamp now = new Timestamp(System.currentTimeMillis());
                    pojo.setStatus(0);
                    pojo.setCreatedDate(now);
                    this.opinionService.save(pojo);
                    mav = new ModelAndView("redirect:/index.html");
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        return mav;
    }

    @RequestMapping("/admin/opinion/view.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) OpinionBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/opinion/edit");
        String crudaction = bean.getCrudaction();
        Opinion pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("resolved")) {
            try{
                opinionValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    pojo.setStatus(1);
                    pojo.setUserID(SecurityUtils.getLoginUserId());
                    this.opinionService.updateItem(pojo);
                    mav = new ModelAndView("redirect:/admin/opinion/list.html");
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getOpinionID() != null){

            try{
                bean.setPojo(opinionService.findById(bean.getPojo().getOpinionID()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }
//
    @RequestMapping(value={"/admin/opinion/list.html"})
    public ModelAndView list(OpinionBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/opinion/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
//                totalDeleted = opinionService.deleteAll(bean.getCheckList());
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
//
    private void executeSearch(OpinionBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            properties.put("name", bean.getPojo().getTitle());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getUserName())){
            properties.put("userName", bean.getPojo().getUserName());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getEmail())){
            properties.put("email", bean.getPojo().getEmail());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getPhoneNumber())){
            properties.put("phoneNumber", bean.getPojo().getPhoneNumber());
        }

        if(bean.getPojo().getStatus() != null && bean.getPojo().getStatus() >= 0){
            properties.put("status", bean.getPojo().getStatus());
        }


        Object[] results = this.opinionService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<Opinion>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
