package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.CategoryDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.domain.CategoryObject;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.util.CategoryUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.i18n.LocaleContextHolder;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:46 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryServiceImpl extends GenericServiceImpl<Category, Long> implements CategoryService{
    private CategoryDAO categoryDAO;

    public void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    protected GenericDAO<Category, Long> getGenericDAO() {
        return categoryDAO;
    }

    @Override
    public Category findByCode(String Code) throws ObjectNotFoundException{
        Category res = categoryDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring category " + Code);
        return res;
    }

    @Override
    public Category updateItem(Category pojo) throws ObjectNotFoundException, DuplicateException {
        Category dbItem = this.categoryDAO.findByIdNoAutoCommit(pojo.getCategoryID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getCategoryID());

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
    public List<Category> findByAuthoringTemplate(String authoringTemplateCode) {
        return categoryDAO.findByAuthoringTemplate(authoringTemplateCode);
    }

    @Override
    public List<Category> findByAuthoringTemplateID(Long authoringTemplateID) {
        return categoryDAO.findByAuthoringTemplateID(authoringTemplateID);
    }

    @Override
    public List<Category> findCategoryByAuthoringTemplateAndUser(Long authoringTemplateID, Long loginUserId) {
        return categoryDAO.findByAuthoringTemplateAndUser(authoringTemplateID, loginUserId);
    }

    @Override
    public List<Category> findAllByCategory(long id) {
        return categoryDAO.findAllByCategory(id);
    }

    @Override
    public List<Category> findAllCategoryParent() {
        return categoryDAO.findAllCategoryParent();
    }

    @Override
    public List<CategoryObject> findCategoryForBuildMenu(Boolean isEng) {
        List<CategoryObject> categoryObjects = new ArrayList<CategoryObject>();
        List<Category> categories =  categoryDAO.findCategoryForBuildMenu(isEng);
        categoryObjects = CategoryUtil.getListChildren(categories, categoryObjects, -1, null);

        return categoryObjects;
    }
}
