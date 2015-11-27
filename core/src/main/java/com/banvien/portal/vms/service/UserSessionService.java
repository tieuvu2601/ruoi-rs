package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface UserSessionService extends GenericService<UserSession, Long> {
    UserSession getTotalVisitors() throws ObjectNotFoundException;
    void updateNumberOfVisitors(UserSession userSession) throws ObjectNotFoundException;
}
