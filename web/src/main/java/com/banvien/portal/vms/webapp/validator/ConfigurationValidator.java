package com.banvien.portal.vms.webapp.validator;

import com.banvien.portal.vms.bean.ConfigurationBean;
import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.ConfigurationService;
import com.banvien.portal.vms.service.ConfigurationService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ConfigurationValidator extends ApplicationObjectSupport implements Validator {
    private transient final Log log = LogFactory.getLog(ConfigurationValidator.class);

    @Autowired
    private ConfigurationService configurationService;

    public boolean supports(Class<?> clazz) {
        return ConfigurationBean.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        ConfigurationBean bean = (ConfigurationBean)target;
        trimmingField(bean);
//        validateRequiredValues(bean, errors);
    }

    private void trimmingField(ConfigurationBean bean){
        if(StringUtils.isNotBlank(bean.getPojo().getAboutMe())){
            bean.getPojo().setAboutMe(bean.getPojo().getAboutMe().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getCustomCSS())){
            bean.getPojo().setCustomCSS(bean.getPojo().getCustomCSS().trim());
        }
        if(StringUtils.isNotBlank(bean.getPojo().getHotLine())){
            bean.getPojo().setHotLine(bean.getPojo().getHotLine().trim());
        }
    }

//    private void validateRequiredValues(ConfigurationBean bean, Errors errors){
//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pojo.email", "errors.required", new String[]{this.getMessageSourceAccessor().getMessage("customer.email")}, "non-empty value required.");
//    }


}
