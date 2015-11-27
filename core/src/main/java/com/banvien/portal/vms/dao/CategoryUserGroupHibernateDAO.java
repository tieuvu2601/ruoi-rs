package com.banvien.portal.vms.dao;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.CategoryUserGroup;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:33 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryUserGroupHibernateDAO extends AbstractHibernateDAO<CategoryUserGroup, Long> implements CategoryUserGroupDAO {
	public CategoryUserGroup findByCategoryIDAndUserGroupID(final Long categoryID, final Long userGroupID ) {
		return getHibernateTemplate().execute(
            new HibernateCallback<CategoryUserGroup>() {
            	
                public CategoryUserGroup doInHibernate(Session session)
                        throws HibernateException, SQLException {
                    Query query = session.createQuery("FROM CategoryUserGroup ct WHERE ct.categoryID = :categoryID and ct.userGroupID = :userGroupID");
                    query.setParameter("categoryID", categoryID);
                    query.setParameter("userGroupID", userGroupID);
                    List<CategoryUserGroup> list = (List<CategoryUserGroup>)query.list();
                    return list.size() > 0 ? list.get(0) : null;
                }
                
            });
}
}
