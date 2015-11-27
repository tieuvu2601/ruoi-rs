package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Role;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface RoleService extends GenericService<Role, Long> {
    Role findByRole(String role) throws ObjectNotFoundException;

    void updateItem(Role bean) throws ObjectNotFoundException, DuplicateException;
    Integer deleteItems(String[] checkList);

}
