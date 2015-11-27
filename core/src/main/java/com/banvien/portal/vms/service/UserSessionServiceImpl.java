package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.UserSessionDAO;
import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.log4j.Logger;
/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserSessionServiceImpl extends GenericServiceImpl<UserSession, Long> implements UserSessionService {

    private transient final Logger logger = Logger.getLogger(getClass());

    public UserSessionDAO getUserSessionDAO() {
        return userSessionDAO;
    }

    public void setUserSessionDAO(UserSessionDAO userSessionDAO) {
        this.userSessionDAO = userSessionDAO;
    }

    private UserSessionDAO userSessionDAO;

    @Override
    public UserSession getTotalVisitors() throws ObjectNotFoundException {
        return userSessionDAO.getTotalVisitors();
    }

    @Override
    public void updateNumberOfVisitors(UserSession userSession) throws ObjectNotFoundException {
        userSessionDAO.update(userSession);
    }

    @Override
    protected GenericDAO<UserSession, Long> getGenericDAO() {
        return userSessionDAO;
    }
}