package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.OpinionBean;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
public class OpinionValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(OpinionValidator.class);

    public boolean supports(Class<?> clazz) {
        return OpinionBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        OpinionBean bean = (OpinionBean)target;
        validateRequiredValues(bean, errors);
    }

    private void validateRequiredValues(OpinionBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.userName", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("site.opinion.name")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.title", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("site.opinion.title")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.email", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("site.opinion.email")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.description", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("site.opinion.content")}, "non-empty value required.");
    }
}
