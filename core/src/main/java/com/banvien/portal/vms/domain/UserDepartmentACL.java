package com.banvien.portal.vms.domain;

import java.io.Serializable;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 2:58 PM
 */
public class UserDepartmentACL implements Serializable {
    private Long userDepartmentACLID;

    private User user;

    private Department department;

    public Long getUserDepartmentACLID() {
        return userDepartmentACLID;
    }

    public void setUserDepartmentACLID(Long userDepartmentACLID) {
        this.userDepartmentACLID = userDepartmentACLID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}
