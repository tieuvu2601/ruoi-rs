package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.AuthoringTemplateUGroup;

public interface AuthoringTemplateUGroupService extends GenericService<AuthoringTemplateUGroup, Long> {
	public AuthoringTemplateUGroup findByTemplateIDAndUserGroupID(Long templateID, Long userGroupID );
}
