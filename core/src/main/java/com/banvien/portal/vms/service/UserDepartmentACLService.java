package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.UserDepartmentACL;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:40 PM
 * Author: vien.nguyen@banvien.com
 */
public interface UserDepartmentACLService extends GenericService<UserDepartmentACL, Long> {

    UserDepartmentACL getItemByDepartmentAndUser(Long departmentID, Long loginUserId) throws ObjectNotFoundException;

    void updateUserACL(Long userID, Long[] departmentIDsInPage, String[] checkList);
}
