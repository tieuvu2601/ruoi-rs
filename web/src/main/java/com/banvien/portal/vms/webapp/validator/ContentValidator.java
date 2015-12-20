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
        if(StringUtils.isNotBlank(bean.getPojo().getHeader())){
            bean.getPojo().setHeader(bean.getPojo().getHeader().trim());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getTitle())){
            bean.getPojo().setTitle(bean.getPojo().getTitle().replaceAll("-", " ").trim());
        }

        if(StringUtils.isNotBlank(bean.getPojo().getKeyword())){
            bean.getPojo().setKeyword(bean.getPojo().getKeyword().trim().toLowerCase());
        }

        if(bean.getPojo().getDisplayOrder() == null){
            bean.getPojo().setDisplayOrder(0);
        }

        if(bean.getPojo().getHotItem() == null){
            bean.getPojo().setHotItem(0);
        }

        if(bean.getPojo().getSlide() == null){
            bean.getPojo().setSlide(0);
        }

        if(bean.getPojo().getProductStatus() == null){
            bean.getPojo().setProductStatus(0);
        }

        if(bean.getPojo().getLocation() == null || bean.getPojo().getLocation().getLocationId() == null || bean.getPojo().getLocation().getLocationId() < 0){
            bean.getPojo().setLocation(null);
        }
    }

    private void validateRequiredValues(ContentBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.header", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("content.header")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.title", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("content.title.title")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.keyword", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("content.keyword")}, "non-empty value required.");
    }

    public void checkUnique(ContentBean cmd, Errors errors){
        try{
            ContentEntity content = contentService.findByTitle(cmd.getPojo().getTitle());

            if(content != null && content.getContentId() != null && content.getContentId() > 0 && !content.getContentId().equals(cmd.getPojo().getContentId())){
                errors.rejectValue("pojo.title", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("content.title.title")}, "Value has been chosen.");
            }

        }catch (ObjectNotFoundException ex) {
            //User group not exist
        }
    }
}
