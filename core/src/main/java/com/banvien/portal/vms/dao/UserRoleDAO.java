package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserRole;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:19 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserRoleDAO extends GenericDAO<UserRole, Long> {
    List<UserRole> findByUserId(Long userId);

}
