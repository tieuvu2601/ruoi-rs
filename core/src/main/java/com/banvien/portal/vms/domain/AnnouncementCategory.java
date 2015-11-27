package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 2/26/13
 * Time: 8:53 AM
 */
public class AnnouncementCategory implements Serializable {
    private Long announcementCategoryID;

    private String url;

    private Long authoringTemplateID;

    private Long departmentID;

    private Integer status;

    private Timestamp fromDate;

    public Long getAnnouncementCategoryID() {
        return announcementCategoryID;
    }

    public void setAnnouncementCategoryID(Long announcementCategoryID) {
        this.announcementCategoryID = announcementCategoryID;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getAuthoringTemplateID() {
        return authoringTemplateID;
    }

    public void setAuthoringTemplateID(Long authoringTemplateID) {
        this.authoringTemplateID = authoringTemplateID;
    }

    public Long getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(Long departmentID) {
        this.departmentID = departmentID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Timestamp getFromDate() {
        return fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }
}
