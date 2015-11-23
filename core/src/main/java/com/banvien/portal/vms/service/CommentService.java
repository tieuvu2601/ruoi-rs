package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.CommentBean;
import com.banvien.portal.vms.domain.Comment;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:41 PM
 * Author: vien.nguyen@banvien.com
 */
public interface CommentService extends GenericService<Comment, Long> {
    void updateItem(Comment pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Integer updatePublishItems(String[] checkList)  ;

    Integer updateRejectItems(String[] checkList);

    Object[] find4Content(CommentBean commentBean);

    Object[] findApprovedCommentsByContentID(Long contentID, Integer startRow, Integer pageSize);
}
