package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.CommonUtil;
import com.banvien.portal.vms.util.Constants;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;


public class ContentTaglibFindByContentTitle extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            ContentService contentService = context.getBean(ContentService.class);
            Boolean isEng = CommonUtil.isEnglishLanguage();
            if(isEng){
                title  = title + Constants.PREFIX_ENGLISH_LANGUAGE;
            }
            Content content = contentService.findByTitle(title, isEng, Constants.CONTENT_PUBLISH);
            if(content != null) {
                this.pageContext.setAttribute(this.var, content);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String title;


    private String var;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVar() {
        return var;
    }

    public void setVar(String var) {
        this.var = var;
    }
}
