package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.UserSessionDAO;
import com.banvien.portal.vms.domain.UserSession;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;

public class UserSessionHibernateDAO extends AbstractHibernateDAO<UserSession, Long> implements UserSessionDAO {

    @Override
    public UserSession getTotalVisitors() {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserSession>() {
                    public UserSession doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserSession us");
                        return (UserSession) query.uniqueResult();
                    }
                });
    }

}
