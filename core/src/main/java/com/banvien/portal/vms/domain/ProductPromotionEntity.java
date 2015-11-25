package com.banvien.portal.vms.domain;

import java.io.Serializable;


public class ProductPromotionEntity implements Serializable {
    private Long productPromotionId;
    private ProductEntity product;
    private String title;
    private Long value;

    public Long getProductPromotionId() {
        return productPromotionId;
    }

    public void setProductPromotionId(Long productPromotionId) {
        this.productPromotionId = productPromotionId;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getValue() {
        return value;
    }

    public void setValue(Long value) {
        this.value = value;
    }
}
