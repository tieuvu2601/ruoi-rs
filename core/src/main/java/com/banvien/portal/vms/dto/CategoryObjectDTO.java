package com.banvien.portal.vms.dto;

import com.banvien.portal.vms.domain.AuthoringTemplateEntity;

public class CategoryObjectDTO {
    private Long categoryId;

    private String code;

    private String name;

    private String prefixUrl;

    private Integer nodeLevel;

    private Integer displayOrder;

    private CategoryObjectDTO parent;

    private Integer childrenSize;

    private AuthoringTemplateEntity authoringTemplateEntity;

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

    public CategoryObjectDTO getParent() {
        return parent;
    }

    public void setParent(CategoryObjectDTO parent) {
        this.parent = parent;
    }

    public AuthoringTemplateEntity getAuthoringTemplateEntity() {
        return authoringTemplateEntity;
    }

    public void setAuthoringTemplateEntity(AuthoringTemplateEntity authoringTemplateEntity) {
        this.authoringTemplateEntity = authoringTemplateEntity;
    }

    public Integer getNodeLevel() {
        return nodeLevel;
    }

    public void setNodeLevel(Integer nodeLevel) {
        this.nodeLevel = nodeLevel;
    }

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
    }

    public Integer getChildrenSize() {
        return childrenSize;
    }

    public void setChildrenSize(Integer childrenSize) {
        this.childrenSize = childrenSize;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }
}
