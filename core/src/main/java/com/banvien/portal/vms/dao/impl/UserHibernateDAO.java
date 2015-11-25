package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.domain.User;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class UserHibernateDAO extends AbstractHibernateDAO<User, Long> implements UserDAO {

    @Override
    public User findByUserName(final String username) {
        return getHibernateTemplate().execute(
                new HibernateCallback<User>() {
                    public User doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE LOWER(u.username) = :username");
                        query.setParameter("username", username.toLowerCase());
                        return (User) query.uniqueResult();
                    }
                });
    }

	@Override
	public List<User> findByGroupCode(final String groupCode) {
		return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE u.userGroup.code = :groupCode");
                        query.setParameter("groupCode", groupCode);
                        return (List<User>) query.list();
                    }
                });
	}

	@Override
	public List<User> findByListUserName(final List<String> userNameList) {
		return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE u.username in(:userNames)");
                        query.setParameterList("userNames", userNameList);
                        return (List<User>) query.list();
                    }
                });
	}

	@Override
	public List<User> findByListGroupCode(final List<String> groupCodeList) {
		return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE u.userGroup.code in(:groupCodeList)");
                        query.setParameterList("groupCodeList", groupCodeList);
                        return (List<User>) query.list();
                    }
                });
	}

	@Override
	public List<User> findByListUserNameExcludeSender(
			final List<String> userNameList, final String senderMail) {
			return getHibernateTemplate().execute(
                new HibernateCallback<List<User>>() {
                    public List<User> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE u.username in(:userNames) AND u.email <> :sender");
                        query.setParameterList("userNames", userNameList);
                        query.setParameter("sender", senderMail);
                        return (List<User>) query.list();
                    }
                });
	}


    @Override
    public User findUserByUsernameAndPasswordFromDB(final String username, final String password) {
        return getHibernateTemplate().execute(
                new HibernateCallback<User>() {
                    public User doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM User u WHERE u.username = :username AND u.password = :password");
                        query.setParameter("username", username);
                        query.setParameter("password", password);
                        return (User) query.uniqueResult();
                    }
                });
    }
}
