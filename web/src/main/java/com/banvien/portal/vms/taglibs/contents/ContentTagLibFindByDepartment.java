package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.service.ContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * UserEntity: viennh
 * Date: 12/13/12
 * Time: 12:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class ContentTagLibFindByDepartment extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null && department != null && begin != null && pageSize != null && var != null) {
            ContentService contentService = context.getBean(ContentService.class);

            List<ContentEntity> contentEntityList = contentService.findByAuthoringTemplateAndDepartment(authoringTemplate, department, begin, pageSize);
            if(contentEntityList != null) {
                this.pageContext.setAttribute(this.var, contentEntityList);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String department;

    private Integer begin;

    private Integer pageSize;

    private String var;

    private String authoringTemplate;

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(String authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public Integer getBegin() {
        return begin;
    }

    public void setBegin(Integer begin) {
        this.begin = begin;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
