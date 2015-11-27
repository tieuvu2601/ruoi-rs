package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Opinion;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Created with IntelliJ IDEA.
 * User: HauKute
 * Date: 10/21/15
 * Time: 10:48 AM
 * To change this template use File | Settings | File Templates.
 */
public interface OpinionService extends GenericService<Opinion, Long> {
    public Opinion updateItem(Opinion pojo) throws ObjectNotFoundException;
}
