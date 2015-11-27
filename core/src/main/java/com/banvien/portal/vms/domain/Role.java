package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class Role implements Serializable {

    public static final String FIELD_ROLE = "role";

    public static final String FIELD_NAME = "name";

    private Long roleID;

    private String role;

    private String name;

    private String description;

    private Timestamp createdDate;

    private Timestamp modifiedDate;

    public Long getRoleID() {
        return roleID;
    }

    public void setRoleID(Long roleID) {
        this.roleID = roleID;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }
}
