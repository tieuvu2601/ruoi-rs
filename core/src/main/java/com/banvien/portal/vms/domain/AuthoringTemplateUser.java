package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class AuthoringTemplateUser implements Serializable {
    
	private Long authoringTemplateUserID;
	
	private Long authoringTemplateID;
	
	private Long userID;

	public Long getAuthoringTemplateUserID() {
		return authoringTemplateUserID;
	}

	public void setAuthoringTemplateUserID(Long authoringTemplateUserID) {
		this.authoringTemplateUserID = authoringTemplateUserID;
	}

	public Long getAuthoringTemplateID() {
		return authoringTemplateID;
	}

	public void setAuthoringTemplateID(Long authoringTemplateID) {
		this.authoringTemplateID = authoringTemplateID;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}
	
	
}
