package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 3:05 PM
 */
public class Category implements Serializable {
    private Long categoryID;

    private String code;

    private String name;

    private String prefixUrl;

    private String keyword;

    private String description;

    private Integer displayOrder;

    private AuthoringTemplate authoringTemplate;

    private Timestamp createdDate;

    private Timestamp modifiedDate;

    private Category parentCategory;

    private List<Category> children;

    private Long parentRootID;

    private boolean eng;

    public boolean isEng() {
        return eng;
    }

    public void setEng(boolean eng) {
        this.eng = eng;
    }

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
    }

    public Long getParentRootID() {
        return parentRootID;
    }

    public void setParentRootID(Long parentRootID) {
        this.parentRootID = parentRootID;
    }

    public Category getParentCategory() {
        return parentCategory;
    }

    public void setParentCategory(Category parentCategory) {
        this.parentCategory = parentCategory;
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

    public List<Category> getChildren() {
        return children;
    }

    public void setChildren(List<Category> children) {
        this.children = children;
    }
}
