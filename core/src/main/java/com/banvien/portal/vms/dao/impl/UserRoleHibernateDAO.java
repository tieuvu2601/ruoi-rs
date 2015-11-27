package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.UserRoleDAO;
import com.banvien.portal.vms.domain.UserRoleEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class UserRoleHibernateDAO extends AbstractHibernateDAO<UserRoleEntity, Long> implements UserRoleDAO {

    @Override
    public List<UserRoleEntity> findByUserId(final Long userId) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserRoleEntity>>() {
                    public List<UserRoleEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserRole ur WHERE ur.user.userID = :userID");
                        query.setParameter("userID", userId);
                        return (List<UserRoleEntity>) query.list();
                    }
                });
    }
}
