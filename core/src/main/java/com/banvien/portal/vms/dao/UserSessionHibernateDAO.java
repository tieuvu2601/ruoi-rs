package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserSession;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;

/**
 * Created with IntelliJ IDEA.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:18 PM
 * To change this template use File | Settings | File Templates.
 */
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
