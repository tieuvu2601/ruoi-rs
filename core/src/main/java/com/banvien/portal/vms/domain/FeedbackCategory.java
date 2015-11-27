package com.banvien.portal.vms.domain;

import java.io.Serializable;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 4/24/13
 * Time: 6:40 AM
 * Author: vien.nguyen@banvien.com
 */
public class FeedbackCategory implements Serializable {
    private Long feedbackCategoryID;

    private String name;

    private String description;


    public Long getFeedbackCategoryID() {
        return feedbackCategoryID;
    }

    public void setFeedbackCategoryID(Long feedbackCategoryID) {
        this.feedbackCategoryID = feedbackCategoryID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
