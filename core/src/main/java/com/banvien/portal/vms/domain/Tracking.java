package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class Tracking implements Serializable {

    public static final String FIELD_CONTENT = "content.contentID";

    private Long trackingID;

    private Content content;

    private Integer likes;

    private Integer views;

    private Integer dislike;

    private Timestamp trackingDate;

    private String code;

    public Long getTrackingID() {
        return trackingID;
    }

    public void setTrackingID(Long trackingID) {
        this.trackingID = trackingID;
    }

    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public Integer getLikes() {
        return likes;
    }

    public void setLikes(Integer likes) {
        this.likes = likes;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Integer getDislike() {
        return dislike;
    }

    public void setDislike(Integer dislike) {
        this.dislike = dislike;
    }

    public Timestamp getTrackingDate() {
        return trackingDate;
    }

    public void setTrackingDate(Timestamp trackingDate) {
        this.trackingDate = trackingDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
