package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.FeedbackReply;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:34 AM
 * Author: vien.nguyen@banvien.com
 */
public interface FeedbackReplyService extends GenericService<FeedbackReply, Long> {
    void updateItem(FeedbackReply pojo) throws ObjectNotFoundException, DuplicateException;

    void saveItem(FeedbackReply pojo) throws DuplicateException;
}
