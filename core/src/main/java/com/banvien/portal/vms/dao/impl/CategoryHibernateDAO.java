package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.CategoryDAO;
import com.banvien.portal.vms.domain.CategoryEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class CategoryHibernateDAO extends AbstractHibernateDAO<CategoryEntity, Long> implements CategoryDAO {
    @Override
    public List<CategoryEntity> findByAuthoringTemplate(final String authoringTemplateCode) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<CategoryEntity>>() {
                    public List<CategoryEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM CategoryEntity c WHERE c.authoringTemplate.code = :authoringTemplateCode ORDER BY c.displayOrder ASC");
                        query.setParameter("authoringTemplateCode", authoringTemplateCode);
                        return (List<CategoryEntity>) query.list();
                    }
                });
    }

    @Override
    public List<CategoryEntity> findAllCategoryParent() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<CategoryEntity>>() {
                    public List<CategoryEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM CategoryEntity c WHERE c.parentCategory IS NULL ORDER BY c.displayOrder ASC");

                        return (List<CategoryEntity>) query.list();
                    }
                });
    }

    @Override
    public List<CategoryEntity> findCategoryForBuildMenu(final Boolean isEng) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<CategoryEntity>>() {
                    public List<CategoryEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM CategoryEntity c WHERE c.parentCategory IS NULL AND c.eng = :isEng  ORDER BY c.displayOrder ASC");
                        query.setParameter("isEng", isEng);
                        return (List<CategoryEntity>) query.list();
                    }
                });
    }

}
