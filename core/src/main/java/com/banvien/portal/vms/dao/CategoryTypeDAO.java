package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.CategoryTypeEntity;

import java.util.List;

public interface CategoryTypeDAO extends GenericDAO<CategoryTypeEntity, Long> {

    List<CategoryTypeEntity> findAllCategoryType();
}
