package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class ContentEntity implements Serializable {
    private Long contentId;
    private CategoryEntity category;
    private CategoryTypeEntity categoryType;
    private AuthoringTemplateEntity authoringTemplate;
    private String title;
    private String keyword;

    // for product
    private Integer cost;
    private String locationText;
    private LocationEntity location;
    private Integer productStatus;
    private Integer hotItem;
    // for slider
    private Integer slide;
    // for host Item

    private Integer displayOrder;
    private String xmlData;
    private String thumbnails;
    private Timestamp createdDate;
    private Timestamp modifiedDate;
    private Timestamp publishedDate;
    private Integer status;
    private UserEntity createdBy;

    public Long getContentId() {
        return contentId;
    }

    public void setContentId(Long contentId) {
        this.contentId = contentId;
    }

    public CategoryEntity getCategory() {
        return category;
    }

    public void setCategory(CategoryEntity category) {
        this.category = category;
    }

    public CategoryTypeEntity getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(CategoryTypeEntity categoryType) {
        this.categoryType = categoryType;
    }

    public AuthoringTemplateEntity getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(AuthoringTemplateEntity authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
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

    public Integer getCost() {
        return cost;
    }

    public void setCost(Integer cost) {
        this.cost = cost;
    }

    public String getLocationText() {
        return locationText;
    }

    public void setLocationText(String locationText) {
        this.locationText = locationText;
    }

    public LocationEntity getLocation() {
        return location;
    }

    public void setLocation(LocationEntity location) {
        this.location = location;
    }

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }

    public Integer getHotItem() {
        return hotItem;
    }

    public void setHotItem(Integer hotItem) {
        this.hotItem = hotItem;
    }

    public Integer getSlide() {
        return slide;
    }

    public void setSlide(Integer slide) {
        this.slide = slide;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public String getXmlData() {
        return xmlData;
    }

    public void setXmlData(String xmlData) {
        this.xmlData = xmlData;
    }

    public String getThumbnails() {
        return thumbnails;
    }

    public void setThumbnails(String thumbnails) {
        this.thumbnails = thumbnails;
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

    public Timestamp getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Timestamp publishedDate) {
        this.publishedDate = publishedDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public UserEntity getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(UserEntity createdBy) {
        this.createdBy = createdBy;
    }
}
