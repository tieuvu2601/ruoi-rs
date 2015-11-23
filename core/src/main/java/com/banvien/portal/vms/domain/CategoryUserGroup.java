package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 3:05 PM
 */
public class CategoryUserGroup implements Serializable {
	
    private Long categoryUserGroupID;
    
    private Long categoryID;
    
    private Long userGroupID;

	public Long getCategoryUserGroupID() {
		return categoryUserGroupID;
	}

	public void setCategoryUserGroupID(Long categoryUserGroupID) {
		this.categoryUserGroupID = categoryUserGroupID;
	}

	public Long getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Long categoryID) {
		this.categoryID = categoryID;
	}

	public Long getUserGroupID() {
		return userGroupID;
	}

	public void setUserGroupID(Long userGroupID) {
		this.userGroupID = userGroupID;
	}

	
}
