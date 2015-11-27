package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserService extends GenericService<User, Long> {
    User findByEmail(String email) throws ObjectNotFoundException;

    void updateItem(User userBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    User findByUserName(String username);

    List<User> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
