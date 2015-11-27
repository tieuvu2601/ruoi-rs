package com.banvien.portal.vms.dao.impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.dto.TopViewContentDTO;
import org.apache.commons.lang.StringUtils;
import org.hibernate.*;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.dto.ReportDTO;
import com.banvien.portal.vms.util.Constants;

public class ContentHibernateDAO extends AbstractHibernateDAO<ContentEntity, Long> implements ContentDAO {
    @Override
    public List<ContentEntity> findByCategory(final String category, final Integer startRow, final Integer pageSize, final Boolean isEng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("SELECT c FROM Content c WHERE lower(c.category.code) = :category AND c.category.eng = :isEng AND c.status = :status ORDER BY c.modifiedDate DESC");
                        query.setParameter("category", category.toLowerCase());
                        query.setParameter("status", status);
                        query.setParameter("isEng", isEng);
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

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
    public List<ContentEntity> findByCategoryId(final Long categoryID, final Integer startRow, final Integer pageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("SELECT c FROM Content c WHERE  c.category.categoryID = :categoryID AND c.status = :status ORDER BY c.modifiedDate DESC");
                        query.setParameter("categoryID", categoryID);
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
    public List<ContentEntity> findRelatedItems(final String authoringTemplate, final String category, final Long departmentID, final Timestamp modifiedDate, final Integer startRow, final Integer pageSize) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder();
                        sqlQuery.append("SELECT c FROM ContentEntity c WHERE c.status = :statusPublished AND c.authoringTemplate.code = :authoringTemplate AND c.modifiedDate < :modifiedDate");
                        if (StringUtils.isNotBlank(category)) {
                            sqlQuery.append(" AND c.contentID IN (SELECT ca.content.contentID FROM ContentCategory ca WHERE ca.category.code = :category)");
                        }
                        if (departmentID != null && departmentID > 0) {
                            sqlQuery.append(" AND c.contentID IN (SELECT cd.content.contentID FROM ContentDepartment cd WHERE cd.department.departmentID = :departmentID)");
                        }
                        sqlQuery.append(" ORDER BY c.modifiedDate DESC");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("statusPublished", Constants.CONTENT_PUBLISH);
                        query.setParameter("authoringTemplate", authoringTemplate);
                        query.setParameter("modifiedDate", modifiedDate);
                        if (StringUtils.isNotBlank(category)) {
                            query.setParameter("category", category);
                        }
                        if (departmentID != null && departmentID > 0) {
                            query.setParameter("departmentID", departmentID);
                        }
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        return (List<ContentEntity>) query.list();
                    }
                });
    }

    @Override
    public List<TopViewContentDTO> findTopViewByAuthoringCode(final String authoringCode,final String category, final Integer pageSize,final Integer noOfDateTracking){
        return getHibernateTemplate().execute(
                new HibernateCallback<List<TopViewContentDTO>>() {
                    public List<TopViewContentDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {

                        StringBuilder sqlQuery = new StringBuilder();
                        Calendar cal = Calendar.getInstance();
                        Date toDate = cal.getTime();

                        cal.add(Calendar.DATE, noOfDateTracking * (-1));

                        Date fromDate = cal.getTime();
                        sqlQuery.append("SELECT c.contentID, c.title ");
                        sqlQuery.append(" FROM (SELECT tr.contentID, SUM(tr.views) \"TOTALVIEWS\" FROM PortalTracking tr ");
//                        sqlQuery.append(" WHERE tr.trackingDate BETWEEN :fromDate AND :toDate GROUP BY tr.contentID ORDER BY SUM(tr.views) DESC ) totalViews, ");
                        sqlQuery.append(" GROUP BY tr.contentID ORDER BY TO_NUMBER(TOTALVIEWS) DESC ) totalViews, ");
                        sqlQuery.append("  PortalContent c, PortalAuthoringTemplate au WHERE c.authoringTemplateID = au.authoringTemplateID AND au.code = :authoringCode AND c.status = :contentStatusPublish");
                        sqlQuery.append(" AND c.contentID = totalViews.contentID(+)  ");

                        if (StringUtils.isNotBlank(category)) {
                            sqlQuery.append(" AND c.contentID IN (SELECT contentID FROM PortalContentCategory ca JOIN PortalCategory cat ON ca.categoryID = cat.categoryID WHERE cat.code = :category)");
                        }

                        Query query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameter("contentStatusPublish", Constants.CONTENT_PUBLISH);
                        query.setParameter("authoringCode", authoringCode);
//                        query.setParameter("fromDate", fromDate);
//                        query.setParameter("toDate", toDate);

                        if (StringUtils.isNotBlank(category)) {
                            query.setParameter("category", category);
                        }
                        query.setFirstResult(0);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        List<Object> tmpResults =  query.list();
                        List<TopViewContentDTO> resutls = new ArrayList<TopViewContentDTO>();
                        for(Object topView : tmpResults) {
                            Object[] objs = (Object[])topView;
                            TopViewContentDTO topViewContentDTO = new TopViewContentDTO();
                            topViewContentDTO.setContentID(objs[0].toString());
                            topViewContentDTO.setTitle(objs[1].toString());

                            resutls.add(topViewContentDTO);
                        }

                        return resutls;
                    }
                });
    }

    @Override
    public List<TopCommentsContentDTO> findTopCommentByAuthoringCode(final String authoringCode,final String category, final Integer pageSize,final Integer noOfDateTracking){
        return getHibernateTemplate().execute(
                new HibernateCallback<List<TopCommentsContentDTO>>() {
                    public List<TopCommentsContentDTO> doInHibernate(Session session)
                            throws HibernateException, SQLException {

                        StringBuilder sqlQuery = new StringBuilder();
                        Calendar cal = Calendar.getInstance();
                        Date toDate = cal.getTime();
                        cal.add(Calendar.DATE, noOfDateTracking * (-1));

                        Date fromDate = cal.getTime();

                        sqlQuery.append("SELECT c.contentID, c.title, COUNT(cm.commentID) FROM ContentEntity c, Comment cm WHERE c.authoringTemplate.code = :authoringCode ");
                        sqlQuery.append(" AND c.status = :contentStatusPublish");
                        sqlQuery.append(" AND c.contentID = cm.content.contentID  ");
//                        sqlQuery.append(" AND c.publishedDate BETWEEN :fromDate AND :toDate  ");

                        if (StringUtils.isNotBlank(category)) {
                            sqlQuery.append(" AND c.contentID IN (SELECT contentID FROM ContentCategory ca JOIN CategoryEntity cat ON ca.categoryID = cat.categoryID WHERE cat.code = :category)");
                        }
                        sqlQuery.append(" GROUP BY c.contentID, c.title ");
                        sqlQuery.append(" ORDER BY COUNT(cm.commentID) DESC");
                        Query query = session.createQuery(sqlQuery.toString());
                        query.setParameter("contentStatusPublish", Constants.CONTENT_PUBLISH);
                        query.setParameter("authoringCode", authoringCode);
//                        query.setParameter("fromDate", fromDate);
//                        query.setParameter("toDate", toDate);

                        if (StringUtils.isNotBlank(category)) {
                            query.setParameter("category", category);
                        }
                        query.setFirstResult(0);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        List<Object> tmpResults =  (List<Object>) query.list();
                        List<TopCommentsContentDTO> results = new ArrayList<TopCommentsContentDTO>();
                        for(Object object : tmpResults){
                            Object[] objs = (Object[])object;
                            TopCommentsContentDTO dto = new TopCommentsContentDTO();
                            dto.setContentID(objs[0].toString());
                            dto.setTitle(objs[1].toString());
                            dto.setNoOfComments(objs[2].toString());

                            results.add(dto);
                        }
                        return results;
                    }
                });
    }

    public Object[] reportByPublishedDate(final Timestamp fromDate, final Timestamp toDate, final Integer startIndex, final Integer pageSize, final String sortProperty, final String sortDirection) {
    	return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                	
                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder("SELECT c.contentID as \"contentID\", c.title as \"title\", c.thumbnail as \"thumbnail\", c.createdDate as \"createdDate\", c.publishedDate as \"publishedDate\", u.displayName as \"author\"");
                        sqlQuery.append(" ,(select sum(t.views) from PortalTracking t where t.contentID = c.contentID group by t.contentID) as \"views\"");
                        sqlQuery.append(" ,(select sum(t.likes) from PortalTracking t where t.contentID = c.contentID group by t.contentID) as \"likes\"");
                        sqlQuery.append(" ,(select count(cm.contentID) from PortalComment cm where c.contentID = cm.contentID) as \"comments\"");
                        sqlQuery.append(" FROM PortalContent c, PortalUser u");
                        
                        StringBuilder sqlWhere = new StringBuilder(" WHERE u.UserID = c.CreatedBy AND c.status = :status");
                        if(fromDate != null){
                        	sqlWhere.append(" AND to_date(c.publishedDate) >= :fromDate");
                        }
                        if(toDate != null){
                        	sqlWhere.append(" AND to_date(c.publishedDate) <= :toDate");
                        }
                        StringBuilder sqlSort = new StringBuilder(" ORDER BY");
                        if(StringUtils.isNotEmpty(sortProperty)){
                        	if(sortProperty.equals("views") || sortProperty.equals("likes") || sortProperty.equals("comments")){
                        		sqlSort.append(" ").append("\"").append(sortProperty).append("\"");
                        	}else{
                        		sqlSort.append(" c.").append(sortProperty);
                        	}
                        }else{
                        	sqlSort.append(" c.publishedDate");
                        }
                        if(StringUtils.isNotEmpty(sortDirection)){
                        	if(sortDirection.equals(Constants.SORT_DESC)){
                        		sqlSort.append(" DESC NULLS LAST");
                        	}else{
                        		sqlSort.append(" ASC NULLS FIRST");
                        	}
                        }else{
                        	sqlSort.append(" DESC NULLS LAST");
                        }
                        sqlQuery.append(sqlWhere).append(sqlSort);
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameter("status", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	query.setParameter("toDate", toDate);
                        }
                        query.setFirstResult(startIndex);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        query.addScalar("contentID", Hibernate.LONG);
                        query.addScalar("likes", Hibernate.LONG);
                        query.addScalar("views", Hibernate.LONG);
                        query.addScalar("comments", Hibernate.LONG);
                        query.addScalar("title", Hibernate.STRING);
                        query.addScalar("thumbnail", Hibernate.STRING);
                        query.addScalar("createdDate", Hibernate.TIMESTAMP);
                        query.addScalar("publishedDate", Hibernate.TIMESTAMP);
                        query.addScalar("author", Hibernate.STRING);

                        query.setResultTransformer(Transformers.aliasToBean(ReportDTO.class));
                        List<ReportDTO> listDTOs = query.list();

                        StringBuilder sqlCountQuery = new StringBuilder("SELECT COUNT(*) FROM PortalContent c, PortalUser u");
                        Query queryCount = session.createSQLQuery(sqlCountQuery.append(sqlWhere).toString());
                        queryCount.setParameter("status", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	queryCount.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	queryCount.setParameter("toDate", toDate);
                        }
                        Object count = queryCount.uniqueResult();
                        return new Object[]{count, listDTOs};
                    }
                });
    }

	@Override
	public Object[] reportByDepartment(final Timestamp fromDate, final Timestamp toDate, 
			final Long departmentID, final Integer status, final Integer startIndex, final Integer pageSize,
			final String sortProperty, final String sortDirection) {
		return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                	
                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                    	StringBuilder sqlQuery = new StringBuilder("select c.contentID as \"contentID\", c.title as \"title\", c.thumbnail as \"thumbnail\", c.createdDate as \"createdDate\", c.publishedDate as \"publishedDate\", u.displayName as \"author\"");
                        sqlQuery.append(" ,(select sum(t.views) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"views\"");
                        sqlQuery.append(" ,(select sum(t.likes) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"likes\"");
                        sqlQuery.append(" ,(select count(cm.contentID) from portalcomment cm where c.contentID = cm.contentID) as \"comments\"");
                        sqlQuery.append(" from PortalContent c left join PortalUser u on(c.createdBy = u.userID) left join PortalDepartment d on(u.departmentID = d.departmentID)");
                        StringBuilder sqlWhere = new StringBuilder(" WHERE 1=1");
                        
                        if(status != null){
                    		sqlWhere.append(" AND c.status = :status");
                        }
                        if(departmentID != null){
                        	sqlWhere.append(" AND d.departmentID = :departmentID");
                        }
                        if(fromDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) >= :fromDate");
                        }
                        if(toDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) <= :toDate");
                        }
                        StringBuilder sqlSort = new StringBuilder(" ORDER BY");
                        if(StringUtils.isNotEmpty(sortProperty)){
                    		sqlSort.append(" ").append("\"").append(sortProperty).append("\"");
                        }else{
                        	sqlSort.append(" c.createdDate");
                        }
                        if(StringUtils.isNotEmpty(sortDirection)){
                        	if(sortDirection.equals(Constants.SORT_DESC)){
                        		sqlSort.append(" DESC NULLS LAST");
                        	}else{
                        		sqlSort.append(" ASC NULLS FIRST");
                        	}
                        }else{
                        	sqlSort.append(" DESC NULLS LAST");
                        }
                        sqlQuery.append(sqlWhere).append(sqlSort);
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        if(status != null){
                        	query.setParameter("status", status);
                        }
                        if(departmentID != null){
                        	query.setParameter("departmentID", departmentID);
                        }
                        if(fromDate != null){
                        	query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	query.setParameter("toDate", toDate);
                        }
                        query.setFirstResult(startIndex);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        query.addScalar("contentID", Hibernate.LONG);
                        query.addScalar("likes", Hibernate.LONG);
                        query.addScalar("views", Hibernate.LONG);
                        query.addScalar("comments", Hibernate.LONG);
                        query.addScalar("title", Hibernate.STRING);
                        query.addScalar("thumbnail", Hibernate.STRING);
                        query.addScalar("createdDate", Hibernate.TIMESTAMP);
                        query.addScalar("publishedDate", Hibernate.TIMESTAMP);
                        query.addScalar("author", Hibernate.STRING);
                        query.setResultTransformer(Transformers.aliasToBean(ReportDTO.class));
                        List<ReportDTO> listDTOs = query.list();

                        
                        StringBuilder sqlCountQuery = new StringBuilder("SELECT COUNT(*) FROM (");
                        Query queryCount = session.createSQLQuery(sqlCountQuery.append(sqlQuery).append(")").toString());
                        if(status != null){
                        	queryCount.setParameter("status", status);
                        }
                        if(departmentID != null){
                        	queryCount.setParameter("departmentID", departmentID);
                        }
                        if(fromDate != null){
                        	queryCount.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	queryCount.setParameter("toDate", toDate);
                        }
                        Object count = queryCount.uniqueResult();
                        return new Object[]{count, listDTOs};
                    }
                });
	}

	@Override
	public Object[] reportByAccessViewOrUserLike(final Timestamp fromDate, final Timestamp toDate,
			final Integer top, final Integer startIndex, final Integer pageSize,
			final String sortProperty, final String sortDirection, final Boolean isAccessViewReport) {
		
		return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                	
                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder("select c.contentID as \"contentID\", c.title as \"title\", c.thumbnail as \"thumbnail\", c.createdDate as \"createdDate\", c.publishedDate as \"publishedDate\", u.displayName as \"author\"");
                        sqlQuery.append(" ,(select sum(t.views) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"views\"");
                        sqlQuery.append(" ,(select sum(t.likes) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"likes\"");
                        sqlQuery.append(" ,(select count(cm.contentID) from PortalComment cm where c.contentID = cm.contentID) as \"comments\"");
                        sqlQuery.append(" from PortalContent c, PortalUser u");
                        
                        StringBuilder sqlWhere = new StringBuilder(" WHERE c.CreatedBy = u.UserID AND c.status = :published");
                        if(fromDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) >= :fromDate");
                        }
                        if(toDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) <= :toDate");
                        }
                        StringBuilder sqlSort = new StringBuilder();
                        if(isAccessViewReport){
                        	sqlSort.append(" ORDER BY \"views\" DESC NULLS LAST");
                        }else{
                        	sqlSort.append(" ORDER BY \"likes\" DESC NULLS LAST");
                        }
                        sqlQuery.append(sqlWhere).append(sqlSort);
                        sqlQuery = new StringBuilder("select * from(").append(sqlQuery).append(")");
                        if(top != null && top > 0){
                        	sqlQuery.append("  where rownum <=:top");
                        }
                        if(StringUtils.isNotEmpty(sortProperty)){
                    		sqlQuery.append(" ORDER BY ").append("\"").append(sortProperty).append("\"");
                    	}else{
                    		if(isAccessViewReport){
                    			sqlQuery.append(" ORDER BY \"views\"");
                    		}else{
                    			sqlQuery.append(" ORDER BY \"likes\"");
                    		}
                    	}
                    	if(!StringUtils.isNotEmpty(sortDirection) || sortDirection.equals(Constants.SORT_DESC)){
                    		sqlQuery.append(" DESC NULLS LAST");
                    	}else{
                    		sqlQuery.append(" ASC NULLS FIRST");
                    	}
                        
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameter("published", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	query.setParameter("toDate", toDate);
                        }
                        if(top != null && top > 0){
                        	query.setParameter("top", top);
                        }
                        query.setFirstResult(startIndex);
                        query.setMaxResults(pageSize);
                        query.addScalar("contentID", Hibernate.LONG);
                        query.addScalar("likes", Hibernate.LONG);
                        query.addScalar("views", Hibernate.LONG);
                        query.addScalar("comments", Hibernate.LONG);
                        query.addScalar("title", Hibernate.STRING);
                        query.addScalar("thumbnail", Hibernate.STRING);
                        query.addScalar("createdDate", Hibernate.TIMESTAMP);
                        query.addScalar("publishedDate", Hibernate.TIMESTAMP);
                        query.addScalar("author", Hibernate.STRING);
                        query.setResultTransformer(Transformers.aliasToBean(ReportDTO.class));
                        List<ReportDTO> listDTOs = query.list();

                        StringBuilder sqlCountQuery = new StringBuilder("SELECT COUNT(*) FROM(");
                        sqlCountQuery.append(sqlQuery).append(")");
                        Query queryCount = session.createSQLQuery(sqlCountQuery.toString());
                        queryCount.setParameter("published", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	queryCount.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	queryCount.setParameter("toDate", toDate);
                        }
                        if(top != null && top > 0){
                        	queryCount.setParameter("top", top);
                        }
                        Object count = queryCount.uniqueResult();
                        return new Object[]{count, listDTOs};
                    }
                });
	}
	
	@Override
	public Object[] reportByComment(final Timestamp fromDate, final Timestamp toDate,
			final Integer top, final Integer startIndex, final Integer pageSize,
			final String sortProperty, final String sortDirection) {
		
		return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {
                	
                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder sqlQuery = new StringBuilder("select c.contentID as \"contentID\", c.title as \"title\", c.thumbnail as \"thumbnail\", c.createdDate as \"createdDate\", c.publishedDate as \"publishedDate\", u.displayName as \"author\"");
                        sqlQuery.append(" ,(select sum(t.views) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"views\"");
                        sqlQuery.append(" ,(select sum(t.likes) from portaltracking t where t.contentID = c.contentID group by t.contentID) as \"likes\"");
                        sqlQuery.append(" ,(select count(cm.contentID) from portalcomment cm where c.contentID = cm.contentID) as \"comments\"");
                        sqlQuery.append(" from PortalContent c, PortalUser u");
                        
                        StringBuilder sqlWhere = new StringBuilder(" WHERE c.CreatedBy = u.UserID AND c.status = :published");
                        if(fromDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) >= :fromDate");
                        }
                        if(toDate != null){
                        	sqlWhere.append(" AND to_date(c.createdDate) <= :toDate");
                        }
                        StringBuilder sqlSort = new StringBuilder();
                        
                    	sqlSort.append(" ORDER BY \"comments\" DESC NULLS LAST");
                    	
                        sqlQuery.append(sqlWhere).append(sqlSort);
                        sqlQuery = new StringBuilder("select * from(").append(sqlQuery).append(")");
                        if(top != null && top > 0){
                        	sqlQuery.append("  where rownum <=:top");
                        }
                        if(StringUtils.isNotEmpty(sortProperty)){
                    		sqlQuery.append(" ORDER BY ").append("\"").append(sortProperty).append("\"");
                    	}else{
                			sqlQuery.append(" ORDER BY \"comments\"");
                    	}
                    	if(!StringUtils.isNotEmpty(sortDirection) || sortDirection.equals(Constants.SORT_DESC)){
                    		sqlQuery.append(" DESC");
                    	}else{
                    		sqlQuery.append(" ASC");
                    	}
                    	sqlQuery.append(" NULLS LAST");
                        
                        SQLQuery query = session.createSQLQuery(sqlQuery.toString());
                        query.setParameter("published", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	query.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	query.setParameter("toDate", toDate);
                        }
                        if(top != null && top > 0){
                        	query.setParameter("top", top);
                        }
                        query.setFirstResult(startIndex);
                        query.setMaxResults(pageSize);
                        query.addScalar("contentID", Hibernate.LONG);
                        query.addScalar("likes", Hibernate.LONG);
                        query.addScalar("views", Hibernate.LONG);
                        query.addScalar("comments", Hibernate.LONG);
                        query.addScalar("title", Hibernate.STRING);
                        query.addScalar("thumbnail", Hibernate.STRING);
                        query.addScalar("createdDate", Hibernate.TIMESTAMP);
                        query.addScalar("publishedDate", Hibernate.TIMESTAMP);
                        query.addScalar("author", Hibernate.STRING);
                        query.setResultTransformer(Transformers.aliasToBean(ReportDTO.class));
                        List<ReportDTO> listDTOs = query.list();

                        
                        StringBuilder sqlCountQuery = new StringBuilder("SELECT COUNT(*) FROM(");
                        sqlCountQuery.append(sqlQuery).append(")");
                        Query queryCount = session.createSQLQuery(sqlCountQuery.toString());
                        queryCount.setParameter("published", Constants.CONTENT_PUBLISH);
                        if(fromDate != null){
                        	queryCount.setParameter("fromDate", fromDate);
                        }
                        if(toDate != null){
                        	queryCount.setParameter("toDate", toDate);
                        }
                        if(top != null && top > 0){
                        	queryCount.setParameter("top", top);
                        }
                        Object count = queryCount.uniqueResult();
                        return new Object[]{count, listDTOs};
                    }
                });
	}

	@Override
	public List<ContentEntity> findByListID(final List<Long> contentIDs) {
		return getHibernateTemplate().execute(
                new HibernateCallback<List<ContentEntity>>() {
                    public List<ContentEntity> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM Content c WHERE c.contentID in(:listIDs)");
                        query.setParameterList("listIDs", contentIDs);
                        return (List<ContentEntity>) query.list();
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
    public Object[] findByParentCategoryWithMaxItem(final String category,final Integer startRow, final Integer pageSize, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM Content c WHERE lower(c.category.parentCategory.code) = :category  AND c.status = :status  ORDER BY c.category.displayOrder, c.modifiedDate DESC");
                        query.setParameter("category", category.toLowerCase());
                        query.setParameter("status", status);
                        query.setFirstResult(startRow);
                        if(pageSize != null && pageSize >= 0){
                            query.setMaxResults(pageSize);
                        }
                        List<ContentEntity> contentEntities = query.list();

                        Query queryCount = session.createQuery("SELECT COUNT(*) FROM Content c WHERE lower(c.category.parentCategory.code) = :category AND c.status = :status ");
                        queryCount.setParameter("category", category.toLowerCase());
                        Long count = (Long) queryCount.uniqueResult();

                        return new Object[]{count, contentEntities};
                    }
                });
    }

    @Override
    public ContentEntity findByTitle(final String title, final Boolean eng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<ContentEntity>() {

                    public ContentEntity doInHibernate(Session session) throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM Content c WHERE lower(c.title) = :title AND c.category.eng = :eng AND c.status = :status  ORDER BY c.modifiedDate DESC");
                        query.setParameter("title", title.toLowerCase());
                        query.setParameter("eng", eng);
                        query.setParameter("status", status);
                        return (ContentEntity) query.uniqueResult();

                    }
                });
    }

    @Override
    public Object[] searchInSite(final String keyword, final  Timestamp fromDate, final  Timestamp toDate, final  Integer startRow, final Integer maxPageItems, final Boolean isEng, final Integer status) {
        return getHibernateTemplate().execute(
                new HibernateCallback<Object[]>() {

                    public Object[] doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuffer sqlClause = new StringBuffer("FROM ContentEntity c WHERE 1 = 1 AND c.category.eng = :isEng  AND c.status = :status ");
                        if(StringUtils.isNotBlank(keyword)){
                            sqlClause.append(" AND ( lower(c.keyword) LIKE '%").append(keyword).append("%' OR lower(c.title) LIKE '%").append(keyword).append("%' )");
                        }
                        if(fromDate != null){
                            sqlClause.append(" AND c.publishedDate >= :fromDate ");
                        }

                        if(toDate != null){
                            sqlClause.append(" AND c.publishedDate <= :toDate ");
                        }

                        StringBuffer orderClause = new StringBuffer(" ORDER BY c.category, c.category.displayOrder, c.modifiedDate DESC ");

                        Query query = session.createQuery(sqlClause.toString() + orderClause.toString());
                        query.setParameter("isEng", isEng);
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

                        queryCount.setParameter("isEng", isEng);
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
}
