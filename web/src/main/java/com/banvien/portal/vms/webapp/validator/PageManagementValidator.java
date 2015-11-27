package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.PageBean;
import com.banvien.portal.vms.domain.Page;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.PageService;
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
public class PageManagementValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(PageManagementValidator.class);

    @Autowired
    private PageService pageService;

    public boolean supports(Class<?> clazz) {
        return PageBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        PageBean bean = (PageBean)target;
        validateRequiredValues(bean, errors);
        checkUnique(bean, errors);
    }

    private void validateRequiredValues(PageBean bean, Errors errors){
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.code", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("page.code")}, "non-empty value required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.title", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("page.title")}, "non-empty value required.");
    }

    private void checkUnique(PageBean bean, Errors errors){
        try{
            Page page = pageService.findByPage(bean.getPojo().getCode());

            if(bean.getPojo().getPageID() == null || (bean.getPojo().getPageID() != null && !page.getPageID().equals(bean.getPojo().getPageID()))){
                errors.rejectValue("pojo.code", "error.duplicated", new String[] {this.getMessageSourceAccessor().getMessage("page.code")}, "Value has been chosen.");
            }
        }catch (ObjectNotFoundException ex) {
         //Object not found
        }
    }
}
