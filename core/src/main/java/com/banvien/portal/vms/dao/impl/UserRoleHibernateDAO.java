package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.UserRoleDAO;
import com.banvien.portal.vms.domain.UserRole;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class UserRoleHibernateDAO extends AbstractHibernateDAO<UserRole, Long> implements UserRoleDAO {

    @Override
    public List<UserRole> findByUserId(final Long userId) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserRole>>() {
                    public List<UserRole> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserRole ur WHERE ur.user.userID = :userID");
                        query.setParameter("userID", userId);
                        return (List<UserRole>) query.list();
                    }
                });
    }
}
