package com.banvien.portal.vms.dto;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: BV-Dev1
 * Date: 12/5/12
 * Time: 5:25 PM
 * To change this template use File | Settings | File Templates.
 */
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
