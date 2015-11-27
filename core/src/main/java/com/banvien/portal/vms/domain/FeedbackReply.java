package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/24/13
 * Time: 6:55 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackReply implements Serializable {
    private Long feedbackReplyID;

    private Feedback feedback;

    private String content;

    private Timestamp createdDate;

    private User createdBy;

    public Long getFeedbackReplyID() {
        return feedbackReplyID;
    }

    public void setFeedbackReplyID(Long feedbackReplyID) {
        this.feedbackReplyID = feedbackReplyID;
    }

    public Feedback getFeedback() {
        return feedback;
    }

    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }
}
