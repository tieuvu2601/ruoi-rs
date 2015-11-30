package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface RoleService extends GenericService<RoleEntity, Long> {
    RoleEntity findByRole(String role) throws ObjectNotFoundException;

    void updateItem(RoleEntity bean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

}
