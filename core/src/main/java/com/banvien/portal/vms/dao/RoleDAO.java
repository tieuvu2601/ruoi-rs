package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.RoleEntity;

import java.util.List;

public interface RoleDAO extends GenericDAO<RoleEntity, Long> {
    List<RoleEntity> findByUserID(Long userID);
}
