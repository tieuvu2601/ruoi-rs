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
public class ContentTagLibFindByEventTypeWithMaxItem extends TagSupport {
    @Autowired
    private ContentService contentService;

    public int doStartTag() throws JspException {
        // FIND EVENTS IN SITE BY EVENT TYPE (Event Type { upcoming | past}
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());

        if(context != null && eventType != null && begin != null && pageSize != null && var != null) {
            ContentService contentService = context.getBean(ContentService.class);
            Boolean isEng = CommonUtil.isEnglishLanguage();

            String eventCategoryCode = Constants.EVENTS_CATEGORY_CODE;

            if(isEng){
                eventCategoryCode = eventCategoryCode + Constants.PREFIX_ENGLISH_LANGUAGE;
            }

            Object [] obj = contentService.findByCategoryTypeWithMaxItem(eventType, begin, pageSize, eventCategoryCode, isEng, Constants.CONTENT_PUBLISH);
            List<ContentEntity> contentEntityList = (List<ContentEntity>) obj[1];
            if(contentEntityList != null) {
                this.pageContext.setAttribute(this.var, contentEntityList);
            }
        }
        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    private String eventType;

    private Integer begin;

    private Integer pageSize;

    private String var;

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
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
