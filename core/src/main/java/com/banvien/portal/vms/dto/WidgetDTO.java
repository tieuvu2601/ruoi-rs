package com.banvien.portal.vms.dto;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.RenderingTemplate;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/28/12
 * Time: 10:41 AM
 */
public class WidgetDTO implements Serializable {

    private String widgetID;

    private String categoryCode;

    private String authoringTemplateCode;

    private Map<String, Object> queryParams;

    private String sortExpression;

    private String sortDirection;

    private Category category;

    private RenderingTemplate renderingTemplate;

    private Content contentItem;

    private List<Content> contentItems;

    public String getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        this.categoryCode = categoryCode;
    }

    public String getAuthoringTemplateCode() {
        return authoringTemplateCode;
    }

    public void setAuthoringTemplateCode(String authoringTemplateCode) {
        this.authoringTemplateCode = authoringTemplateCode;
    }

    public Map<String, Object> getQueryParams() {
        return queryParams;
    }

    public void setQueryParams(Map<String, Object> queryParams) {
        this.queryParams = queryParams;
    }

    public String getSortExpression() {
        return sortExpression;
    }

    public void setSortExpression(String sortExpression) {
        this.sortExpression = sortExpression;
    }

    public String getSortDirection() {
        return sortDirection;
    }

    public void setSortDirection(String sortDirection) {
        this.sortDirection = sortDirection;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public RenderingTemplate getRenderingTemplate() {
        return renderingTemplate;
    }

    public void setRenderingTemplate(RenderingTemplate renderingTemplate) {
        this.renderingTemplate = renderingTemplate;
    }

    public Content getContentItem() {
        return contentItem;
    }

    public void setContentItem(Content contentItem) {
        this.contentItem = contentItem;
    }

    public List<Content> getContentItems() {
        return contentItems;
    }

    public void setContentItems(List<Content> contentItems) {
        this.contentItems = contentItems;
    }

    public String getWidgetID() {
        return widgetID;
    }

    public void setWidgetID(String widgetID) {
        this.widgetID = widgetID;
    }
}
