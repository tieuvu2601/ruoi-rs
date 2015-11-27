package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserService extends GenericService<UserEntity, Long> {
    UserEntity findByEmail(String email) throws ObjectNotFoundException;

    void updateItem(UserEntity userEntityBean) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    UserEntity findByUserName(String username);

    List<UserEntity> findByListUserNameExcludeSender(List<String> userNameList, String senderMail);
}
