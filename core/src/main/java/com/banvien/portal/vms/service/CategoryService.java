package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface CategoryService extends GenericService<CategoryEntity, Long> {

    CategoryEntity findByCode(String Code) throws ObjectNotFoundException;

    CategoryEntity updateItem(CategoryEntity bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<CategoryEntity> findByAuthoringTemplate(String authoringTemplateCode);

    List<CategoryEntity> findAllCategoryParent();

    List<CategoryObjectDTO> findCategoryForBuildMenu(Boolean isEng);
}
