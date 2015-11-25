package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.security.Timestamp;
import java.sql.Time;


public class ProductCommentEntity implements Serializable {
    private Long productCommentId;
    private ProductEntity product;
    private String customerName;
    private String email;
    private String phoneNumber;
    private String message;
    private Timestamp createdDate;
    private Timestamp resolvedDate;
    private String resolvedBy;

    public Long getProductCommentId() {
        return productCommentId;
    }

    public void setProductCommentId(Long productCommentId) {
        this.productCommentId = productCommentId;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getResolvedDate() {
        return resolvedDate;
    }

    public void setResolvedDate(Timestamp resolvedDate) {
        this.resolvedDate = resolvedDate;
    }

    public String getResolvedBy() {
        return resolvedBy;
    }

    public void setResolvedBy(String resolvedBy) {
        this.resolvedBy = resolvedBy;
    }
}
