package com.banvien.portal.vms.dao;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.AuthoringTemplateUGroup;
import com.banvien.portal.vms.domain.User;

public class AuthoringTemplateUGroupHibernateDAO extends AbstractHibernateDAO<AuthoringTemplateUGroup, Long> implements AuthoringTemplateUGroupDAO{
	
	public AuthoringTemplateUGroup findByTemplateIDAndUserGroupID(final Long templateID, final Long userGroupID ) {
		return getHibernateTemplate().execute(
                new HibernateCallback<AuthoringTemplateUGroup>() {
                	
                    public AuthoringTemplateUGroup doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM AuthoringTemplateUGroup au WHERE au.authoringTemplateID = :templateID and au.userGroupID = :userGroupID");
                        query.setParameter("templateID", templateID);
                        query.setParameter("userGroupID", userGroupID);
                        List<AuthoringTemplateUGroup> list = (List<AuthoringTemplateUGroup>)query.list();
                        return list.size() > 0 ? list.get(0) : null;
                    }
                    
                });
	}
}
