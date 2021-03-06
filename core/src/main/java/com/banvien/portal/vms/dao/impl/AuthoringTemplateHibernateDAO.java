package com.banvien.portal.vms.dao.impl;

import java.sql.SQLException;
import java.util.List;

import com.banvien.portal.vms.dao.AuthoringTemplateDAO;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.util.Constants;

public class AuthoringTemplateHibernateDAO extends AbstractHibernateDAO<AuthoringTemplateEntity, Long> implements AuthoringTemplateDAO {
	
    public List<AuthoringTemplateEntity> findByUserId(final Long loginUserId) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<AuthoringTemplateEntity>>() {
                    public List<AuthoringTemplateEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder strQuery = new StringBuilder("SELECT au FROM AuthoringTemplateEntity au WHERE");
                        strQuery.append(" (au.authoringTemplateID IN (SELECT authoringTemplateID FROM AuthoringTemplateShowAll WHERE displayAll = :displayAllYes)")
                                .append(" OR au.authoringTemplateID IN (SELECT cg.authoringTemplateID FROM AuthoringTemplateUGroup cg, UserEntity u WHERE cg.userGroupID = u.userGroup.userGroupID AND u.userID = :loginUserID)")
                                .append(" OR au.authoringTemplateID IN (SELECT cu.authoringTemplateID FROM AuthoringTemplateUser cu WHERE cu.userID = :loginUserID))");
                        Query query = session.createQuery(strQuery.toString());
                        query.setParameter("displayAllYes", Constants.FLAG_YES);
                        query.setParameter("loginUserID", loginUserId);
                        return (List<AuthoringTemplateEntity>) query.list();
                    }
                });
    }
	
}
