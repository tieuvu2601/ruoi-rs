package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.CategoryUser;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:24 PM
 * Author: vien.nguyen@banvien.com
 */
public interface CategoryUserDAO extends GenericDAO<CategoryUser, Long> {
	public CategoryUser findByCategoryIDAndUserID(Long categoryID, Long userID );
}
