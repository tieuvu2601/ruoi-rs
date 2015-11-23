package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.Sms;


public interface SmsService extends GenericService<Sms, Long> {
	void deleteByContentIds(List<Long> contentIds);
}
