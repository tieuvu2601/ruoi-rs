package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.CategoryObject;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface CategoryService extends GenericService<Category, Long> {

    Category findByCode(String Code) throws ObjectNotFoundException;

    Category updateItem(Category bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<Category> findByAuthoringTemplate(String authoringTemplateCode);

    List<Category> findByAuthoringTemplateID(Long authoringTemplateID);

    List<Category> findCategoryByAuthoringTemplateAndUser(Long authoringTemplateID, Long loginUserId);

    List<Category> findAllByCategory(long id);

    List<Category> findAllCategoryParent();

    List<CategoryObject> findCategoryForBuildMenu(Boolean isEng);
}
