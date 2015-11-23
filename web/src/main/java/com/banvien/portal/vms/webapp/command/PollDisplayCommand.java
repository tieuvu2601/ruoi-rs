package com.banvien.portal.vms.webapp.command;

import com.banvien.portal.vms.domain.Comment;

import java.io.Serializable;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/28/12
 * Time: 10:14 AM
 */
public class PollDisplayCommand implements Serializable {
    private String displayName;

    private Integer pollValue;

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public Integer getPollValue() {
        return pollValue;
    }

    public void setPollValue(Integer pollValue) {
        this.pollValue = pollValue;
    }
}
