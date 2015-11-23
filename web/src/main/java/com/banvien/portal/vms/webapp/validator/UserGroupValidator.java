package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.UserGroupBean;
import com.banvien.portal.vms.domain.UserGroup;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserGroupService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Created with IntelliJ IDEA.
 * User: BV-Dev1
 * Date: 10/6/12
 * Time: 1:12 PM
 * To change this template use File | Settings | File Templates.
 */
@Component
public class UserGroupValidator extends ApplicationObjectSupport implements Validator {

    private transient final Log log = LogFactory.getLog(UserGroupValidator.class);

        @Autowired
        private UserGroupService userGroupService;

       public boolean supports(Class<?> aClass) {
           return UserGroupBean.class.isAssignableFrom(aClass);
       }
       /**
        * This method is called for validating Model Attribute
        */
       public void validate(Object o, Errors errors) {
           UserGroupBean cmd = (UserGroupBean)o;
           trimingField(cmd);
           validateRequiredValues(cmd, errors);
           checkUnique(cmd, errors);
       }

        public void checkUnique(UserGroupBean cmd, Errors errors){
            try{
                UserGroup group = userGroupService.findByCode(cmd.getPojo().getCode());
                if(cmd.getPojo().getUserGroupID() == null || (cmd.getPojo().getUserGroupID() != null && (!group.getUserGroupID().equals(cmd.getPojo().getUserGroupID())))){
                    errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("usergroup.form.code")}, "Value has been chosen.");
                }

            }catch (ObjectNotFoundException ex) {
                //User group not exist
            }
        }

       private void validateRequiredValues(UserGroupBean cmd, Errors errors) {
           ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("usergroup.form.code")}, "non-empty value required.");
           ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("usergroup.form.name")}, "non-empty value required.");
       }

       private void trimingField(UserGroupBean cmd) {
            if(StringUtils.isNotEmpty(cmd.getPojo().getCode())) {
                cmd.getPojo().setCode(cmd.getPojo().getCode().trim());
            }
           if(StringUtils.isNotEmpty(cmd.getPojo().getName())) {
               cmd.getPojo().setName(cmd.getPojo().getName().trim());
           }
       }

}
