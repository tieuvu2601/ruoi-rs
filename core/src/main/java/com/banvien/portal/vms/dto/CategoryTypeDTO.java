package com.banvien.portal.vms.dto;

import com.banvien.portal.vms.domain.CategoryTypeEntity;
import com.banvien.portal.vms.domain.ContentEntity;

import java.io.Serializable;
import java.util.List;

public class CategoryTypeDTO implements Serializable {
    private CategoryTypeEntity categoryType;
    private List<ContentEntity> contents;
    private Long totalNumber;

    public CategoryTypeEntity getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(CategoryTypeEntity categoryType) {
        this.categoryType = categoryType;
    }

    public List<ContentEntity> getContents() {
        return contents;
    }

    public void setContents(List<ContentEntity> contents) {
        this.contents = contents;
    }

    public Long getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(Long totalNumber) {
        this.totalNumber = totalNumber;
    }
}
