package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserGroup implements Serializable {
    private Long userGroupId;

    private String code;

    private String name;

    public Long getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Long userGroupId) {
        this.userGroupId = userGroupId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
