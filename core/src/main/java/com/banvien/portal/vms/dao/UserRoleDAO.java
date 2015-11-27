package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserRole;

import java.util.List;

public interface UserRoleDAO extends GenericDAO<UserRole, Long> {
    List<UserRole> findByUserId(Long userId);

}
