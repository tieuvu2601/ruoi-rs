package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.service.DepartmentService;
import com.banvien.portal.vms.util.CacheUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: viennh
 * Date: 12/18/12
 * Time: 4:40 PM
 * To change this template use File | Settings | File Templates.
 */
public class DepartmentTaglib extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            List<Department> departments = (List<Department>)CacheUtil.getInstance().getValue("ALL_DEPARTMENTS");
            if (departments == null) {
                DepartmentService departmentService = context.getBean(DepartmentService.class);
                departments = departmentService.findAll();
                CacheUtil.getInstance().putValue("ALL_DEPARTMENTS", departments);
            }
            if(departments != null) {
                this.pageContext.setAttribute(this.var, departments);
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
