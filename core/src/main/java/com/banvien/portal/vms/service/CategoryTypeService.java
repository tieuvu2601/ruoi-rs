package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.CategoryTypeEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface CategoryTypeService extends GenericService<CategoryTypeEntity, Long> {

    CategoryTypeEntity findByCode(String code) throws ObjectNotFoundException;

    CategoryTypeEntity updateItem(CategoryTypeEntity pojo) throws ObjectNotFoundException;

    CategoryTypeEntity addItem(CategoryTypeEntity pojo);

    Integer deleteItems(String[] checkList);
}
