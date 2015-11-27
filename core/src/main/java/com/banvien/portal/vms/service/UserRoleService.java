package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.domain.UserRole;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface UserRoleService extends GenericService<UserRole, Long> {

    void updateItem(UserRole pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Integer updateItemsByUserRole(UserBean usr);

}
