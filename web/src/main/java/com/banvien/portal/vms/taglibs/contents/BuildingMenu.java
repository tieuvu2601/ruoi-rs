package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.service.CategoryService;

import com.banvien.portal.vms.util.CategoryUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

public class BuildingMenu extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            CategoryService categoryService = context.getBean(CategoryService.class);
            List<CategoryEntity>  categories = categoryService.findAllCategoryParent();
//            List<CategoryObjectDTO> categoryObjects = CategoryUtil.getAllCategoryObjectInSite(categories);
            if(categories != null) {
                this.pageContext.setAttribute(this.var, categories);
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
