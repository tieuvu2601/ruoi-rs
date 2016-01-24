package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.domain.SiteSettingEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface SiteSettingService extends GenericService<SiteSettingEntity, Long> {

    SiteSettingEntity getSiteSetting() throws ObjectNotFoundException;

}
