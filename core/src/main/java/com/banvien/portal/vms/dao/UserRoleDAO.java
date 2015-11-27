package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserRoleEntity;

import java.util.List;

public interface UserRoleDAO extends GenericDAO<UserRoleEntity, Long> {
    List<UserRoleEntity> findByUserId(Long userId);

}
