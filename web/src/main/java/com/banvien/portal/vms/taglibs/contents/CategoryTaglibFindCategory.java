package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.service.CategoryService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * UserEntity: viennh
 * Date: 12/18/12
 * Time: 4:40 PM
 * To change this template use File | Settings | File Templates.
 */
public class CategoryTaglibFindCategory extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            CategoryService categoryService = context.getBean(CategoryService.class);
            List<CategoryEntity> categories = categoryService.findByAuthoringTemplate(authoringCode);
            if(categories != null) {
                this.pageContext.setAttribute(this.var, categories);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String authoringCode;


    private String var;

    public String getAuthoringCode() {
        return authoringCode;
    }

    public void setAuthoringCode(String authoringCode) {
        this.authoringCode = authoringCode;
    }


    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
