package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:26 PM
 * Author: vien.nguyen@banvien.com
 */
public interface TrackingDAO extends GenericDAO<Tracking, Long>{
    Tracking findTrackingByContentIDAndCode(Long contentID, String code);
    List<Tracking> findTopViewContent(Integer pageSize);

    TrackingDTO findTotalTrackingByContentID(Long contentID);
}
