package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.TrackingBean;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:41 PM
 * Author: vien.nguyen@banvien.com
 */
public interface TrackingService extends GenericService<Tracking, Long> {

    void updateItem(Tracking bean) throws ObjectNotFoundException, DuplicateException;
    Integer deleteItems(String[] checkList);

    Object[] find4Content(TrackingBean trackingBean);

    List<Tracking> findTopViewContent(Integer pageSize);

    Tracking findTrackingByContentIDAndCode(Long contentID, String code);

    TrackingDTO findTotalTrackingByContentID(Long contentID);
}
