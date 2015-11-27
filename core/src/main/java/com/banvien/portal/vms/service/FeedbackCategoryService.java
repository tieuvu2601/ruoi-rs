package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.FeedbackCategory;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 12:12 AM
 * Author: vien.nguyen@banvien.com
 */
public interface FeedbackCategoryService extends GenericService<FeedbackCategory, Long> {
    FeedbackCategory findByName(String name) throws ObjectNotFoundException;

    void updateItem(FeedbackCategory pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
}
