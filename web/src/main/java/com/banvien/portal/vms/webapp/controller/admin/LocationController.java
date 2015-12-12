package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.LocationBean;
import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;
import com.banvien.portal.vms.service.LocationService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.LocationValidator;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LocationController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private LocationService locationService;

    @Autowired
    private LocationValidator locationValidator;

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(AuthoringTemplateEntity.class, new PojoEditor(AuthoringTemplateEntity.class, "authoringTemplateId", Long.class));
	}

    @RequestMapping("/admin/location/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) LocationBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/location/edit");
        String crudaction = bean.getCrudaction();
        LocationEntity pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                locationValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getLocationId() != null && pojo.getLocationId() >0 ){
                        pojo = this.locationService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }else{
                        pojo = this.locationService.save(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    bean.setPojo(pojo);
                    mav.addObject("success", true);
                }
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && bean.getPojo().getLocationId() != null){
            try{
                bean.setPojo(locationService.findById(bean.getPojo().getLocationId()));
            }catch (ObjectNotFoundException oe) {
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        referenceData(mav);
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

    @RequestMapping(value={"/admin/location/list.html"})
    public ModelAndView list(LocationBean bean, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/location/list");
        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = locationService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }
        executeSearch(bean, request);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        referenceData(mav);
        return mav;
    }
    


    private void executeSearch(LocationBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            properties.put("code", bean.getPojo().getCode());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            properties.put("name", bean.getPojo().getName());
        }
        if(bean.getPojo().getParent() != null && bean.getPojo().getParent().getLocationId() != null && bean.getPojo().getParent().getLocationId() > 0){
            properties.put("parent.locationId", bean.getPojo().getParent().getLocationId());
        }
        Object[] results = this.locationService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<LocationEntity>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }

    private void referenceData(ModelAndView mav) {

    }
}
