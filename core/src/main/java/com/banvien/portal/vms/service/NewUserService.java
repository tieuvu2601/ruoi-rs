package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.dto.C2UserDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface NewUserService extends GenericService<UserEntity, Long> {
    UserEntity addItem(UserEntity pojo) throws ObjectNotFoundException, DuplicateException;

    UserEntity updateItem(UserEntity pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    UserEntity findByUserName(String username);

    UserEntity findByEmail(String email) throws ObjectNotFoundException;
}
