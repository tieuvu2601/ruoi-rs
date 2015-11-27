package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.DepartmentBean;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.DepartmentService;
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
public class DepartmentValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(DepartmentValidator.class);

    @Autowired
    private DepartmentService departmentService;

    public boolean supports(Class<?> clazz) {
        return DepartmentBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        DepartmentBean bean = (DepartmentBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean,errors);
    }

    private void validateRequiredValues(DepartmentBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("department.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.name", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("department.name")}, "non-empty value required.");
    }
    private void checkUnique(DepartmentBean bean, Errors errors){
        try{
            Department department = departmentService.findByCode(bean.getPojo().getCode());

            if(bean.getPojo().getDepartmentID() == null || (bean.getPojo().getDepartmentID() != null && !department.getDepartmentID().equals(bean.getPojo().getDepartmentID()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("department.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
