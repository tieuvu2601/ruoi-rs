package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:23 PM
 * Author: vien.nguyen@banvien.com
 */
public interface DepartmentDAO extends GenericDAO<Department, Long> {
    List<Department> findAllAndOrderByName();

    Department findDepartmentByShopCode(String shopcode) throws ObjectNotFoundException;
}
