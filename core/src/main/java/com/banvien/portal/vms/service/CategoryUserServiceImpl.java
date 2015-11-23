package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.CategoryUserDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.CategoryUser;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:46 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryUserServiceImpl extends GenericServiceImpl<CategoryUser, Long> implements CategoryUserService{
    private CategoryUserDAO categoryUserDAO;

    @Override
    protected GenericDAO<CategoryUser, Long> getGenericDAO() {
        return categoryUserDAO;
    }

	public void setCategoryUserDAO(CategoryUserDAO categoryUserDAO) {
		this.categoryUserDAO = categoryUserDAO;
	}

	@Override
	public CategoryUser findByCategoryIDAndUserID(Long categoryID, Long userID) {
		return categoryUserDAO.findByCategoryIDAndUserID(categoryID, userID);
	}

}
