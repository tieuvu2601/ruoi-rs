package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Comment;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 5:40 PM
 * Author: vien.nguyen@banvien.com
 */
public class CommentBean extends AbstractBean<Comment> {
    public CommentBean()
    {
        this.pojo = new Comment();
    }

    public Timestamp getFromDate() {
        return fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    public Timestamp getToDate() {
        return toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }

    private Timestamp fromDate;
    private Timestamp toDate;
}
