package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.ContentCategoryDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.ContentCategory;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/29/12
 * Time: 1:33 AM
 */
public class ContentCategoryServiceImpl extends GenericServiceImpl<ContentCategory, Long> implements ContentCategoryService{
    private ContentCategoryDAO contentCategoryDAO;

    public void setContentCategoryDAO(ContentCategoryDAO contentCategoryDAO) {
        this.contentCategoryDAO = contentCategoryDAO;
    }

    @Override
    protected GenericDAO<ContentCategory, Long> getGenericDAO() {
        return contentCategoryDAO;
    }
}
