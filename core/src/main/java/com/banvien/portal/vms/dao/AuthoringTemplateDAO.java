package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.AuthoringTemplate;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:23 PM
 * Author: vien.nguyen@banvien.com
 */
public interface AuthoringTemplateDAO extends GenericDAO<AuthoringTemplate, Long> {
	public List<AuthoringTemplate> findByUserId(Long loginUserId);
}
