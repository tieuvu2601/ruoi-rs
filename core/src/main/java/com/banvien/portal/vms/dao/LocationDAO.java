package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.LocationEntity;

import java.util.List;

public interface LocationDAO extends GenericDAO<LocationEntity, Long> {
    List<LocationEntity> findAllLocationParent();

}
