package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.LocationDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.LocationService;

public class LocationServiceImpl extends GenericServiceImpl<LocationEntity, Long> implements LocationService {
    private LocationDAO locationDAO;

    public void setLocationDAO(LocationDAO categoryDAO) {
        this.locationDAO = categoryDAO;
    }

    @Override
    protected GenericDAO<LocationEntity, Long> getGenericDAO() {
        return locationDAO;
    }

    @Override
    public LocationEntity findByCode(String Code) throws ObjectNotFoundException{
        LocationEntity res = locationDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring category " + Code);
        return res;
    }

    @Override
    public LocationEntity updateItem(LocationEntity pojo) throws ObjectNotFoundException, DuplicateException {
        LocationEntity dbItem = this.locationDAO.findByIdNoAutoCommit(pojo.getLocationId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Location " + pojo.getLocationId());
        this.locationDAO.detach(dbItem);
        return this.locationDAO.update(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                locationDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
}