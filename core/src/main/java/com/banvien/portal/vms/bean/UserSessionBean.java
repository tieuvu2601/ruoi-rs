package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserRole;
import com.banvien.portal.vms.domain.UserSession;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 5:40 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserSessionBean extends AbstractBean<UserSession> {
    public UserSessionBean()
    {
        this.pojo = new UserSession();
    }
}
