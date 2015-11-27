package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.AuthoringTemplate;

public interface AuthoringTemplateDAO extends GenericDAO<AuthoringTemplate, Long> {
	public List<AuthoringTemplate> findByUserId(Long loginUserId);
}
