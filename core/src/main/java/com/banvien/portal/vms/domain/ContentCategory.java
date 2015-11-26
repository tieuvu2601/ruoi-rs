package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class ContentCategory implements Serializable {
    private Long contentCategoryId;
    private String code;
    private String name;
    private Integer displayOrder;
    private ContentCategory parent;

    public Long getContentCategoryId() {
        return contentCategoryId;
    }

    public void setContentCategoryId(Long contentCategoryId) {
        this.contentCategoryId = contentCategoryId;
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

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public ContentCategory getParent() {
        return parent;
    }

    public void setParent(ContentCategory parent) {
        this.parent = parent;
    }
}
