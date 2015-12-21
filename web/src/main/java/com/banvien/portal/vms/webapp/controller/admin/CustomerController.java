package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.CustomerBean;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.CustomerService;
import com.banvien.portal.vms.service.LocationService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.CustomerValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CustomerController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private CustomerService customerService;

    @Autowired
    private LocationService locationService;

    @Autowired
    private CustomerValidator customerValidator;

    @RequestMapping("/admin/customer/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) CustomerBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/customer/edit");
        String crudaction = bean.getCrudaction();
        CustomerEntity pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                customerValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getCustomerId() != null && pojo.getCustomerId() >0 ){
                        pojo = this.customerService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }
                    else {
                        UserEntity createdBy = new UserEntity();
                        createdBy.setUserId(SecurityUtils.getLoginUserId());
                        pojo.setCreatedBy(createdBy);
                        pojo = this.customerService.saveItem(pojo);
                  		mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                    bean.setPojo(pojo);
                }
            }catch(ObjectNotFoundException oe){
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors() && pojo.getCustomerId() != null){
            try{
                bean.setPojo(customerService.findById(pojo.getCustomerId()));
            }catch (ObjectNotFoundException ex) {
                logger.error(ex.getMessage(), ex);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.exception.keynotfound"));
            }
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        referenceData(mav);
        return mav;
    }

    @RequestMapping(value={"/admin/customer/list.html"})
    public ModelAndView list(CustomerBean bean, HttpServletRequest request) {
    	ModelAndView mav = new ModelAndView("/admin/customer/list");

        if(StringUtils.isNotBlank(bean.getCrudaction()) && bean.getCrudaction().equals(Constants.ACTION_DELETE)) {
            Integer totalDeleted = 0;
            try {
                totalDeleted = customerService.deleteItems(bean.getCheckList());
            	mav.addObject("totalDeleted", totalDeleted);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.delete.successful", new String[]{totalDeleted.toString(), String.valueOf(bean.getCheckList().length)}));
            }catch (Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject(Constants.MESSAGE_RESPONSE_MODEL_KEY, this.getMessageSourceAccessor().getMessage("database.multipledelete.exception"));
            }
        }

        executeSearch(bean, request);
        referenceData(mav);
        mav.addObject(Constants.LIST_MODEL_KEY, bean);
        return mav;
    }

    private void referenceData(ModelAndView mav){
        mav.addObject("locations", this.locationService.findAll());
    }

    private void executeSearch(CustomerBean bean, HttpServletRequest request) {
        RequestUtil.initSearchBean(request, bean);
        Map<String, Object> properties = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(bean.getPojo().getFullName())){
            properties.put("pojo.fullName", bean.getPojo().getFullName());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getEmail())){
            properties.put("pojo.email", bean.getPojo().getEmail());
        }
        if(bean.getPojo().getLocation() != null && bean.getPojo().getLocation().getLocationId() != null && bean.getPojo().getLocation().getLocationId() > 0){
            properties.put("pojo.location.locationId", bean.getPojo().getLocation());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getAddress())){
            properties.put("pojo.address", bean.getPojo().getAddress());
        }
        Object[] results = this.customerService.searchByProperties(properties, bean.getSortExpression(), bean.getSortDirection(), bean.getFirstItem(), bean.getMaxPageItems());
        bean.setListResult((List<CustomerEntity>)results[1]);
        bean.setTotalItems(Integer.valueOf(results[0].toString()));
    }
}
