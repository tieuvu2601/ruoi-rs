package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.FeedbackBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 5/2/13
 * Time: 11:54 AM
 */
@Component
public class FeedbackValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(FeedbackReplyValidator.class);

     public boolean supports(Class<?> clazz) {
        return FeedbackBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        FeedbackBean bean = (FeedbackBean)target;
        validateRequiredValues(bean, errors);
    }

    private void validateRequiredValues(FeedbackBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.department", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedback.department")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.feedbackCategory", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedback.feedbackcategory")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.title", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedback.title")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.content", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedback.content")}, "non-empty value required.");
    }
   
}
