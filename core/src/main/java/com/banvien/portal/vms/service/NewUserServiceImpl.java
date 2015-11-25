package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.NewUserDAO;
import com.banvien.portal.vms.dao.NewUserGroupDAO;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.domain.UserGroupEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.log4j.Logger;

import java.sql.Timestamp;


public class NewUserServiceImpl extends GenericServiceImpl<UserEntity, Long> implements NewUserService {

    private transient final Logger logger = Logger.getLogger(getClass());

    private NewUserDAO userDAO;

    private NewUserGroupDAO userGroupDAO;

    public NewUserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(NewUserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    protected GenericDAO<UserEntity, Long> getGenericDAO() {
        return userDAO;
    }


    @Override
    public UserEntity addItem(UserEntity pojo) throws ObjectNotFoundException, DuplicateException {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(now);
        return this.userDAO.save(pojo);
    }

    @Override
    public UserEntity updateItem(UserEntity pojo) throws ObjectNotFoundException, DuplicateException {
        UserEntity dbItem = this.userDAO.findByIdNoAutoCommit(pojo.getUserId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserId());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.userDAO.detach(dbItem);
        return this.userDAO.update(pojo);
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
    public UserEntity findByUserName(String username) {
        return userDAO.findByUserName(username);
    }


    @Override
    public  UserEntity findByEmail(String Email) throws ObjectNotFoundException {
        UserEntity res = userDAO.findEqualUnique("email", Email);
        if (res == null) throw new ObjectNotFoundException("Not found authoring email " + Email);
        return res;
    }
}
