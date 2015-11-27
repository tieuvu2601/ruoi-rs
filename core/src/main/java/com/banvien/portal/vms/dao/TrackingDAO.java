package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;

import java.util.List;

public interface TrackingDAO extends GenericDAO<Tracking, Long>{
    Tracking findTrackingByContentIDAndCode(Long contentID, String code);
    List<Tracking> findTopViewContent(Integer pageSize);

    TrackingDTO findTotalTrackingByContentID(Long contentID);
}
