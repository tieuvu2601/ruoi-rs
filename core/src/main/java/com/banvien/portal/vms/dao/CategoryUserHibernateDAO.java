package com.banvien.portal.vms.dao;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.banvien.portal.vms.domain.CategoryUser;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:33 PM
 * Author: vien.nguyen@banvien.com
 */
public class CategoryUserHibernateDAO extends AbstractHibernateDAO<CategoryUser, Long> implements CategoryUserDAO {
	public CategoryUser findByCategoryIDAndUserID(final Long categoryID, final Long userID ) {
		return getHibernateTemplate().execute(
                new HibernateCallback<CategoryUser>() {
                	
                    public CategoryUser doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session.createQuery("FROM CategoryUser cu WHERE cu.categoryID = :categoryID and cu.userID = :userID");
                        query.setParameter("categoryID", categoryID);
                        query.setParameter("userID", userID);
                        List<CategoryUser> list = (List<CategoryUser>)query.list();
                        return list.size() > 0 ? list.get(0) : null;
                    }
                    
                });
	}
}

