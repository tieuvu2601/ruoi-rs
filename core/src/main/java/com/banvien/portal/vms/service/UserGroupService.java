package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.UserGroup;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserGroupService extends GenericService<UserGroup, Long> {
    UserGroup findByCode(String code) throws ObjectNotFoundException;
    void updateItem(UserGroup bean) throws ObjectNotFoundException, DuplicateException;
    Integer deleteItems(String[] checkList);
}
