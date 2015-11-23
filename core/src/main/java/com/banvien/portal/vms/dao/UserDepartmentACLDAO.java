package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserDepartmentACL;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:24 PM
 * Author: vien.nguyen@banvien.com
 */
public interface UserDepartmentACLDAO extends GenericDAO<UserDepartmentACL, Long> {

    UserDepartmentACL getItemByDepartmentAndUser(Long departmentID, Long userID);

    List<UserDepartmentACL> findByDepartmentsOfUser(Long userID, Long[] departmentIDsInPage);

    List<UserDepartmentACL> findUserDepartmentByUserID(Long userID);
}
