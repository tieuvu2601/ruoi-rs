package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.AuthoringTemplateShowAllDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.AuthoringTemplateShowAll;

public class AuthoringTemplateShowAllServiceImpl extends GenericServiceImpl<AuthoringTemplateShowAll, Long> implements AuthoringTemplateShowAllService {
	
	private AuthoringTemplateShowAllDAO authoringTemplateShowAllDAO;
	
	public void setAuthoringTemplateShowAllDAO(
			AuthoringTemplateShowAllDAO authoringTemplateShowAllDAO) {
		this.authoringTemplateShowAllDAO = authoringTemplateShowAllDAO;
	}

	@Override
	protected GenericDAO<AuthoringTemplateShowAll, Long> getGenericDAO() {
		return authoringTemplateShowAllDAO;
	}

}
