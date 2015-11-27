package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.FeedbackCategoryBean;
import com.banvien.portal.vms.domain.FeedbackCategory;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.FeedbackCategoryService;
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
public class FeedbackCategoryValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(FeedbackCategoryValidator.class);

    @Autowired
    private FeedbackCategoryService feedbackCategoryService;

    public boolean supports(Class<?> clazz) {
        return FeedbackCategoryBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        FeedbackCategoryBean bean = (FeedbackCategoryBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(FeedbackCategoryBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("feedbackcategory.name")}, "non-empty value required.");
    }

    private void checkUnique(FeedbackCategoryBean bean, Errors errors){
        try{
            FeedbackCategory category = feedbackCategoryService.findByName(bean.getPojo().getName());

            if(bean.getPojo().getFeedbackCategoryID() == null || (!category.getFeedbackCategoryID().equals(bean.getPojo().getFeedbackCategoryID()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("category.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
