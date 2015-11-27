package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.AuthoringTemplateUser;

public interface AuthoringTemplateUserDAO extends GenericDAO<AuthoringTemplateUser, Long> {
	public AuthoringTemplateUser findByTemplateIDAndUserID(Long templateID, Long userID);
}
