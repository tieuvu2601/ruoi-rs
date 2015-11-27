package com.banvien.portal.vms.dao;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.Sms;

public class SmsHibernateDAO extends AbstractHibernateDAO<Sms, Long> implements SmsDAO {

	@Override
	public void deleteByContentIds(final List<Long> contentIds) {
		getHibernateTemplate().execute(
                new HibernateCallback<Integer>() {
                    public Integer doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session.createQuery("delete from Sms sms where sms.content.contentID in(:contentIDs)");
                        query.setParameterList("contentIDs", contentIds);
                        return query.executeUpdate();
                    }
                });
	}
   
}
