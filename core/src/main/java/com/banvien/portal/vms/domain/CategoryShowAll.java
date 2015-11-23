package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 3:05 PM
 */
public class CategoryShowAll implements Serializable {
	
    private Long categoryShowAllID;
    
    private Long categoryID;
    
    private String displayAll;

	public Long getCategoryShowAllID() {
		return categoryShowAllID;
	}

	public void setCategoryShowAllID(Long categoryShowAllID) {
		this.categoryShowAllID = categoryShowAllID;
	}

	public Long getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(Long categoryID) {
		this.categoryID = categoryID;
	}

	public String getDisplayAll() {
		return displayAll;
	}

	public void setDisplayAll(String displayAll) {
		this.displayAll = displayAll;
	}
	
}
