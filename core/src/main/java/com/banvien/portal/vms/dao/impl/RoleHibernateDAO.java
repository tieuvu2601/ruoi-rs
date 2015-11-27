package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.RoleEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class RoleHibernateDAO extends AbstractHibernateDAO<RoleEntity, Long> implements RoleDAO {
    @Override
    public List<RoleEntity> findByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<RoleEntity>>() {
                    public List<RoleEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT ur.role FROM UserRoleEntity ur WHERE ur.user.userId = :userID");
                        query.setParameter("userID", userID);
                        return (List<RoleEntity>) query.list();
                    }
                });
    }
}
