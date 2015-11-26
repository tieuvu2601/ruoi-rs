package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.*;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserService;
import org.apache.log4j.Logger;

import java.sql.Timestamp;
import java.util.List;


public class UserServiceImpl extends GenericServiceImpl<User, Long> implements UserService {

    private transient final Logger logger = Logger.getLogger(getClass());

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
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

        User dbItem = this.userDAO.findByIdNoAutoCommit(pojo.getUserId());
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
                userDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
    @Override
    public User findByUserName(String username) {
        return userDAO.findByUserName(username);
    }


}
