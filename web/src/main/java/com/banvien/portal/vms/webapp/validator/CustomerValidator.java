package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.CustomerBean;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CustomerService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CustomerValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(CustomerValidator.class);

    @Autowired
    private CustomerService customerService;

    public boolean supports(Class<?> clazz) {
        return CustomerBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        CustomerBean bean = (CustomerBean)target;
        trimmingField(bean);
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void trimmingField(CustomerBean bean){
        if(StringUtils.isNotBlank(bean.getPojo().getFullName())){
            bean.getPojo().setFullName(bean.getPojo().getFullName().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getEmail())){
            bean.getPojo().setEmail(bean.getPojo().getEmail().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getPhoneNumber())){
            bean.getPojo().setPhoneNumber(bean.getPojo().getPhoneNumber().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getAddress())){
            bean.getPojo().setAddress(bean.getPojo().getAddress().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getDescription())){
            bean.getPojo().setDescription(bean.getPojo().getDescription().trim());
        }

    }

    private void validateRequiredValues(CustomerBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.email", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("customer.email")}, "non-empty value required.");
    }

    private void checkUnique(CustomerBean bean, Errors errors){
        try{
            CustomerEntity role = customerService.findByEmail(bean.getPojo().getEmail());

            if(bean.getPojo().getCustomerId() == null || (bean.getPojo().getCustomerId() != null && !role.getCustomerId().equals(bean.getPojo().getCustomerId()))){
                errors.rejectValue("pojo.email", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("customer.email")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) { }
    }
}
