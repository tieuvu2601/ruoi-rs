package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/13/12
 * Time: 2:59 PM
 */
public class AuthoringTemplate implements Serializable {
    private Long authoringTemplateID;

    private String code;

    private String name;

    private String templateContent;
    
    private String status; // Y: allow comment, N: not comment

    private String prefixUrl;

    private String hasThumbnail;

    private String hasHotItem;

    private String hasDepartment;

    private String event;

    private Timestamp createdDate;

    private Timestamp modifiedDate;

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
    }

    public Long getAuthoringTemplateID() {
        return authoringTemplateID;
    }

    public void setAuthoringTemplateID(Long authoringTemplateID) {
        this.authoringTemplateID = authoringTemplateID;
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

    public String getTemplateContent() {
        return templateContent;
    }

    public void setTemplateContent(String templateContent) {
        this.templateContent = templateContent;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

    public String getHasThumbnail() {
        return hasThumbnail;
    }

    public void setHasThumbnail(String hasThumbnail) {
        this.hasThumbnail = hasThumbnail;
    }

    public String getHasHotItem() {
        return hasHotItem;
    }

    public void setHasHotItem(String hasHotItem) {
        this.hasHotItem = hasHotItem;
    }

    public String getHasDepartment() {
        return hasDepartment;
    }

    public void setHasDepartment(String hasDepartment) {
        this.hasDepartment = hasDepartment;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }
}
