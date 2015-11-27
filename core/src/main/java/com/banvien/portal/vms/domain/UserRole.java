package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class UserRole implements Serializable {

    public static final String FIELD_USER= "user.userID";

    private Long userRoleID;

    private User user;

    private Role role;

    public Long getUserRoleID() {
        return userRoleID;
    }

    public void setUserRoleID(Long userRoleID) {
        this.userRoleID = userRoleID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
