package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface LocationService extends GenericService<LocationEntity, Long> {

    LocationEntity findByCode(String Code) throws ObjectNotFoundException;

    LocationEntity updateItem(LocationEntity bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
}
