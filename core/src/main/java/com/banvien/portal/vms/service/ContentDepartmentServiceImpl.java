package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.ContentDepartmentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.ContentDepartment;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/29/12
 * Time: 1:33 AM
 */
public class ContentDepartmentServiceImpl extends GenericServiceImpl<ContentDepartment, Long> implements ContentDepartmentService{
    private ContentDepartmentDAO contentCategoryDAO;

    public void setContentDepartmentDAO(ContentDepartmentDAO contentCategoryDAO) {
        this.contentCategoryDAO = contentCategoryDAO;
    }

    @Override
    protected GenericDAO<ContentDepartment, Long> getGenericDAO() {
        return contentCategoryDAO;
    }
}
