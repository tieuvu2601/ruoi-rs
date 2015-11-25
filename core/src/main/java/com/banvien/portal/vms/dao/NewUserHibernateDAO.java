package com.banvien.portal.vms.dao;


import com.banvien.portal.vms.domain.UserEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;


public class NewUserHibernateDAO extends AbstractHibernateDAO<UserEntity, Long> implements NewUserDAO {

    @Override
    public UserEntity findByUserName(final String username) {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserEntity>() {
                    public UserEntity doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM UserEntity u WHERE LOWER(u.username) = :username");
                        query.setParameter("username", username.toLowerCase());
                        return (UserEntity) query.uniqueResult();
                    }
                });
    }

    @Override
    public UserEntity findUserByUsernameAndPasswordFromDB(final String username, final String password) {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserEntity>() {
                    public UserEntity doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM UserEntity u WHERE u.username = :username AND u.password = :password");
                        query.setParameter("username", username);
                        query.setParameter("password", password);
                        return (UserEntity) query.uniqueResult();
                    }
                });
    }
}
