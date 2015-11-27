package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.domain.Tracking;
import com.banvien.portal.vms.dto.TrackingDTO;
import org.hibernate.*;
import org.hibernate.annotations.Type;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.logging.SimpleFormatter;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:33 PM
 * Author: vien.nguyen@banvien.com
 */
public class TrackingHibernateDAO extends AbstractHibernateDAO<Tracking, Long> implements TrackingDAO {
    @Override
    public Tracking findTrackingByContentIDAndCode(final Long contentID, final String code) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Tracking>() {
                    public Tracking doInHibernate(Session session)
                            throws HibernateException, SQLException {

                        StringBuffer sqlQuery = new StringBuffer("FROM Tracking WHERE contentID = :contentID AND code = :code");

                        Query query = session
                                .createQuery(sqlQuery.toString());
                        query.setParameter("contentID", contentID);
                        query.setParameter("code", code);
                        return (Tracking) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<Tracking> findTopViewContent(final Integer pageSize) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Tracking>>() {
                    public List<Tracking> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT DISTINCT tr FROM Tracking tr ORDER BY tr.views DESC) ");
                        query.setFirstResult(0);
                        query.setMaxResults(pageSize);
                        return (List<Tracking>) query.list();
                    }
                });
    }

    @Override
    public TrackingDTO findTotalTrackingByContentID(final Long contentID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<TrackingDTO>() {
                    public TrackingDTO doInHibernate(Session session)
                            throws HibernateException, SQLException {

                        StringBuffer sqlQuery = new StringBuffer("SELECT contentID as \"contentID\", SUM(likes) as \"likes\", SUM(views) as \"views\" FROM PortalTracking WHERE contentID = :contentID GROUP BY contentID");

                        SQLQuery query = session
                                .createSQLQuery(sqlQuery.toString());
                        query.setParameter("contentID", contentID);
                        query.addScalar("contentID", Hibernate.LONG);
                        query.addScalar("likes", Hibernate.LONG);
                        query.addScalar("views", Hibernate.LONG);

                        query.setResultTransformer(Transformers.aliasToBean(TrackingDTO.class));
                        return (TrackingDTO) query.uniqueResult();
                    }
                });
    }
}
