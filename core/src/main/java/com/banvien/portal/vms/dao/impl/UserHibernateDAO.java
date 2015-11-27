package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.domain.UserEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class UserHibernateDAO extends AbstractHibernateDAO<UserEntity, Long> implements UserDAO {

    @Override
    public UserEntity findByUserName(final String userName) {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserEntity>() {
                    public UserEntity doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserEntity u WHERE LOWER(u.username) = :userName");
                        query.setParameter("userName", userName.toLowerCase());
                        return (UserEntity) query.uniqueResult();
                    }
                });
    }

	@Override
	public List<UserEntity> findByListUserNameExcludeSender(
			final List<String> userNameList, final String senderMail) {
			return getHibernateTemplate().execute(
                new HibernateCallback<List<UserEntity>>() {
                    public List<UserEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserEntity u WHERE u.userName in(:username) AND u.email <> :sender");
                        query.setParameterList("userNames", userNameList);
                        query.setParameter("sender", senderMail);
                        return (List<UserEntity>) query.list();
                    }
                });
	}


    @Override
    public UserEntity findUserByUsernameAndPasswordFromDB(final String username, final String password) {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserEntity>() {
                    public UserEntity doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserEntity u WHERE u.username = :username AND u.password = :password");
                        query.setParameter("username", username);
                        query.setParameter("password", password);
                        return (UserEntity) query.uniqueResult();
                    }
                });
    }
}
