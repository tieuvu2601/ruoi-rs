package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.CategoryTypeDAO;
import com.banvien.portal.vms.domain.CategoryEntity;
import com.banvien.portal.vms.domain.CategoryTypeEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class CategoryTypeHibernateDAO extends AbstractHibernateDAO<CategoryTypeEntity, Long> implements CategoryTypeDAO {
    @Override
    public List<CategoryTypeEntity> findAllCategoryType() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<CategoryTypeEntity>>() {
                    public List<CategoryTypeEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session.createQuery(" FROM CategoryTypeEntity cte WHERE cte.displayOrder IS NOT NULL AND cte.displayOrder > 0 ORDER BY cte.displayOrder ASC ");
                        return (List<CategoryTypeEntity>) query.list();
                    }
                });
    }
}
