package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.AuthoringTemplateUserDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.AuthoringTemplateUser;

public class AuthoringTemplateUserServiceImpl extends GenericServiceImpl<AuthoringTemplateUser, Long> implements AuthoringTemplateUserService {
	
	private AuthoringTemplateUserDAO authoringTemplateUserDAO ;

	@Override
	protected GenericDAO<AuthoringTemplateUser, Long> getGenericDAO() {
		return authoringTemplateUserDAO;
	}

	public void setAuthoringTemplateUserDAO(AuthoringTemplateUserDAO authoringTemplateUserDAO) {
		this.authoringTemplateUserDAO = authoringTemplateUserDAO;
	}

	@Override
	public AuthoringTemplateUser findByTemplateIDAndUserID(
			Long templateID, Long userID) {
		return authoringTemplateUserDAO.findByTemplateIDAndUserID(templateID, userID);
	}
}
