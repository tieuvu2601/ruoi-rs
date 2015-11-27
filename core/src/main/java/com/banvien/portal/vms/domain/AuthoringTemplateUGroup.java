package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class AuthoringTemplateUGroup implements Serializable {
    
	private Long authoringTemplateUGroupID;
	
	private Long authoringTemplateID;
	
	private Long userGroupID;

	public Long getAuthoringTemplateUGroupID() {
		return authoringTemplateUGroupID;
	}

	public void setAuthoringTemplateUGroupID(Long authoringTemplateUGroupID) {
		this.authoringTemplateUGroupID = authoringTemplateUGroupID;
	}

	public Long getAuthoringTemplateID() {
		return authoringTemplateID;
	}

	public void setAuthoringTemplateID(Long authoringTemplateID) {
		this.authoringTemplateID = authoringTemplateID;
	}

	public Long getUserGroupID() {
		return userGroupID;
	}

	public void setUserGroupID(Long userGroupID) {
		this.userGroupID = userGroupID;
	}

	
}
