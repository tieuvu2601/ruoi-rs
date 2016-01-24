package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class ContentEntity implements Serializable {
    private Long contentId;
    private CategoryEntity category;
    private AuthoringTemplateEntity authoringTemplate;
    private String title;
    private String header;
    private String keyword;
    private String description;
    private String thumbnails;
    private Integer displayOrder;
    private Integer status;

    // for product
    private CategoryTypeEntity categoryType;
    private String locationText;
    private LocationEntity location;
    private String area;
    private String totalArea;
    private String areaRatio;
    private String numberOfBlock;
    private Integer cost;
    private String unit;
    private Integer hotItem;
    private Integer productStatus;

    // for slider
    private Integer slide;

    // for content
    private String xmlData;
    private Timestamp createdDate;
    private Timestamp modifiedDate;
    private Timestamp publishedDate;

    private UserEntity createdBy;

    private String emailSubject;

    private String emailContent;

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

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
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

    public String getThumbnails() {
        return thumbnails;
    }

    public void setThumbnails(String thumbnails) {
        this.thumbnails = thumbnails;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public CategoryTypeEntity getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(CategoryTypeEntity categoryType) {
        this.categoryType = categoryType;
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

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getTotalArea() {
        return totalArea;
    }

    public void setTotalArea(String totalArea) {
        this.totalArea = totalArea;
    }

    public String getAreaRatio() {
        return areaRatio;
    }

    public void setAreaRatio(String areaRatio) {
        this.areaRatio = areaRatio;
    }

    public String getNumberOfBlock() {
        return numberOfBlock;
    }

    public void setNumberOfBlock(String numberOfBlock) {
        this.numberOfBlock = numberOfBlock;
    }

    public Integer getCost() {
        return cost;
    }

    public void setCost(Integer cost) {
        this.cost = cost;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getHotItem() {
        return hotItem;
    }

    public void setHotItem(Integer hotItem) {
        this.hotItem = hotItem;
    }

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }

    public Integer getSlide() {
        return slide;
    }

    public void setSlide(Integer slide) {
        this.slide = slide;
    }

    public String getXmlData() {
        return xmlData;
    }

    public void setXmlData(String xmlData) {
        this.xmlData = xmlData;
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

    public UserEntity getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(UserEntity createdBy) {
        this.createdBy = createdBy;
    }

    public String getEmailSubject() {
        return emailSubject;
    }

    public void setEmailSubject(String emailSubject) {
        this.emailSubject = emailSubject;
    }

    public String getEmailContent() {
        return emailContent;
    }

    public void setEmailContent(String emailContent) {
        this.emailContent = emailContent;
    }
}
