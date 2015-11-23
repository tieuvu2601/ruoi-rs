package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.CategoryShowAllDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.CategoryShowAll;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:46 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryShowAllServiceImpl extends GenericServiceImpl<CategoryShowAll, Long> implements CategoryShowAllService{
	
    private CategoryShowAllDAO categoryShowAllDAO;

    public void setCategoryShowAllDAO(CategoryShowAllDAO categoryShowAllDAO) {
		this.categoryShowAllDAO = categoryShowAllDAO;
	}

	@Override
    protected GenericDAO<CategoryShowAll, Long> getGenericDAO() {
        return categoryShowAllDAO;
    }

}
