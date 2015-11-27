package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.ContentEntity;

import java.sql.Timestamp;

public class SearchBean extends AbstractBean<ContentEntity>{
	
	public SearchBean(){
		this.pojo = new ContentEntity();
	}

	private Long categoryID;

    private Timestamp fromDate;

    private Timestamp toDate;

    private String keyword;

    private Integer pageNumber;

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

    public Timestamp getFromDate() {
        return fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    public Timestamp getToDate() {
        return toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        this.pageNumber = pageNumber;
    }
}
