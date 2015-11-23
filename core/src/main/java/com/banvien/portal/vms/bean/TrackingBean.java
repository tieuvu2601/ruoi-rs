package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Tracking;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 5:40 PM
 * Author: vien.nguyen@banvien.com
 */
public class TrackingBean extends AbstractBean<Tracking> {
    public TrackingBean()
    {
        this.pojo = new Tracking();
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
    private boolean isLiked;

    public boolean getIsLiked() {
        return isLiked;
    }

    public void setIsLiked(boolean liked) {
        this.isLiked = liked;
    }
}
