package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.domain.UserRole;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserRoleService extends GenericService<UserRole, Long> {

    void updateItem(UserRole pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    Integer updateItemsByUserRole(UserBean usr);

}
