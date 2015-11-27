package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.CommonUtil;
import com.banvien.portal.vms.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: viennh
 * Date: 12/13/12
 * Time: 12:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class ContentTagLibFindCategory extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());
        Boolean isEng = CommonUtil.isEnglishLanguage();

        if(context != null && category != null && begin != null && pageSize != null && var != null) {
            ContentService contentService = context.getBean(ContentService.class);
            if(isEng){
                category = category + Constants.PREFIX_ENGLISH_LANGUAGE;
            }
            List<Content> contentList = contentService.findByCategory(category, begin, pageSize, isEng, Constants.CONTENT_PUBLISH);
            if(contentList != null) {
                this.pageContext.setAttribute(this.var, contentList);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String category;

    private Integer begin;

    private Integer pageSize;

    private String var;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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
