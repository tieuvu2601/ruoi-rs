package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.AuthoringTemplateUGroupDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.AuthoringTemplateUGroup;

public class AuthoringTemplateUGroupServiceImpl extends GenericServiceImpl<AuthoringTemplateUGroup, Long> implements AuthoringTemplateUGroupService {
	
	private AuthoringTemplateUGroupDAO authoringTemplateUGroupDAO;
	
	public void setAuthoringTemplateUGroupDAO(
			AuthoringTemplateUGroupDAO authoringTemplateUGroupDAO) {
		this.authoringTemplateUGroupDAO = authoringTemplateUGroupDAO;
	}

	@Override
	protected GenericDAO<AuthoringTemplateUGroup, Long> getGenericDAO() {
		return authoringTemplateUGroupDAO;
	}

	@Override
	public AuthoringTemplateUGroup findByTemplateIDAndUserGroupID(
			Long templateID, Long userGroupID) {
		return authoringTemplateUGroupDAO.findByTemplateIDAndUserGroupID(templateID, userGroupID);
	}

}
