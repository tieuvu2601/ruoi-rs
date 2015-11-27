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
public class Feedback implements Serializable {
    private Long feedbackID;

    private String title;

    private String content;

    private Timestamp createdDate;

    private Department department;

    private FeedbackCategory feedbackCategory;

    private User createdBy;

    private Integer status;

    public Long getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(Long feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public FeedbackCategory getFeedbackCategory() {
        return feedbackCategory;
    }

    public void setFeedbackCategory(FeedbackCategory feedbackCategory) {
        this.feedbackCategory = feedbackCategory;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
