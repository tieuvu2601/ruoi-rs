package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.LocationBean;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.LocationService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class LocationValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(LocationValidator.class);

    @Autowired
    private LocationService categoryService;

    public boolean supports(Class<?> clazz) {
        return LocationBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        LocationBean bean = (LocationBean)target;
        validateRequiredValues(bean, errors);

    }

    private void validateRequiredValues(LocationBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.name")}, "non-empty value required.");
        if(bean.getPojo().getDisplayOrder() == null){
            bean.getPojo().setDisplayOrder(1);
        }

        if(bean.getPojo().getParent() == null || bean.getPojo().getParent().getLocationId() == null || bean.getPojo().getParent().getLocationId() < 0){
            bean.getPojo().setParent(null);
        }
    }
}
