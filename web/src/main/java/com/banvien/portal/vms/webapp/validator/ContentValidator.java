package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.ContentService;
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
public class ContentValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(ContentValidator.class);

    @Autowired
    private ContentService contentService;

    public boolean supports(Class<?> clazz) {
        return ContentBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        ContentBean bean = (ContentBean)target;
        trimmingField(bean);
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void trimmingField(ContentBean bean){
        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            bean.getPojo().setTitle(bean.getPojo().getTitle().replaceAll("-", " ").trim().toLowerCase());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getKeyword())){
            bean.getPojo().setKeyword(bean.getPojo().getKeyword().trim().toLowerCase());
        }

        if(bean.getPojo().getDisplayOrder() == null){
            bean.getPojo().setDisplayOrder(0);
        }
    }

    private void validateRequiredValues(ContentBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.title", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("content.title")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.keyword", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("content.keyword")}, "non-empty value required.");
    }

    public void checkUnique(ContentBean cmd, Errors errors){
        try{
            ContentEntity contentEntity = contentService.findByTitle(cmd.getPojo().getTitle());

            if(contentEntity != null && contentEntity.getContentId() != null && contentEntity.getContentId() > 0 && !contentEntity.getContentId().equals(cmd.getPojo().getContentId())){
                errors.rejectValue("pojo.title", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("content.title")}, "Value has been chosen.");
            }

        }catch (ObjectNotFoundException ex) {
            //UserEntity group not exist
        }
    }
}
