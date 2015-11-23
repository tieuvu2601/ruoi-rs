package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.AuthoringTemplateUGroup;

public interface AuthoringTemplateUGroupDAO extends GenericDAO<AuthoringTemplateUGroup, Long> {
	public AuthoringTemplateUGroup findByTemplateIDAndUserGroupID(Long templateID, Long userGroupID );
}
