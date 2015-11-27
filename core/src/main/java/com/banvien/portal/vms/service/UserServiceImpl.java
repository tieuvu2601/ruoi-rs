package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.*;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserDepartmentACL;
import com.banvien.portal.vms.domain.UserRole;
import com.banvien.portal.vms.dto.C2UserDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.log4j.Logger;

import java.sql.Timestamp;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:59 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserServiceImpl extends GenericServiceImpl<User, Long> implements UserService {

    private transient final Logger logger = Logger.getLogger(getClass());

    private UserDAO userDAO;

    private RoleDAO roleDAO;

    private UserRoleDAO userRoleDAO;

    private UserDepartmentACLDAO userDepartmentACLDAO;

    public RoleDAO getRoleDAO() {
        return roleDAO;
    }

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    public UserRoleDAO getUserRoleDAO() {
        return userRoleDAO;
    }

    public void setUserRoleDAO(UserRoleDAO userRoleDAO) {
        this.userRoleDAO = userRoleDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public UserDepartmentACLDAO getUserDepartmentACLDAO() {
        return userDepartmentACLDAO;
    }

    public void setUserDepartmentACLDAO(UserDepartmentACLDAO userDepartmentACLDAO) {
        this.userDepartmentACLDAO = userDepartmentACLDAO;
    }

    @Override
    protected GenericDAO<User, Long> getGenericDAO() {
        return userDAO;
    }

    @Override
    public  User findByEmail(String Email) throws ObjectNotFoundException {
        User res = userDAO.findEqualUnique("email", Email);
        if (res == null) throw new ObjectNotFoundException("Not found authoring email " + Email);
        return res;
    }

    @Override
    public void updateItem(User pojo) throws ObjectNotFoundException, DuplicateException {

        User dbItem = this.userDAO.findByIdNoAutoCommit(pojo.getUserID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserID());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.userDAO.detach(dbItem);
        this.userDAO.update(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                List<UserRole> listRoles = userRoleDAO.findByUserId(Long.parseLong(id));
                userRoleDAO.deleteAll(listRoles);
                List<UserDepartmentACL> listUserDepartments = userDepartmentACLDAO.findUserDepartmentByUserID(Long.parseLong(id));
                userDepartmentACLDAO.deleteAll(listUserDepartments);
                userDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

	@Override
	public List<User> findByGroupCode(String groupCode) {
		return userDAO.findByGroupCode(groupCode);
	}

	@Override
	public List<User> findByListUserName(List<String> userNameList) {
		return userDAO.findByListUserName(userNameList);
	}

	@Override
	public List<User> findByListGroupCode(List<String> groupCodeList) {
		return userDAO.findByListGroupCode(groupCodeList);
	}

    @Override
    public C2UserDTO findC2UserByUsername(String username) {
        return userDAO.findC2UserByUsername(username);
    }

    @Override
    public User findByUserName(String username) {
        return userDAO.findByUserName(username);
    }

	@Override
	public List<User> findByListUserNameExcludeSender(
			List<String> userNameList, String senderMail) {
		return userDAO.findByListUserNameExcludeSender(userNameList, senderMail);
	}

}
