package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.CategoryTypeDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.CategoryTypeEntity;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CategoryTypeService;

import java.sql.Timestamp;

public class CategoryTypeServiceImpl extends GenericServiceImpl<CategoryTypeEntity, Long> implements CategoryTypeService {
    private CategoryTypeDAO categoryTypeDAO;

    public void setCategoryTypeDAO(CategoryTypeDAO categoryTypeDAO) {
        this.categoryTypeDAO = categoryTypeDAO;
    }


    @Override
    protected GenericDAO<CategoryTypeEntity, Long> getGenericDAO() {
        return categoryTypeDAO;
    }

    @Override
    public CategoryTypeEntity findByCode(String code) throws ObjectNotFoundException {
        CategoryTypeEntity entity = this.categoryTypeDAO.findEqualUnique("code", code);
        if(entity == null) throw new ObjectNotFoundException("Cannot find Category Type with code:" + code);
        return entity;
    }

    @Override
    public CategoryTypeEntity updateItem(CategoryTypeEntity pojo) throws ObjectNotFoundException {
        CategoryTypeEntity dbItem = this.categoryTypeDAO.findByIdNoAutoCommit(pojo.getCategoryTypeId());
        if(dbItem == null) throw new ObjectNotFoundException("Cannot find Category Type with Id" + pojo.getCategoryTypeId());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(now);
        this.categoryTypeDAO.detach(dbItem);
        return this.categoryTypeDAO.update(pojo);
    }

    @Override
    public CategoryTypeEntity addItem(CategoryTypeEntity pojo) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(now);
        return this.categoryTypeDAO.save(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                this.categoryTypeDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
}