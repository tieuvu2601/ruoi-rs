package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 2:58 PM
 */
public class ContentDepartment implements Serializable {
    private Long contentDepartmentID;

    private Content content;

    private Department department;



    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public Long getContentDepartmentID() {
        return contentDepartmentID;
    }

    public void setContentDepartmentID(Long contentDepartmentID) {
        this.contentDepartmentID = contentDepartmentID;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}
