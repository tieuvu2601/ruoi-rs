package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.LocationDAO;
import com.banvien.portal.vms.domain.LocationEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class LocationHibernateDAO extends AbstractHibernateDAO<LocationEntity, Long> implements LocationDAO {

    @Override
    public List<LocationEntity> findAllLocationParent() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<LocationEntity>>() {
                    public List<LocationEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM LocationEntity c WHERE c.parent IS NULL ORDER BY c.displayOrder ASC");

                        return (List<LocationEntity>) query.list();
                    }
                });
    }
}
