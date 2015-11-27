package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.TrackingBean;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface TrackingService extends GenericService<Tracking, Long> {

    void updateItem(Tracking bean) throws ObjectNotFoundException, DuplicateException;
    Integer deleteItems(String[] checkList);

    Tracking findTrackingByContentIDAndCode(Long contentID, String code);
}
