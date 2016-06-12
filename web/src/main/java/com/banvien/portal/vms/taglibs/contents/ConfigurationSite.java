package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.service.ConfigurationService;
import com.banvien.portal.vms.service.LocationService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

public class ConfigurationSite extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            ConfigurationService configurationService = context.getBean(ConfigurationService.class);
            ConfigurationEntity configurationEntity = configurationService.getConfigurationSite();
            this.pageContext.setAttribute(this.var, configurationEntity);
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String var;

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
