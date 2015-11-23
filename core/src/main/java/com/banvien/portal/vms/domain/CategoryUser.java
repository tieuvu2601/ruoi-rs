package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 3:05 PM
 */
public class CategoryUser implements Serializable {
	
    private Long categoryUserID;
    
    private Long categoryID;
    
    private Long userID;

	public Long getCategoryUserID() {
		return categoryUserID;
	}

	public void setCategoryUserID(Long categoryUserID) {
		this.categoryUserID = categoryUserID;
	}

	public Long getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Long categoryID) {
		this.categoryID = categoryID;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}
}
