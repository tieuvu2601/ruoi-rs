package com.banvien.portal.vms.bean;

import java.util.List;

import com.banvien.portal.vms.domain.Category;

public class CategoryBean extends AbstractBean<Category> {
    public CategoryBean()
    {
        this.pojo = new Category();
    }
    
    private List<Long> checkGroupList;
    
    private List<Long> checkUserList;
    
    private Boolean displayAll;
    
    public List<Long> getCheckGroupList() {
		return checkGroupList;
	}

	public void setCheckGroupList(List<Long> checkGroupList) {
		this.checkGroupList = checkGroupList;
	}

	public List<Long> getCheckUserList() {
		return checkUserList;
	}

	public void setCheckUserList(List<Long> checkUserList) {
		this.checkUserList = checkUserList;
	}

	public Boolean getDisplayAll() {
		return displayAll;
	}

	public void setDisplayAll(Boolean displayAll) {
		this.displayAll = displayAll;
	}
}
