package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.AuthoringTemplateEntity;

public interface AuthoringTemplateDAO extends GenericDAO<AuthoringTemplateEntity, Long> {
	public List<AuthoringTemplateEntity> findByUserId(Long loginUserId);
}
