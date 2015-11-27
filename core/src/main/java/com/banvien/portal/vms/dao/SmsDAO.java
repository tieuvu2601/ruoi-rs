package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.Sms;

public interface SmsDAO extends GenericDAO<Sms, Long> {
	void deleteByContentIds(List<Long> contentIds);
}
