package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.TrackingDAO;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.TrackingService;

import java.sql.Timestamp;

public class TrackingServiceImpl extends GenericServiceImpl<Tracking, Long> implements TrackingService {
    private TrackingDAO trackingDAO;

    public void setTrackingDAO(TrackingDAO trackingDAO) {
        this.trackingDAO = trackingDAO;
    }

    @Override
    protected GenericDAO<Tracking, Long> getGenericDAO() {
        return trackingDAO;
    }
    
    @Override
    public void updateItem(Tracking pojo) throws ObjectNotFoundException, DuplicateException {

        Tracking dbItem = this.trackingDAO.findByIdNoAutoCommit(pojo.getTrackingID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getTrackingID());

        pojo.setTrackingDate(new Timestamp(System.currentTimeMillis()));
        this.trackingDAO.detach(dbItem);
        this.trackingDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                trackingDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }



    @Override
    public Tracking findTrackingByContentIDAndCode(Long contentID, String code){
        return trackingDAO.findTrackingByContentIDAndCode(contentID, code);
    }
}
