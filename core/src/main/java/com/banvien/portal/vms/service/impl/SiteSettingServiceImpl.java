package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.LocationDAO;
import com.banvien.portal.vms.dao.SiteSettingDAO;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.domain.SiteSettingEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.LocationService;
import com.banvien.portal.vms.service.SiteSettingService;

import java.util.List;

public class SiteSettingServiceImpl extends GenericServiceImpl<SiteSettingEntity, Long> implements SiteSettingService {
    private SiteSettingDAO siteSettingDAO;

    public void setSiteSettingDAO(SiteSettingDAO siteSettingDAO) {
        this.siteSettingDAO = siteSettingDAO;
    }

    @Override
    protected GenericDAO<SiteSettingEntity, Long> getGenericDAO() {
        return siteSettingDAO;
    }


    @Override
    public SiteSettingEntity getSiteSetting() throws ObjectNotFoundException {
        List<SiteSettingEntity> entityList = this.siteSettingDAO.findAll();
        if(entityList == null || entityList.size() < 1){
            throw new ObjectNotFoundException("Cannot find Site Setting");
        }
        return entityList.get(0);
    }
}