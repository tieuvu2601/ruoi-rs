package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserEntity;

import java.util.List;

public interface NewUserDAO extends GenericDAO<UserEntity, Long> {

    UserEntity findByUserName(String username);

    public UserEntity findUserByUsernameAndPasswordFromDB(String username, String password);

}
