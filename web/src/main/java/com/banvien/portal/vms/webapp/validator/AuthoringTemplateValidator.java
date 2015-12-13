package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.AuthoringTemplateBean;
import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;
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
public class AuthoringTemplateValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(AuthoringTemplateValidator.class);

    @Autowired
    private AuthoringTemplateService authoringTemplateService;

    public boolean supports(Class<?> clazz) {
        return AuthoringTemplateBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        AuthoringTemplateBean bean = (AuthoringTemplateBean)target;
        validateRequiredValues(bean, errors);
        trimminField(bean);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(AuthoringTemplateBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("authoringtemplate.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("authoringtemplate.name")}, "non-empty value required.");
        if(bean.getPojo().getAreProduct() == null){
            bean.getPojo().setAreProduct(0);
        }
    }

    private void trimminField(AuthoringTemplateBean bean){
        if(StringUtils.isNotBlank(bean.getPojo().getCode())){
            bean.getPojo().setCode(bean.getPojo().getCode().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getName())){
            bean.getPojo().setName(bean.getPojo().getName().trim());
        }
    }

    private void checkUnique(AuthoringTemplateBean bean, Errors errors){
        try{
            AuthoringTemplateEntity authoringTemplate = authoringTemplateService.findByCode(bean.getPojo().getCode());
            if(bean.getPojo().getAuthoringTemplateId() == null || (bean.getPojo().getAuthoringTemplateId() != null && !authoringTemplate.getAuthoringTemplateId().equals(bean.getPojo().getAuthoringTemplateId()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("authoringtemplate.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) { }
    }


}
