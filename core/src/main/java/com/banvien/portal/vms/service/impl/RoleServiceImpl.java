package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.RoleService;

import java.sql.Timestamp;

public class RoleServiceImpl extends GenericServiceImpl<RoleEntity, Long> implements RoleService {
    private RoleDAO roleDAO;

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    @Override
    protected GenericDAO<RoleEntity, Long> getGenericDAO() {
        return roleDAO;
    }

    @Override
    public RoleEntity findByRole(String role) throws ObjectNotFoundException {
        RoleEntity res = roleDAO.findEqualUnique("role", role);
        if (res == null) throw new ObjectNotFoundException("Not found role " + role);
        return res;
    }
    
    @Override
    public void updateItem(RoleEntity pojo) throws ObjectNotFoundException, DuplicateException {

        RoleEntity dbItem = this.roleDAO.findByIdNoAutoCommit(pojo.getRoleId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getRoleId());

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
