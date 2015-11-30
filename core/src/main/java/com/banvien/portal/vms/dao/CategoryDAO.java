package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.CategoryEntity;

import java.util.List;

public interface CategoryDAO extends GenericDAO<CategoryEntity, Long> {
    List<CategoryEntity> findByAuthoringTemplate(String authoringTemplateCode);

    List<CategoryEntity> findAllCategoryParent();

    List<CategoryEntity> findCategoryForBuildMenu(Boolean isEng);
}
