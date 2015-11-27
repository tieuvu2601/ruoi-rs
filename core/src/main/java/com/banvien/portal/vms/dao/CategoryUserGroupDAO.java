package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.CategoryUserGroup;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:24 PM
 * Author: vien.nguyen@banvien.com
 */
public interface CategoryUserGroupDAO extends GenericDAO<CategoryUserGroup, Long> {
	public CategoryUserGroup findByCategoryIDAndUserGroupID(Long categoryID, Long userGroupID);
}
