package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class AuthoringTemplateShowAll implements Serializable {
    
	private Long authoringTemplateShowAllID;
	
	private Long authoringTemplateID;
	
	private String displayAll;

	public Long getAuthoringTemplateShowAllID() {
		return authoringTemplateShowAllID;
	}

	public void setAuthoringTemplateShowAllID(Long authoringTemplateShowAllID) {
		this.authoringTemplateShowAllID = authoringTemplateShowAllID;
	}

	public Long getAuthoringTemplateID() {
		return authoringTemplateID;
	}

	public void setAuthoringTemplateID(Long authoringTemplateID) {
		this.authoringTemplateID = authoringTemplateID;
	}

	public String getDisplayAll() {
		return displayAll;
	}

	public void setDisplayAll(String displayAll) {
		this.displayAll = displayAll;
	}
}
