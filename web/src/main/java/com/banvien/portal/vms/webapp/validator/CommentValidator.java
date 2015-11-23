package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.CommentBean;
import com.banvien.portal.vms.service.CommentService;
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
public class CommentValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(CommentValidator.class);

    @Autowired
    private CommentService commentService;

    public boolean supports(Class<?> clazz) {
        return CommentBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        CommentBean bean = (CommentBean)target;
        validateRequiredValues(bean, errors);
    }

    private void validateRequiredValues(CommentBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.contentid", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("comment.contentid")}, "non-empty value required.");
    }

}
