package com.banvien.portal.vms.bean;

import java.io.Serializable;
import java.util.List;


/**
 * AbstractPagingBean, support for paging
 * 
 * @author Nguyen Hai Vien
 * 
 * @param <E>
 */
public class AbstractBean<E> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7632896350818457453L;
	protected int maxPageItems = 20;
	protected int firstItem = 0;
	protected int totalItems = 0;
	protected String sortExpression;
	protected String sortDirection;
	protected String[] checkList;
	protected List<E> listResult;
	protected String crudaction;
	protected String sessionId;
	protected String tableId = "tableList";

	protected int page = 1;
	protected E pojo;
	/**
	 * @return the pojo
	 */
	public E getPojo() {
		return pojo;
	}

	/**
	 * @param pojo the pojo to set
	 */
	public void setPojo(E pojo) {
		this.pojo = pojo;
	}

	public String[] getCheckList() {
		return checkList;
	}

	public void setCheckList(String[] checkList) {
		this.checkList = checkList;
	}

	public int getTotalItems() {
		return totalItems;
	}

	public void setTotalItems(int totalItems) {
		this.totalItems = totalItems;
	}

	public List<E> getListResult() {
		return listResult;
	}

	public void setListResult(List<E> listResult) {
		this.listResult = listResult;
	}

	public int getFirstItem() {
		return firstItem;
	}

	public void setFirstItem(int firstItem) {
		this.firstItem = firstItem;
	}

	public int getCurrentPage() {
		return this.firstItem / this.maxPageItems + 1;
	}

	/**
	 * @return the maxPageItems
	 */
	public int getMaxPageItems() {
		return maxPageItems;
	}

	/**
	 * @param maxPageItems
	 *            the maxPageItems to set
	 */
	public void setMaxPageItems(int maxPageItems) {
		this.maxPageItems = maxPageItems;
	}

	/**
	 * @return the sortExpression
	 */
	public String getSortExpression() {
		return sortExpression;
	}

	/**
	 * @param sortExpression the sortExpression to set
	 */
	public void setSortExpression(String sortExpression) {
		this.sortExpression = sortExpression;
	}

	/**
	 * @return the sortDirection
	 */
	public String getSortDirection() {
		return sortDirection;
	}

	/**
	 * @param sortDirection the sortDirection to set
	 */
	public void setSortDirection(String sortDirection) {
		this.sortDirection = sortDirection;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	public String getCrudaction() {
		return crudaction;
	}

	public void setCrudaction(String crudaction) {
		this.crudaction = crudaction;
	}


	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	
	/**
	 * @return the tableId
	 */
	public String getTableId() {
		return tableId;
	}

	/**
	 * @param tableId the tableId to set
	 */
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
}
