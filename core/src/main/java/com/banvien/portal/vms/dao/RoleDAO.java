package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Role;

import java.util.List;

public interface RoleDAO extends GenericDAO<Role, Long> {
    List<Role> findByUserID(Long userID);
}
