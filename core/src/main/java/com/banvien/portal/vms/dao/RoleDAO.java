package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Role;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:19 PM
 * To change this template use File | Settings | File Templates.
 */
public interface RoleDAO extends GenericDAO<Role, Long> {
    List<Role> findByUserID(Long userID);
}
