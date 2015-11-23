package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.RenderingTemplateBean;
import com.banvien.portal.vms.domain.RenderingTemplate;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.RenderingTemplateService;
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
 * User: NhuKhang
 * Date: 10/6/12
 * Time: 11:25 AM
 */
@Component
public class RenderingTemplateValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(RenderingTemplateValidator.class);

    @Autowired
    private RenderingTemplateService renderingTemplateService;

    public boolean supports(Class<?> clazz) {
        return RenderingTemplateBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        RenderingTemplateBean bean = (RenderingTemplateBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean,errors);
    }

    private void validateRequiredValues(RenderingTemplateBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("renderingtemplate.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("renderingtemplate.name")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.templateContent", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("renderingtemplate.template")}, "non-empty value required.");
    }
    private void checkUnique(RenderingTemplateBean bean, Errors errors){
        try{
            RenderingTemplate renderingTemplate = renderingTemplateService.findByCode(bean.getPojo().getCode());

            if(bean.getPojo().getRenderingTemplateID() == null || (bean.getPojo().getRenderingTemplateID() != null && !renderingTemplate.getRenderingTemplateID().equals(bean.getPojo().getRenderingTemplateID()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("renderingtemplate.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }

}
