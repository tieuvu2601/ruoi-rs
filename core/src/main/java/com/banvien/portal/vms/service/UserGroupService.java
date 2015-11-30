package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.UserGroupEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserGroupService extends GenericService<UserGroupEntity, Long> {
    UserGroupEntity findByCode(String code) throws ObjectNotFoundException;

    void updateItem(UserGroupEntity bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

}
