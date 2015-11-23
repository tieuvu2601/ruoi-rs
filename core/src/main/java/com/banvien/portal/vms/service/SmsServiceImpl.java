package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.SmsDAO;
import com.banvien.portal.vms.domain.Sms;

public class SmsServiceImpl extends GenericServiceImpl<Sms, Long> implements SmsService {
	
    private SmsDAO smsDAO;

    @Override
    protected GenericDAO<Sms, Long> getGenericDAO() {
        return smsDAO;
    }

	public void setSmsDAO(SmsDAO smsDAO) {
		this.smsDAO = smsDAO;
	}

	@Override
	public void deleteByContentIds(List<Long> contentIds) {
		smsDAO.deleteByContentIds(contentIds);
	}
}