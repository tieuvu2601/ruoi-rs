package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.UserGroupDAO;
import com.banvien.portal.vms.domain.UserGroupEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserGroupService;

import java.sql.Timestamp;

public class UserGroupServiceImpl extends GenericServiceImpl<UserGroupEntity, Long> implements UserGroupService {
    private UserGroupDAO userGroupDAO;

    public void setUserGroupDAO(UserGroupDAO userGroupDAO) {
        this.userGroupDAO = userGroupDAO;
    }

    @Override
    protected GenericDAO<UserGroupEntity, Long> getGenericDAO() {
        return userGroupDAO;
    }

    @Override
    public UserGroupEntity findByCode(String code) throws ObjectNotFoundException {
        UserGroupEntity res = this.userGroupDAO.findEqualUnique("code", code);
        if (res == null) throw  new ObjectNotFoundException("Not found user group with code " + code);
        return res;
    }
    
    @Override
    public void updateItem(UserGroupEntity pojo) throws ObjectNotFoundException, DuplicateException {

        UserGroupEntity dbItem = this.userGroupDAO.findByIdNoAutoCommit(pojo.getUserGroupId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserGroupId());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.userGroupDAO.detach(dbItem);
        this.userGroupDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userGroupDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }    
    
}
