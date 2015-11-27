package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.domain.ContentEntity;
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
 * UserEntity: viennh
 * Date: 12/13/12
 * Time: 12:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class ContentTagLibFindPrefixUrlCategory extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null && prefixUrl != null && begin != null && pageSize != null && var != null) {
            ContentService contentService = context.getBean(ContentService.class);

            List<ContentEntity> contentEntityList = contentService.findByPrefixUrl(prefixUrl, begin, pageSize, CommonUtil.isEnglishLanguage(), Constants.CONTENT_PUBLISH);
            if(contentEntityList != null) {
                this.pageContext.setAttribute(this.var, contentEntityList);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String prefixUrl;

    private Integer begin;

    private Integer pageSize;

    private String var;

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
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
