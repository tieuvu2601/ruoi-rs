package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:18 PM
 * To change this template use File | Settings | File Templates.
 */
public interface UserSessionDAO extends GenericDAO<UserSession, Long> {
    UserSession getTotalVisitors() throws ObjectNotFoundException;
}
