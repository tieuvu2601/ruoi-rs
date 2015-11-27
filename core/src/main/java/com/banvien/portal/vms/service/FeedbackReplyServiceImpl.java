package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.FeedbackReplyDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.FeedbackReply;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:45 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackReplyServiceImpl extends GenericServiceImpl<FeedbackReply, Long> implements FeedbackReplyService {
    private FeedbackReplyDAO feedbackReplyDAO;

    public void setFeedbackReplyDAO(FeedbackReplyDAO feedbackReplyDAO) {
        this.feedbackReplyDAO = feedbackReplyDAO;
    }

    @Override
    protected GenericDAO<FeedbackReply, Long> getGenericDAO() {
        return feedbackReplyDAO;
    }

    @Override
    public void updateItem(FeedbackReply pojo) throws ObjectNotFoundException, DuplicateException {
        FeedbackReply dbItem = this.feedbackReplyDAO.findByIdNoAutoCommit(pojo.getFeedbackReplyID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getFeedbackReplyID());

        this.feedbackReplyDAO.detach(dbItem);
        this.feedbackReplyDAO.update(pojo);
    }

    @Override
    public void saveItem(FeedbackReply pojo) throws DuplicateException {
        this.feedbackReplyDAO.save(pojo);
    }
}
