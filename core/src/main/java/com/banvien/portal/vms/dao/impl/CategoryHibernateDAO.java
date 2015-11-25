package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.CategoryDAO;
import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.util.Constants;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:33 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryHibernateDAO extends AbstractHibernateDAO<Category, Long> implements CategoryDAO {
    @Override
    public List<Category> findByAuthoringTemplate(final String authoringTemplateCode) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Category c WHERE c.authoringTemplate.code = :authoringTemplateCode ORDER BY c.displayOrder ASC");
                        query.setParameter("authoringTemplateCode", authoringTemplateCode);
                        return (List<Category>) query.list();
                    }
                });
    }

    @Override
    public List<Category> findByAuthoringTemplateAndUser(final Long authoringTemplateID, final Long loginUserId) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder strQuery = new StringBuilder("SELECT c FROM Category c WHERE c.authoringTemplate.authoringTemplateID = :authoringTemplateID ");
                        strQuery.append(" AND (c.categoryID IN (SELECT categoryID FROM CategoryShowAll WHERE displayAll = :displayAllYes)")
                                .append(" OR c.categoryID IN (SELECT cg.categoryID FROM CategoryUserGroup cg, User u WHERE cg.userGroupID = u.userGroup.userGroupID AND u.userID = :loginUserID)")
                                .append(" OR c.categoryID IN (SELECT cu.categoryID FROM CategoryUser cu WHERE cu.userID = :loginUserID))");
                        Query query = session.createQuery(strQuery.toString());
                        query.setParameter("authoringTemplateID", authoringTemplateID);
                        query.setParameter("displayAllYes", Constants.FLAG_YES);
                        query.setParameter("loginUserID", loginUserId);
                        return (List<Category>) query.list();
                    }
                });
    }

    @Override
    public List<Category> findByAuthoringTemplateID(final Long authoringTemplateID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Category c WHERE c.authoringTemplate.authoringTemplateID = :authoringTemplateID ORDER BY c.displayOrder ASC");
                        query.setParameter("authoringTemplateID", authoringTemplateID);
                        return (List<Category>) query.list();
                    }
                });
    }

    @Override
    public List<Category> findAllByCategory(final long id) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuffer sql = new StringBuffer("SELECT c FROM Category c WHERE 1 = 1 ");
                        if(id > 0l){
                            sql.append(" AND c.parentRootID = :idroot") ;
                        }
                        Query query = session
                                .createQuery(sql.toString());
                        if(id > 0l){
                            query.setParameter("idroot", id);
                        }
                        return (List<Category>) query.list();
                    }
                });
    }

    @Override
    public List<Category> findAllCategoryParent() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Category c WHERE c.parentCategory IS NULL ORDER BY c.displayOrder ASC");

                        return (List<Category>) query.list();
                    }
                });
    }

    @Override
    public List<Category> findCategoryForBuildMenu(final Boolean isEng) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Category>>() {
                    public List<Category> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Category c WHERE c.parentCategory IS NULL AND c.eng = :isEng  ORDER BY c.displayOrder ASC");
                        query.setParameter("isEng", isEng);
                        return (List<Category>) query.list();
                    }
                });
    }

}
