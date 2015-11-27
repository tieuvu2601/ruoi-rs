package com.banvien.portal.vms.dto;

import java.io.Serializable;

public class TopViewContentDTO implements Serializable {

    private String contentID;
    private String title;

    public String getContentID() {
        return contentID;
    }

    public void setContentID(String contentID) {
        this.contentID = contentID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
