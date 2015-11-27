package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.AuthoringTemplateUser;

public interface AuthoringTemplateUserService extends GenericService<AuthoringTemplateUser, Long> {
	public AuthoringTemplateUser findByTemplateIDAndUserID(Long templateID, Long userID);
}
