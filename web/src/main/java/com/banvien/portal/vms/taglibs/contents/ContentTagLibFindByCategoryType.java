package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.CategoryTypeEntity;
import com.banvien.portal.vms.dto.CategoryTypeDTO;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.mail.internet.ContentType;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;


public class ContentTagLibFindByCategoryType extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null &&  begin != null && pageSize != null && var != null) {
            ContentService contentService = context.getBean(ContentService.class);

            List <CategoryTypeDTO>  categoryTypes = contentService.findAllContentsByCategoryType(0, 9, Constants.CONTENT_PUBLISH);
            if(categoryTypes != null) {
                this.pageContext.setAttribute(this.var, categoryTypes);
            }
        }

        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private Integer begin;

    private Integer pageSize;

    private String var;

    public ContentService getContentService() {
        return contentService;
    }

    public void setContentService(ContentService contentService) {
        this.contentService = contentService;
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
