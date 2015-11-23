package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.FeedbackCategoryDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.FeedbackCategory;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:13 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackCategoryServiceImpl extends GenericServiceImpl<FeedbackCategory, Long> implements FeedbackCategoryService{
    private FeedbackCategoryDAO feedbackCategoryDAO;

    public void setFeedbackCategoryDAO(FeedbackCategoryDAO feedbackCategoryDAO) {
        this.feedbackCategoryDAO = feedbackCategoryDAO;
    }

    @Override
    protected GenericDAO<FeedbackCategory, Long> getGenericDAO() {
        return feedbackCategoryDAO;
    }

    @Override
    public FeedbackCategory findByName(String name) throws ObjectNotFoundException {
        FeedbackCategory res = feedbackCategoryDAO.findEqualUnique("name", name);
        if (res == null) {
            throw new ObjectNotFoundException("Not found category with name " + name);
        }
        return res;
    }

    @Override
    public void updateItem(FeedbackCategory pojo) throws ObjectNotFoundException, DuplicateException {
        FeedbackCategory dbItem = this.feedbackCategoryDAO.findByIdNoAutoCommit(pojo.getFeedbackCategoryID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getFeedbackCategoryID());

        this.feedbackCategoryDAO.detach(dbItem);
        this.feedbackCategoryDAO.update(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                feedbackCategoryDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
}
