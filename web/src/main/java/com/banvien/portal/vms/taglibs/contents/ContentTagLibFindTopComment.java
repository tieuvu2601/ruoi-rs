package com.banvien.portal.vms.taglibs.contents;

import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.CacheUtil;
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
public class ContentTagLibFindTopComment extends TagSupport {

    public int doStartTag() throws JspException {
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null) {
            List<TopCommentsContentDTO> contentList = (List<TopCommentsContentDTO>) CacheUtil.getInstance().getValue("TOP_COMMENT_ITEMS");
            if (contentList == null) {
                ContentService contentService = context.getBean(ContentService.class);

                contentList = contentService.findTopCommentByAuthoringCode(authoringCode, category, pageSize);
                CacheUtil.getInstance().putValue("TOP_COMMENT_ITEMS", contentList);
            }
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

    private String authoringCode;

    private String var;

    private Integer pageSize;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

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
