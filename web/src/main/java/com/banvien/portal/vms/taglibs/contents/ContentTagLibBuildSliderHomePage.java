package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;


public class ContentTagLibBuildSliderHomePage extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            ContentService contentService = context.getBean(ContentService.class);
            List<ContentEntity> contentList = contentService.findContentForBuildSlider(pageSize, Constants.CONTENT_PUBLISH);
            if(contentList != null) {
                this.pageContext.setAttribute(this.var, contentList);
            }
        }

        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private Integer pageSize;

    private String var;

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
