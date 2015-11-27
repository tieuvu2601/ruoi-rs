package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.FeedbackReplyBean;
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
public class FeedbackReplyValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(FeedbackReplyValidator.class);

     public boolean supports(Class<?> clazz) {
        return FeedbackReplyBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        FeedbackReplyBean bean = (FeedbackReplyBean)target;
        validateRequiredValues(bean, errors);
    }

    private void validateRequiredValues(FeedbackReplyBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.content", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedbackreply.content")}, "non-empty value required.");
    }

   
}
