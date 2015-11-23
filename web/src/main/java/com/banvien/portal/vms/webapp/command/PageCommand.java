package com.banvien.portal.vms.webapp.command;

import java.io.Serializable;
import java.util.List;

import com.banvien.portal.vms.domain.Comment;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/28/12
 * Time: 10:14 AM
 */
public class PageCommand implements Serializable {
    private String authoringTemplate;

    private String category;

    private Long contentID;

    private Long departmentID;

    private Comment comments;

    private int maxPageItems = 10;
	private int firstItem = 0;
	private int totalItems = 0;
	private String sortExpression;
	private String sortDirection;
    private String tableId = "tableList";
    private int page = 1;
    
    private List<Comment> listResults;


    public Comment getComments() {
        return comments;
    }

    public void setComments(Comment comments) {
        this.comments = comments;
    }

    public String getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(String authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Long getContentID() {
        return contentID;
    }

    public void setContentID(Long contentID) {
        this.contentID = contentID;
    }

    public int getMaxPageItems() {
        return maxPageItems;
    }

    public void setMaxPageItems(int maxPageItems) {
        this.maxPageItems = maxPageItems;
    }

    public int getFirstItem() {
        return firstItem;
    }

    public void setFirstItem(int firstItem) {
        this.firstItem = firstItem;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public String getSortExpression() {
        return sortExpression;
    }

    public void setSortExpression(String sortExpression) {
        this.sortExpression = sortExpression;
    }

    public String getSortDirection() {
        return sortDirection;
    }

    public void setSortDirection(String sortDirection) {
        this.sortDirection = sortDirection;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

	public List<Comment> getListResults() {
		return listResults;
	}

	public void setListResults(List<Comment> listResults) {
		this.listResults = listResults;
	}

    public Long getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(Long departmentID) {
        this.departmentID = departmentID;
    }
}
