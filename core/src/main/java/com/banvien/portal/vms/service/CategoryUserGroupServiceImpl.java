package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.CategoryUserGroupDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.CategoryUserGroup;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:46 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryUserGroupServiceImpl extends GenericServiceImpl<CategoryUserGroup, Long> implements CategoryUserGroupService{
	
    private CategoryUserGroupDAO categoryUserGroupDAO;

    public void setCategoryUserGroupDAO(CategoryUserGroupDAO categoryUserGroupDAO) {
		this.categoryUserGroupDAO = categoryUserGroupDAO;
	}

	@Override
    protected GenericDAO<CategoryUserGroup, Long> getGenericDAO() {
        return categoryUserGroupDAO;
    }

	@Override
	public CategoryUserGroup findByCategoryIDAndUserGroupID(Long categoryID,
			Long userGroupID) {
		return categoryUserGroupDAO.findByCategoryIDAndUserGroupID(categoryID, userGroupID);
	}

}
