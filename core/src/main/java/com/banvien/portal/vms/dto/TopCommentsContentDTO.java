package com.banvien.portal.vms.dto;

import java.io.Serializable;

public class TopCommentsContentDTO implements Serializable {

    private String contentID;
    private String title;
    private String noOfComments;

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

    public String getNoOfComments() {
        return noOfComments;
    }

    public void setNoOfComments(String noOfComments) {
        this.noOfComments = noOfComments;
    }
}
