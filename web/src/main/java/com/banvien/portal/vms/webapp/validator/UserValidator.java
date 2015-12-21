package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.CommonUtil;
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
public class UserValidator extends ApplicationObjectSupport implements Validator {

    private transient final Log log = LogFactory.getLog(UserValidator.class);

    @Autowired
    private UserService userService;

    public boolean supports(Class<?> aClass) {
        return UserBean.class.isAssignableFrom(aClass);
    }
   /**
    * This method is called for validating Model Attribute
    */
    public void validate(Object o, Errors errors) {
        UserBean cmd = (UserBean)o;
        validateRequiredValues(cmd, errors);
        trimmingField(cmd);
        checkUnique(cmd, errors);
    }

    private void trimmingField(UserBean bean){
        if(StringUtils.isNotBlank(bean.getPojo().getUsername())){
            bean.getPojo().setUsername(bean.getPojo().getUsername().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getFirstName())){
            bean.getPojo().setFirstName(bean.getPojo().getFirstName().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getLastName())){
            bean.getPojo().setLastName(bean.getPojo().getLastName().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getEmail())){
            bean.getPojo().setEmail(bean.getPojo().getEmail().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getDisplayName())){
            bean.getPojo().setDisplayName(bean.getPojo().getDisplayName().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getMobileNumber())){
            bean.getPojo().setMobileNumber(bean.getPojo().getMobileNumber().trim());
        }
    }

    public void checkUnique(UserBean cmd, Errors errors){
        UserEntity user = userService.findByUserName(cmd.getPojo().getUsername());
        if(user != null && cmd.getPojo().getUserId() == null || (cmd.getPojo().getUserId() != null && (!user.getUserId().equals(cmd.getPojo().getUserId())))){
            errors.rejectValue("pojo.username", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("user.username")}, "is duplicate.");
        }

        try{
            UserEntity group = userService.findByEmail(cmd.getPojo().getEmail());
            if(cmd.getPojo().getUserId() == null || (cmd.getPojo().getUserId() != null && (!group.getUserId().equals(cmd.getPojo().getUserId())))){
                errors.rejectValue("pojo.email", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("user.email")}, "is duplicate.");
            }

        }catch (ObjectNotFoundException ex) {
            //User not exist
        }
    }

    private void validateRequiredValues(UserBean cmd, Errors errors) {
       ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.username", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("user.username")}, "non-empty value required.");
       ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.email", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("user.email")}, "non-empty value required.");
    }
}
