package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.dto.XmlNodeDTO;

import java.util.List;

public class AuthoringTemplateBean extends AbstractBean<AuthoringTemplate> {
    public AuthoringTemplateBean(){
        this.pojo = new AuthoringTemplate();
    }

    private List<XmlNodeDTO> authoringTemplateNodes;
    
    private List<Long> checkGroupList;
    
    private List<Long> checkUserList;
    
    private Boolean displayAll;

    public List<XmlNodeDTO> getAuthoringTemplateNodes() {
        return authoringTemplateNodes;
    }

    public void setAuthoringTemplateNodes(List<XmlNodeDTO> authoringTemplateNodes) {
        this.authoringTemplateNodes = authoringTemplateNodes;
    }

	public List<Long> getCheckGroupList() {
		return checkGroupList;
	}

	public void setCheckGroupList(List<Long> checkGroupList) {
		this.checkGroupList = checkGroupList;
	}

	public List<Long> getCheckUserList() {
		return checkUserList;
	}

	public void setCheckUserList(List<Long> checkUserList) {
		this.checkUserList = checkUserList;
	}

	public Boolean getDisplayAll() {
		return displayAll;
	}

	public void setDisplayAll(Boolean displayAll) {
		this.displayAll = displayAll;
	}
}
