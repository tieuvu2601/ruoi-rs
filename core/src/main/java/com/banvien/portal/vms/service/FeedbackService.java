package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Feedback;
import com.banvien.portal.vms.exception.DuplicateException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:14 AM
 * Author: vien.nguyen@banvien.com
 */
public interface FeedbackService extends GenericService<Feedback, Long> {
    Integer deleteItems(String[] checkList);

    void saveItem(Feedback pojo) throws DuplicateException;
}
