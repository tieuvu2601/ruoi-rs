package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Time;
import java.sql.Timestamp;

public class AuthoringTemplateEntity implements Serializable {
    private Long authoringTemplateId;
    private String code;
    private String name;
    private String templateContent;
    private Timestamp createdDate;
    private Timestamp modifiedDate;

    public Long getAuthoringTemplateId() {
        return authoringTemplateId;
    }

    public void setAuthoringTemplateId(Long authoringTemplateId) {
        this.authoringTemplateId = authoringTemplateId;
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
}
