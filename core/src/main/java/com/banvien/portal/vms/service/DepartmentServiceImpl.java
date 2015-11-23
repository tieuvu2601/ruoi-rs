package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.DepartmentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:53 PM
 * Author: vien.nguyen@banvien.com
 */
public class DepartmentServiceImpl extends GenericServiceImpl<Department, Long> implements DepartmentService {
    private DepartmentDAO departmentDAO;

    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    @Override
    protected GenericDAO<Department, Long> getGenericDAO() {
        return departmentDAO;
    }

    @Override
    public Department findByCode(String Code) throws ObjectNotFoundException
    {
        Department res = departmentDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring department " + Code);
        return res;
    }
    
    @Override
    public void updateItem(Department pojo) throws ObjectNotFoundException, DuplicateException {

        Department dbItem = departmentDAO.findByIdNoAutoCommit(pojo.getDepartmentID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getDepartmentID());
        if (pojo.getIsBranch() == null) {
            pojo.setIsBranch(0);
        }
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.departmentDAO.detach(dbItem);
        this.departmentDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                departmentDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public List<Department> findAll() {
        return this.departmentDAO.findAllAndOrderByName();
    }
    
}
