package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Feedback;
import com.banvien.portal.vms.domain.FeedbackReply;

import java.sql.Timestamp;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 8:34 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackBean extends AbstractBean<Feedback> {
    public FeedbackBean() {
        this.maxPageItems = 50;
        this.pojo = new Feedback();
    }

    private FeedbackReply feedbackReply;

    private Timestamp fromDate;

    private Timestamp toDate;

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

    private Integer totalReplied;

    private List<FeedbackReply> replies;

    public Integer getTotalReplied() {
        return totalReplied;
    }

    public void setTotalReplied(Integer totalReplied) {
        this.totalReplied = totalReplied;
    }

    public List<FeedbackReply> getReplies() {
        return replies;
    }

    public void setReplies(List<FeedbackReply> replies) {
        this.replies = replies;
    }

    public FeedbackReply getFeedbackReply() {
        return feedbackReply;
    }

    public void setFeedbackReply(FeedbackReply feedbackReply) {
        this.feedbackReply = feedbackReply;
    }
}
