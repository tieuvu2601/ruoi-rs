package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.CategoryBean;
import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CategoryValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(CategoryValidator.class);

    @Autowired
    private CategoryService categoryService;

    public boolean supports(Class<?> clazz) {
        return CategoryBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        CategoryBean bean = (CategoryBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(CategoryBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.name")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.keyword", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.keyword")}, "non-empty value required.");
        if(bean.getPojo().getParentRootID() == null || bean.getPojo().getParentRootID() < 0){
            bean.getPojo().setParentRootID(null);
        }

        if(bean.getPojo().getParentCategory() == null || bean.getPojo().getParentCategory().getCategoryID() == null || bean.getPojo().getParentCategory().getCategoryID() < 0){
            bean.getPojo().setParentCategory(null);
        }
    }

    private void checkUnique(CategoryBean bean, Errors errors){
        try{
            Category category = categoryService.findByCode(bean.getPojo().getCode());

            if(bean.getPojo().getCategoryID() == null || (bean.getPojo().getAuthoringTemplate() != null && !category.getCategoryID().equals(bean.getPojo().getCategoryID()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("category.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
