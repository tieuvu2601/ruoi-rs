package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.*;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.domain.UserRoleEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserService;
import org.apache.log4j.Logger;

import java.sql.Timestamp;
import java.util.List;


public class UserServiceImpl extends GenericServiceImpl<UserEntity, Long> implements UserService {

    private transient final Logger logger = Logger.getLogger(getClass());

    private UserDAO userDAO;

    private RoleDAO roleDAO;

    private UserRoleDAO userRoleDAO;

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

    @Override
    protected GenericDAO<UserEntity, Long> getGenericDAO() {
        return userDAO;
    }

    @Override
    public UserEntity findByEmail(String Email) throws ObjectNotFoundException {
        UserEntity res = userDAO.findEqualUnique("email", Email);
        if (res == null) throw new ObjectNotFoundException("Not found authoring email " + Email);
        return res;
    }

    @Override
    public void updateItem(UserEntity pojo) throws ObjectNotFoundException, DuplicateException {

        UserEntity dbItem = this.userDAO.findByIdNoAutoCommit(pojo.getUserId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserId());

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
                List<UserRoleEntity> listRoles = userRoleDAO.findByUserId(Long.parseLong(id));
                userRoleDAO.deleteAll(listRoles);
                userDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public UserEntity findByUserName(String username) {
        return userDAO.findByUserName(username);
    }

	@Override
	public List<UserEntity> findByListUserNameExcludeSender(
			List<String> userNameList, String senderMail) {
		return userDAO.findByListUserNameExcludeSender(userNameList, senderMail);
	}

}
