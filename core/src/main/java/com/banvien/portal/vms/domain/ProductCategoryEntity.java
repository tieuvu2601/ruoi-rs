package com.banvien.portal.vms.domain;

import java.io.Serializable;


public class ProductCategoryEntity implements Serializable {
    private Long productCategoryId;
    private String code;
    private String name;
    private Integer displayOrder;
    private ProductCategoryEntity parent;

    public Long getProductCategoryId() {
        return productCategoryId;
    }

    public void setProductCategoryId(Long productCategoryId) {
        this.productCategoryId = productCategoryId;
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

    public ProductCategoryEntity getParent() {
        return parent;
    }

    public void setParent(ProductCategoryEntity parent) {
        this.parent = parent;
    }
}
