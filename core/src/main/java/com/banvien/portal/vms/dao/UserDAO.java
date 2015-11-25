package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.User;

public interface UserDAO extends GenericDAO<User, Long> {
    User findByUserName(String username);
    List<User> findByGroupCode(String groupCode);
    List<User> findByListUserName(List<String> userNameList);
    List<User> findByListGroupCode(List<String> groupCodeList);
    public User findUserByUsernameAndPasswordFromDB(String username, String password);
    List<User> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
