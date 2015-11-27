package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.Content;

import java.util.List;

public interface CategoryDAO extends GenericDAO<Category, Long> {
    List<Category> findByAuthoringTemplate(String authoringTemplateCode);

    List<Category> findByAuthoringTemplateAndUser(Long authoringTemplateID, Long loginUserId);

    List<Category> findByAuthoringTemplateID(Long authoringTemplateID);

    List<Category> findAllByCategory(long id);

    List<Category> findAllCategoryParent();

    List<Category> findCategoryForBuildMenu(Boolean isEng);
}
