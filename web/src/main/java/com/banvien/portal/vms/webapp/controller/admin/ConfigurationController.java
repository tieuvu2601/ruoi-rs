package com.banvien.portal.vms.webapp.controller.admin;

import com.banvien.portal.vms.bean.ConfigurationBean;
import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.editor.CustomDateEditor;
import com.banvien.portal.vms.editor.PojoEditor;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.security.SecurityUtils;
import com.banvien.portal.vms.service.ConfigurationService;
import com.banvien.portal.vms.service.ConfigurationService;
import com.banvien.portal.vms.service.LocationService;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.Constants;
import com.banvien.portal.vms.util.RequestUtil;
import com.banvien.portal.vms.webapp.validator.ConfigurationValidator;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ConfigurationController extends ApplicationObjectSupport {
	private transient final Logger logger = Logger.getLogger(getClass());

    @Autowired
    private ConfigurationService configurationService;

    @Autowired
    private ConfigurationValidator configurationValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new CustomDateEditor());
        binder.registerCustomEditor(UserEntity.class, new PojoEditor(UserEntity.class, "userId", Long.class));
        binder.registerCustomEditor(LocationEntity.class, new PojoEditor(LocationEntity.class, "locationId", Long.class));
    }

    @RequestMapping("/admin/configuration/edit.html")
    public ModelAndView edit(@ModelAttribute(Constants.FORM_MODEL_KEY) ConfigurationBean bean, BindingResult bindingResult){
        ModelAndView mav = new ModelAndView("/admin/configuration/edit");
        String crudaction = bean.getCrudaction();
        ConfigurationEntity pojo = bean.getPojo();
        if(StringUtils.isNotBlank(crudaction) && crudaction.equals("insert-update")) {
            try{
                configurationValidator.validate(bean, bindingResult);
                if(!bindingResult.hasErrors()){
                    if(pojo.getConfigurationId() != null && pojo.getConfigurationId() >0 ){
                        pojo = this.configurationService.updateItem(pojo);
                        mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.update.successful"));
                    }
                    else {
                        pojo = this.configurationService.saveItem(pojo);
                  		mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("database.add.successful"));
                    }
                    mav.addObject("success", true);
                    bean.setPojo(pojo);
                }
            }catch(ObjectNotFoundException oe){
                logger.error(oe.getMessage(), oe);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }catch(Exception e) {
                logger.error(e.getMessage(), e);
                mav.addObject("messageResponse", this.getMessageSourceAccessor().getMessage("general.exception.msg"));
            }
        }
        if(!bindingResult.hasErrors()){
            ConfigurationEntity configuration = configurationService.getConfigurationSite();
            bean.setPojo(configuration);
        }
        mav.addObject(Constants.FORM_MODEL_KEY, bean);
        return mav;
    }

}
