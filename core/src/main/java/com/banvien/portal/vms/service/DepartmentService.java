package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface DepartmentService extends GenericService<Department, Long> {
    Department findByCode(String Code) throws ObjectNotFoundException;

    void updateItem(Department pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<Department> findAll();

}
