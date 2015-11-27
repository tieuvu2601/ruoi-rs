package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.CategoryDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.dto.CategoryObjectDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryService;
import com.banvien.portal.vms.util.CategoryUtil;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CategoryServiceImpl extends GenericServiceImpl<CategoryEntity, Long> implements CategoryService {
    private CategoryDAO categoryDAO;

    public void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    protected GenericDAO<CategoryEntity, Long> getGenericDAO() {
        return categoryDAO;
    }

    @Override
    public CategoryEntity findByCode(String Code) throws ObjectNotFoundException{
        CategoryEntity res = categoryDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring category " + Code);
        return res;
    }

    @Override
    public CategoryEntity updateItem(CategoryEntity pojo) throws ObjectNotFoundException, DuplicateException {
        CategoryEntity dbItem = this.categoryDAO.findByIdNoAutoCommit(pojo.getCategoryId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getCategoryId());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.categoryDAO.detach(dbItem);
        return this.categoryDAO.update(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                categoryDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public List<CategoryEntity> findByAuthoringTemplate(String authoringTemplateCode) {
        return categoryDAO.findByAuthoringTemplate(authoringTemplateCode);
    }

    @Override
    public List<CategoryEntity> findAllCategoryParent() {
        return categoryDAO.findAllCategoryParent();
    }

    @Override
    public List<CategoryObjectDTO> findCategoryForBuildMenu(Boolean isEng) {
        List<CategoryObjectDTO> categoryObjectDTOs = new ArrayList<CategoryObjectDTO>();
        List<CategoryEntity> categories =  categoryDAO.findCategoryForBuildMenu(isEng);
        categoryObjectDTOs = CategoryUtil.getListChildren(categories, categoryObjectDTOs, -1, null);

        return categoryObjectDTOs;
    }
}