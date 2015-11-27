package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.UserGroupDAO;
import com.banvien.portal.vms.domain.UserGroup;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserGroupService;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:58 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserGroupServiceImpl extends GenericServiceImpl<UserGroup, Long> implements UserGroupService {
    private UserGroupDAO userGroupDAO;

    public void setUserGroupDAO(UserGroupDAO userGroupDAO) {
        this.userGroupDAO = userGroupDAO;
    }

    @Override
    protected GenericDAO<UserGroup, Long> getGenericDAO() {
        return userGroupDAO;
    }

    @Override
    public UserGroup findByCode(String code) throws ObjectNotFoundException {
        UserGroup res = this.userGroupDAO.findEqualUnique("code", code);
        if (res == null) throw  new ObjectNotFoundException("Not found user group with code " + code);
        return res;
    }
    
    @Override
    public void updateItem(UserGroup pojo) throws ObjectNotFoundException, DuplicateException {

        UserGroup dbItem = this.userGroupDAO.findByIdNoAutoCommit(pojo.getUserGroupID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserGroupID());

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
