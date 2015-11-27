package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.Role;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:57 PM
 * Author: vien.nguyen@banvien.com
 */
public class RoleServiceImpl extends GenericServiceImpl<Role, Long> implements RoleService {
    private RoleDAO roleDAO;

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    @Override
    protected GenericDAO<Role, Long> getGenericDAO() {
        return roleDAO;
    }

    @Override
    public Role findByRole(String role) throws ObjectNotFoundException {
        Role res = roleDAO.findEqualUnique("role", role);
        if (res == null) throw new ObjectNotFoundException("Not found role " + role);
        return res;
    }
    
    @Override
    public void updateItem(Role pojo) throws ObjectNotFoundException, DuplicateException {

        Role dbItem = this.roleDAO.findByIdNoAutoCommit(pojo.getRoleID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getRoleID());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.roleDAO.detach(dbItem);
        this.roleDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                roleDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }    
    
}
