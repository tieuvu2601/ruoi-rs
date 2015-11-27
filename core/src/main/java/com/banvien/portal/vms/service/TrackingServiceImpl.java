package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.TrackingBean;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.TrackingDAO;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.tools.ant.util.DateUtils;

import java.sql.Timestamp;
import java.util.*;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:58 PM
 * Author: vien.nguyen@banvien.com
 */
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
    public Object[] find4Content(TrackingBean trackingBean) {
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");

        if (trackingBean.getPojo().getContent().getContentID() != null) {
            properties.put("content.contentID", trackingBean.getPojo().getContent().getContentID());
        }
        if (trackingBean.getFromDate() != null) {
            Calendar calStart = new GregorianCalendar();
            Date date = new Date(trackingBean.getFromDate().getYear(), trackingBean.getFromDate().getMonth(), trackingBean.getFromDate().getDate());
            calStart.setTime(date);
            calStart.add(Calendar.DATE, 1);
            date = calStart.getTime();

            String datimeStr = DateUtils.format(trackingBean.getFromDate(), "dd-MMM-yyyy"); //df.format(now);
            whereClause.append(" AND to_date(trackingDate) >= '").append(datimeStr).append("'");
        }
        if (trackingBean.getToDate() != null) {
            Calendar calStart = new GregorianCalendar();
            Date date = new Date(trackingBean.getToDate().getYear(), trackingBean.getToDate().getMonth(), trackingBean.getToDate().getDate());
            calStart.setTime(date);
            calStart.add(Calendar.DATE, 1);
            date = calStart.getTime();

            String datimeStr = DateUtils.format(date,"dd-MMM-yyyy");
            whereClause.append(" AND to_date(trackingDate) <= '").append(datimeStr.toString()).append("'");
        }

        return trackingDAO.searchByProperties(properties, trackingBean.getFirstItem(), trackingBean.getMaxPageItems() , trackingBean.getSortExpression(), trackingBean.getSortDirection() ,true, whereClause.toString());
    }

    @Override
    public Tracking findTrackingByContentIDAndCode(Long contentID, String code){
        return trackingDAO.findTrackingByContentIDAndCode(contentID, code);
    }

    @Override
    public TrackingDTO findTotalTrackingByContentID(Long contentID) {
        return trackingDAO.findTotalTrackingByContentID(contentID);
    }

    @Override
    public List<Tracking> findTopViewContent(Integer pageSize) {
        return trackingDAO.findTopViewContent(pageSize);
    }
}
