package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserSessionDAO extends GenericDAO<UserSession, Long> {
    UserSession getTotalVisitors() throws ObjectNotFoundException;
}
