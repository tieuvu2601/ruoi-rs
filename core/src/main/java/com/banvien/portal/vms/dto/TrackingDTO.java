package com.banvien.portal.vms.dto;

import java.io.Serializable;

public class TrackingDTO implements Serializable {
    private Long contentID;

    private Long likes;

    private Long views;

    public Long getContentID() {
        return contentID;
    }

    public void setContentID(Long contentID) {
        this.contentID = contentID;
    }

    public Long getLikes() {
        return likes;
    }

    public void setLikes(Long likes) {
        this.likes = likes;
    }

    public Long getViews() {
        return views;
    }

    public void setViews(Long views) {
        this.views = views;
    }
}
