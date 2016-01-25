package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.LocationService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

public class BuildingLocations extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            LocationService locationService = context.getBean(LocationService.class);
            List<LocationEntity>  locations = locationService.findAll();
            if(locations != null) {
                this.pageContext.setAttribute(this.var, locations);
            }
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
