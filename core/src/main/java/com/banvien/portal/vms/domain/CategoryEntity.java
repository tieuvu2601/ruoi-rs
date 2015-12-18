package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class CategoryEntity implements Serializable {
    private Long categoryId;
    private String code;
    private String name;
    private String title;
    private String keyword;
    private String prefixUrl;
    private String description;
    private Integer displayOrder;
    private AuthoringTemplateEntity authoringTemplate;
    private CategoryEntity parent;
    private Timestamp createdDate;
    private Timestamp modifiedDate;
    private List<CategoryEntity> children;

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
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

    public AuthoringTemplateEntity getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(AuthoringTemplateEntity authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public CategoryEntity getParent() {
        return parent;
    }

    public void setParent(CategoryEntity parent) {
        this.parent = parent;
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

    public List<CategoryEntity> getChildren() {
        return children;
    }

    public void setChildren(List<CategoryEntity> children) {
        this.children = children;
    }
}
