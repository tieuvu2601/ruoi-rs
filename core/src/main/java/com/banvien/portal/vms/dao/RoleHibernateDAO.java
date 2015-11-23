package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Role;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:32 PM
 * Author: vien.nguyen@banvien.com
 */
public class RoleHibernateDAO extends AbstractHibernateDAO<Role, Long> implements RoleDAO {
    @Override
    public List<Role> findByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Role>>() {
                    public List<Role> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT ur.role FROM UserRole ur WHERE ur.user.userID = :userID");
                        query.setParameter("userID", userID);
                        return (List<Role>) query.list();
                    }
                });
    }
}
