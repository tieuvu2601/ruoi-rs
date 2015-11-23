package com.banvien.portal.vms.dto;

import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.domain.RenderingTemplate;
import java.sql.Timestamp;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: HauKute
 * Date: 10/7/15
 * Time: 3:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class CategoryDTO implements Serializable {
    private Long categoryID;

    private String code;

    private String name;

    private String prefixUrl;

    private String keyword;

    private String description;

    private Integer displayOrder;

    private AuthoringTemplate authoringTemplate;

    private RenderingTemplate renderingTemplate;

    private Timestamp createdDate;

    private Timestamp modifiedDate;

    private List<CategoryDTO> children;

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
    }

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public AuthoringTemplate getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(AuthoringTemplate authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public RenderingTemplate getRenderingTemplate() {
        return renderingTemplate;
    }

    public void setRenderingTemplate(RenderingTemplate renderingTemplate) {
        this.renderingTemplate = renderingTemplate;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public List<CategoryDTO> getChildren() {
        return children;
    }

    public void setChildren(List<CategoryDTO> children) {
        this.children = children;
    }
}
