package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 3:05 PM
 */
public class UserSession implements Serializable {
    private Long userSessionID;
    private Long numberOfVisitors;

    public Long getUserSessionID() {
        return userSessionID;
    }

    public void setUserSessionID(Long userSessionID) {
        this.userSessionID = userSessionID;
    }

    public Long getNumberOfVisitors() {
        return numberOfVisitors;
    }

    public void setNumberOfVisitors(Long numberOfVisitors) {
        this.numberOfVisitors = numberOfVisitors;
    }
}
