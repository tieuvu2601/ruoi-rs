package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.RoleBean;
import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.RoleService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class RoleValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(RoleValidator.class);

    @Autowired
    private RoleService roleService;

    public boolean supports(Class<?> clazz) {
        return RoleBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        RoleBean bean = (RoleBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(RoleBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.role", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("role.role")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("role.name")}, "non-empty value required.");
    }

    private void checkUnique(RoleBean bean, Errors errors){
        try{
            RoleEntity roleEntity = roleService.findByRole(bean.getPojo().getRole());

            if(bean.getPojo().getRoleId() == null || (bean.getPojo().getRoleId() != null && !roleEntity.getRoleId().equals(bean.getPojo().getRoleId()))){
                errors.rejectValue("pojo.roleEntity", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("role.form.role")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
