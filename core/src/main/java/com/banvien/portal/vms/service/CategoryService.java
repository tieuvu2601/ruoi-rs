package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface CategoryService extends GenericService<Category, Long> {

    Category findByCode(String Code) throws ObjectNotFoundException;

    Category updateItem(Category bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<Category> findByAuthoringTemplate(String authoringTemplateCode);

    List<Category> findAllCategoryParent();

    List<CategoryObjectDTO> findCategoryForBuildMenu(Boolean isEng);
}
