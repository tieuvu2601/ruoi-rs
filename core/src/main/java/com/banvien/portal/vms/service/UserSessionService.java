package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.Page;
import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface UserSessionService extends GenericService<UserSession, Long> {
    UserSession getTotalVisitors() throws ObjectNotFoundException;
    void updateNumberOfVisitors(UserSession userSession) throws ObjectNotFoundException;
}
