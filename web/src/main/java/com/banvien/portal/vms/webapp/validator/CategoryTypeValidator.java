package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.CategoryTypeBean;
import com.banvien.portal.vms.domain.CategoryTypeEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryTypeService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CategoryTypeValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(CategoryTypeValidator.class);

    @Autowired
    private CategoryTypeService categoryTypeService;

    public boolean supports(Class<?> clazz) {
        return CategoryTypeBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        CategoryTypeBean bean = (CategoryTypeBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(CategoryTypeBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.type.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("category.type.name")}, "non-empty value required.");
    }

    private void checkUnique(CategoryTypeBean bean, Errors errors){
        try{
            CategoryTypeEntity category = categoryTypeService.findByCode(bean.getPojo().getCode());
            if(category.getCategoryTypeId() != null &&category.getCategoryTypeId() > 0 && category.getCategoryTypeId() != bean.getPojo().getCategoryTypeId()){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("category.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
