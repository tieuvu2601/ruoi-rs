package com.banvien.portal.vms.dao;

import java.util.List;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.dto.C2UserDTO;

/**
 * Created with IntelliJ IDEA.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:18 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserDAO extends GenericDAO<User, Long> {
    User findByUserName(String username);
    List<User> findByGroupCode(String groupCode);
    List<User> findByListUserName(List<String> userNameList);
    List<User> findByListGroupCode(List<String> groupCodeList);

    public C2UserDTO findC2UserByUsername(String username);
    public C2UserDTO findC2UserByUsernameAndPassword(String username, String password);

    public User findUserByUsernameAndPasswordFromDB(String username, String password);


    List<User> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
