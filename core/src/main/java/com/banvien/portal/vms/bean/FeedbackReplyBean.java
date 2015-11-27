package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Feedback;
import com.banvien.portal.vms.domain.FeedbackReply;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/25/13
 * Time: 8:38 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackReplyBean extends AbstractBean<FeedbackReply> {
    public Feedback getFeedback() {
        return feedback;
    }

    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }

    private Feedback feedback;
    public FeedbackReplyBean() {
        this.pojo = new FeedbackReply();
    }
}
