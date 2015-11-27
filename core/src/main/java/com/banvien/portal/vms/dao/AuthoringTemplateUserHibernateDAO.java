package com.banvien.portal.vms.dao;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.AuthoringTemplateUser;

public class AuthoringTemplateUserHibernateDAO extends AbstractHibernateDAO<AuthoringTemplateUser, Long> implements AuthoringTemplateUserDAO{
	public AuthoringTemplateUser findByTemplateIDAndUserID(final Long templateID, final Long userID ) {
		return getHibernateTemplate().execute(
                new HibernateCallback<AuthoringTemplateUser>() {
                	
                    public AuthoringTemplateUser doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM AuthoringTemplateUser au WHERE au.authoringTemplateID = :templateID and au.userID = :userID");
                        query.setParameter("templateID", templateID);
                        query.setParameter("userID", userID);
                        List<AuthoringTemplateUser> list = (List<AuthoringTemplateUser>)query.list();
                        return list.size() > 0 ? list.get(0) : null;
                    }
                    
                });
	}
}
