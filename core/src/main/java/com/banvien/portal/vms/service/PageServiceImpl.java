package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.PageDAO;
import com.banvien.portal.vms.domain.Page;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:57 PM
 * Author: vien.nguyen@banvien.com
 */
public class PageServiceImpl extends GenericServiceImpl<Page, Long> implements PageService {
    private PageDAO pageDAO;

    public void setPageDAO(PageDAO pageDAO) {
        this.pageDAO = pageDAO;
    }

    @Override
    protected GenericDAO<Page, Long> getGenericDAO() {
        return pageDAO;
    }

    @Override
    public Page findByPage(String page) throws ObjectNotFoundException {
        Page res = pageDAO.findEqualUnique("code", page);
        if (res == null) throw new ObjectNotFoundException("Not found page " + page);
        return res;
    }
    
    @Override
    public void updateItem(Page pojo) throws ObjectNotFoundException, DuplicateException {

        Page dbItem = this.pageDAO.findByIdNoAutoCommit(pojo.getPageID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getPageID());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.pageDAO.detach(dbItem);
        this.pageDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                pageDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }    
    
}
