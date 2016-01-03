package com.banvien.portal.vms.dao.impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.domain.ContentEntity;
import org.apache.commons.lang.StringUtils;
import org.hibernate.*;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.util.Constants;

public class ContentHibernateDAO extends AbstractHibernateDAO<ContentEntity, Long> implements ContentDAO {

    @Override
    public Object[] findByCategoryWithMaxItem(final String category, final Integer startRow, final  Integer pageSize, final Boolean isEng, final Integer orderBy, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlQuery = new StringBuffer(" FROM ContentEntity c WHERE lower(c.category.code) = :category AND c.category.eng = :isEng AND c.status = :status");
                        if(orderBy != null && orderBy >= 0){
                            if(orderBy > 0){
                                sqlQuery.append(" ORDER BY c.displayOrder DESC, ");
                            }else {
                                sqlQuery.append(" ORDER BY c.displayOrder ASC, ");
                            }
                            sqlQuery.append(" c.modifiedDate DESC ");
                        } else {
                            sqlQuery.append(" ORDER BY c.modifiedDate DESC ");
                        }
                        Query query = session.createQuery(sqlQuery.toString());

                        query.setParameter("category", category.toLowerCase());
                        query.setParameter("isEng", isEng);
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();

                        Query queryCount = session.createQuery("SELECT COUNT(*) FROM Content c WHERE lower(c.category.code) = :category  AND c.status = :status");
                        queryCount.setParameter("category", category.toLowerCase());
                        queryCount.setParameter("status", status);
                        Long count = (Long) queryCount.uniqueResult();

                        return new Object[]{count, contentEntities};
                    }
                });
    }

    @Override
    public List<ContentEntity> findByAuthoringTemplateAndDepartment(final String authoringTemplate, final String department, final Integer begin, final Integer pageSize) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Content c WHERE c.status = :statusPublished AND c.authoringTemplate.code = :authoringTemplate AND c.contentID IN (SELECT cd.content.contentID FROM ContentDepartment cd WHERE cd.department.code = :department) ORDER BY c.modifiedDate DESC");
                        query.setParameter("authoringTemplate", authoringTemplate);
                        query.setParameter("department", department);
                        query.setParameter("statusPublished", Constants.CONTENT_PUBLISH);
                        query.setFirstResult(begin);
                        query.setMaxResults(pageSize);
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<ContentEntity> findAnnouncementItemsOfOnlineUser(final String authoringCode, final Long loginUserId, final Integer begin, final Integer pageSize) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Content c WHERE c.status = :statusPublished AND c.authoringTemplate.code = :authoringTemplate AND EXISTS (SELECT cd.content.contentID FROM ContentDepartment cd WHERE cd.content.contentID = c.contentID AND (EXISTS (SELECT u.department.departmentID FROM User u WHERE u.userID = :onlineUserID AND u.department.departmentID = cd.department.departmentID) OR EXISTS (SELECT ud.department.departmentID FROM UserDepartmentACL ud WHERE ud.user.userID = :onlineUserID AND ud.department.departmentID = cd.department.departmentID))) ORDER BY c.modifiedDate DESC");
                        query.setParameter("authoringTemplate", authoringCode);
                        query.setParameter("onlineUserID", loginUserId);
                        query.setParameter("statusPublished", Constants.CONTENT_PUBLISH);
                        query.setFirstResult(begin);
                        query.setMaxResults(pageSize);
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<ContentEntity> findByListTitle(final List<String> title, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Content c WHERE lower(c.title) IN  (:title) AND c.status = :status ORDER BY c.displayOrder ");
                        query.setParameterList("title", title);
                        query.setParameter("status", status);
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<ContentEntity> findByPrefixUrl(final String prefixUrl,final  Integer startRow,final  Integer pageSize, final Boolean isEng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {

                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM Content c WHERE lower(c.category.prefixUrl) = :prefixUrl AND c.category.eng = :isEng AND c.status = :status ORDER BY c.modifiedDate DESC");
                        query.setParameter("prefixUrl", prefixUrl.toLowerCase());
                        query.setParameter("isEng", isEng);
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize > 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();

                    }
                });
    }

    @Override
    public Object[] findByCategoryTypeWithMaxItem(final String categoryType, final  Integer startRow,final  Integer pageSize, final Date toDate, final String categorySearch, final Boolean isEng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder whereSQL = new StringBuilder("FROM ContentEntity c WHERE c.beginDate IS NOT NUll AND c.category.code = :categorySearch AND c.category.eng = :isEng AND c.status = :status ");
                        StringBuilder countSQL = new StringBuilder("SELECT COUNT(*) FROM ContentEntity c WHERE c.beginDate IS NOT NUll AND c.category.code = :categorySearch AND c.category.eng = :isEng AND c.status = :status ");

                        StringBuilder sortSQL = new StringBuilder("");
                        if(StringUtils.isNotEmpty(categoryType) && categoryType.equals(Constants.UP_COMING_EVENT)){
                            whereSQL.append(" AND c.beginDate >= :toDate ");
                            countSQL.append(" AND c.beginDate >= :toDate ");
                            sortSQL = new StringBuilder(" ORDER BY c.beginDate ASC");
                        }else if(StringUtils.isNotEmpty(categoryType) && categoryType.equals(Constants.PAST_EVENT)){
                            whereSQL.append(" AND c.endDate < :toDate ");
                            countSQL.append(" AND c.endDate < :toDate ");
                            sortSQL = new StringBuilder(" ORDER BY c.beginDate DESC");
                        } else {
                            sortSQL = new StringBuilder(" ORDER BY c.beginDate DESC");
                        }

                        Query query = session.createQuery(whereSQL.append(sortSQL).toString());
                        query.setParameter("categorySearch", categorySearch);
                        query.setParameter("isEng", isEng);
                        query.setParameter("status", status);
                        if(StringUtils.isNotEmpty(categoryType) && (categoryType.equals(Constants.UP_COMING_EVENT) || categoryType.equals(Constants.PAST_EVENT))){
                            query.setParameter("toDate", toDate);
                        }
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();

                        Query queryCount = session.createQuery(countSQL.toString());
                        queryCount.setParameter("categorySearch", categorySearch);
                        queryCount.setParameter("isEng", isEng);
                        queryCount.setParameter("status", status);
                        if(StringUtils.isNotEmpty(categoryType) && (categoryType.equals(Constants.UP_COMING_EVENT) || categoryType.equals(Constants.PAST_EVENT))){
                            queryCount.setParameter("toDate", toDate);
                        }
                        Object count = queryCount.uniqueResult();

                        return new Object[]{count, contentEntities};
                    }
                });
    }





    @Override
    public List<ContentEntity> findByAuthoringPrefixUrl(final String prefixUrl,final  Integer startRow,final  Integer pageSize,final  Boolean isEng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {

                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM Content c WHERE lower(c.authoringTemplate.prefixUrl) = :prefixUrl  AND c.status = :status  AND c.category.eng = :isEng ORDER BY c.modifiedDate DESC");
                        query.setParameter("prefixUrl", prefixUrl.toLowerCase());
                        query.setParameter("isEng", isEng);
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize > 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();

                    }
                });
    }


    //    new content function

    @Override
    public ContentEntity findByTitle(final String title, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<ContentEntity>() {

                    public ContentEntity doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM ContentEntity ce WHERE lower(ce.title) = :title AND ce.status = :status ");
                        query.setParameter("title", title.toLowerCase());
                        query.setParameter("status", status);
                        return (ContentEntity) query.uniqueResult();

                    }
                });
    }

    @Override
    public List<ContentEntity> findByCategory(final String category, final Integer startRow, final Integer pageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery(" FROM ContentEntity ce WHERE lower(ce.category.code) = :category  AND ce.status = :status ORDER BY ce.hotItem DESC, ce.productStatus, ce.publishedDate DESC");
                        query.setParameter("category", category.toLowerCase());
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public Object[] findByCategoryTypeWithMaxItem(final String categoryType,final  Integer begin, final  Integer pageSize,final  Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlClause = new StringBuffer(" FROM ContentEntity c WHERE c.categoryType.categoryTypeId > 0  AND c.status = :status ");
                        if(StringUtils.isNotBlank(categoryType)){
                            sqlClause.append(" AND ( lower(c.categoryType.name) = :categoryType ");
                        }

                        StringBuffer orderClause = new StringBuffer(" ORDER BY c.categoryType.displayOrder, c.hotItem DESC, c.publishedDate DESC ");

                        StringBuffer groupBy = new StringBuffer(" GROUP BY c.categoryType.categoryTypeId ");

                        Query query = session.createQuery(sqlClause.toString() + orderClause.toString() + groupBy.toString());

                        query.setParameter("status", status);
                        if(StringUtils.isNotBlank(categoryType)){
                            query.setParameter("categoryType", categoryType.toLowerCase());
                        }

                        query.setFirstResult(begin);
                        if(pageSize != null && pageSize > 0){
                            query.setMaxResults(pageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();


                        StringBuffer countClause = new StringBuffer(" SELECT COUNT(*) ");
                        countClause = countClause.append(sqlClause);
                        Query queryCount = session.createQuery(countClause.toString() + groupBy.toString() );

                        queryCount.setParameter("status", status);
                        if(StringUtils.isNotBlank(categoryType)){
                            queryCount.setParameter("categoryType", categoryType.toLowerCase());
                        }

                        List<Long> count = (List<Long>) queryCount.list();

                        return new Object[]{contentEntities, count};
                    }
                });
    }

    @Override
    public Object[] findAllContentsByCategoryType(final Long categoryTypeId,final  Integer begin, final  Integer pageSize,final  Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlClause = new StringBuffer(" FROM ContentEntity c WHERE  c.status = :status ");
                        if(categoryTypeId != null && categoryTypeId > 0){
                            sqlClause.append(" AND  c.categoryType.categoryTypeId > 0 AND c.categoryType.categoryTypeId = :categoryTypeId");
                        }

                        StringBuffer orderClause = new StringBuffer(" ORDER BY c.categoryType.displayOrder, c.hotItem DESC, c.publishedDate DESC ");

                        StringBuffer groupBy = new StringBuffer(" GROUP BY c.categoryType.categoryTypeId ");

                        Query query = session.createQuery(sqlClause.toString() + orderClause.toString() + groupBy.toString());

                        query.setParameter("status", status);
                        if(categoryTypeId != null && categoryTypeId > 0){
                            query.setParameter("categoryTypeId", categoryTypeId);
                        }

                        query.setFirstResult(begin);
                        if(pageSize != null && pageSize > 0){
                            query.setMaxResults(pageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();

                        StringBuffer countClause = new StringBuffer(" SELECT COUNT(*) ");
                        countClause = countClause.append(sqlClause);
                        Query queryCount = session.createQuery(countClause.toString() + groupBy.toString() );

                        queryCount.setParameter("status", status);
                        if(categoryTypeId != null && categoryTypeId > 0){
                            queryCount.setParameter("categoryTypeId", categoryTypeId);
                        }

                        Long count = (Long) queryCount.uniqueResult();

                        return new Object[]{contentEntities, count};
                    }
                });
    }

    @Override
    public List<ContentEntity> getHotProduct(final Integer startRow, final Integer pageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery(" FROM ContentEntity ce WHERE  ce.status = :status AND ce.authoringTemplate.areProduct = 1 ORDER BY ce.hotItem DESC, ce.publishedDate DESC, ce.productStatus DESC");
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<ContentEntity> findContentForBuildSlider(final Integer pageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery(" FROM ContentEntity ce WHERE  ce.status = :status AND ce.slide = 1 ORDER BY ce.displayOrder, ce.hotItem DESC, ce.publishedDate DESC, ce.productStatus DESC ");
                        query.setParameter("status", status);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<ContentEntity> findContentByProperties(final String title, final String keyword, final  Integer status, final Long authoringTemplateId, final Long categoryId, final List<Long> listContent) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {

                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder sql = new StringBuilder("FROM ContentEntity ce WHERE 1 = 1 ");

                        if(StringUtils.isNotBlank(title)){
                            sql.append(" AND lower(ce.title) like '%").append(title.toLowerCase().trim()).append("%' ");
                        }

                        if(StringUtils.isNotBlank(keyword)){
                            sql.append(" AND lower(ce.keyword) like '%").append(keyword.toLowerCase().trim()).append("%' ");
                        }

                        if(status != null && status >= -1){
                            sql.append(" AND  ce.status = :status ");
                        }

                        if(authoringTemplateId != null && authoringTemplateId > 0){
                            sql.append(" AND  ce.authoringTemplate.authoringTemplateId = :authoringTemplateId ");
                        }

                        if(categoryId != null && categoryId > 0){
                            sql.append(" AND  ce.category.categoryId = :categoryId ");
                        }

                        if(listContent != null && listContent.size() > 0){
                            sql.append(" AND  ce.contentId NOT IN (:listContent) ");
                        }

                        sql.append(" ORDER BY ce.displayOrder, ce.hotItem DESC, ce.publishedDate DESC, ce.productStatus DESC ");

                        Query query = session.createQuery(sql.toString());

                        if(status != null && status >= 0){
                            query.setParameter("status", status);
                        }

                        if(authoringTemplateId != null && authoringTemplateId > 0){
                            query.setParameter("authoringTemplateId", authoringTemplateId);
                        }

                        if(categoryId != null && categoryId > 0){
                            query.setParameter("categoryId", categoryId);
                        }

                        if(listContent != null && listContent.size() > 0){
                            query.setParameterList("listContent", listContent);
                        }

                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public void removeSlideContent(final List<Long> listContent) {
        getHibernateTemplate().execute(
                new HibernateCallback<Object>() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("UPDATE ContentEntity ce SET ce.slide = 0 WHERE ce.slide = 1 AND  ce.contentId NOT IN (:listContent) ");
                        query.setParameterList("listContent", listContent);
                        return query.executeUpdate();
                    }
                });

    }

    @Override
    public List<ContentEntity> findByListContentId(final List<Long> listContent) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery(" FROM ContentEntity ce WHERE ce.contentId IN (:listContent)");
                        query.setParameterList("listContent", listContent);
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public Object[] findByCategoryWithPage(final String category, final Integer startRow, final Integer maxPageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlClause = new StringBuffer(" FROM ContentEntity c WHERE  c.status = :status ");
                        if(StringUtils.isNotBlank(category)){
                            sqlClause.append(" AND  lower(c.category.code) = :category ");
                        }

                        StringBuffer orderClause = new StringBuffer(" ORDER BY c.hotItem DESC, c.publishedDate DESC ");

                        Query query = session.createQuery(sqlClause.toString() + orderClause.toString());

                        query.setParameter("status", status);
                        if(StringUtils.isNotBlank(category)){
                            query.setParameter("category", category.toLowerCase());
                        }

                        query.setFirstResult(startRow);
                        if(maxPageSize != null && maxPageSize > 0){
                            query.setMaxResults(maxPageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();


                        StringBuffer countClause = new StringBuffer(" SELECT COUNT(*) ");

                        countClause = countClause.append(sqlClause);

                        Query queryCount = session.createQuery(countClause.toString());

                        queryCount.setParameter("status", status);

                        if(StringUtils.isNotBlank(category)){
                            queryCount.setParameter("category", category.toLowerCase());
                        }

                        Long count = (Long) queryCount.uniqueResult();

                        return new Object[]{contentEntities, count};
                    }
                });
    }

    @Override
    public Object[] searchInSite(final String keyword, final  Timestamp fromDate, final  Timestamp toDate, final  Integer startRow, final Integer maxPageItems, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlClause = new StringBuffer("FROM ContentEntity c WHERE 1 = 1 AND c.status = :status ");
                        if(StringUtils.isNotBlank(keyword)){
                            sqlClause.append(" AND ( lower(c.keyword) LIKE '%").append(keyword).append("%' OR lower(c.header) LIKE '%").append(keyword).append("%' OR lower(c.title) LIKE '%").append(keyword).append("%' )");
                        }

                        if(fromDate != null){
                            sqlClause.append(" AND c.publishedDate >= :fromDate ");
                        }

                        if(toDate != null){
                            sqlClause.append(" AND c.publishedDate <= :toDate ");
                        }

                        StringBuffer orderClause = new StringBuffer(" ORDER BY c.category, c.category.displayOrder, c.modifiedDate DESC ");

                        Query query = session.createQuery(sqlClause.toString() + orderClause.toString());
                        query.setParameter("status", status);
                        if(fromDate != null){
                            query.setParameter("fromDate", fromDate);
                        }

                        if(toDate != null){
                            query.setParameter("toDate", toDate);
                        }
                        query.setFirstResult(startRow);
                        if(maxPageItems != null && maxPageItems > 0){
                            query.setMaxResults(maxPageItems);
                        }
                        List<ContentEntity> contentEntities = query.list();


                        StringBuffer countClause = new StringBuffer(" SELECT COUNT(*) ");
                        countClause = countClause.append(sqlClause);
                        Query queryCount = session.createQuery(countClause.toString());

                        queryCount.setParameter("status", status);

                        if(fromDate != null){
                            queryCount.setParameter("fromDate", fromDate);
                        }

                        if(toDate != null){
                            queryCount.setParameter("toDate", toDate);
                        }
                        Long count = (Long) queryCount.uniqueResult();

                        return new Object[]{count, contentEntities};
                    }
                });
    }
}
