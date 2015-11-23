package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.dto.C2UserDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface UserService extends GenericService<User, Long> {
    User findByEmail(String email) throws ObjectNotFoundException;

    void updateItem(User userBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    List<User> findByGroupCode(String groupCode);
    
    List<User> findByListUserName(List<String> userNameList);
    
    List<User> findByListGroupCode(final List<String> groupCodeList);

    C2UserDTO findC2UserByUsername(String username);

    User findByUserName(String username);
    
    List<User> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
