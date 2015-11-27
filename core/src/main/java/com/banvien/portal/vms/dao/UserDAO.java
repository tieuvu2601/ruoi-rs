package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.UserEntity;

public interface UserDAO extends GenericDAO<UserEntity, Long> {
    UserEntity findByUserName(String username);

    public UserEntity findUserByUsernameAndPasswordFromDB(String username, String password);

    List<UserEntity> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
