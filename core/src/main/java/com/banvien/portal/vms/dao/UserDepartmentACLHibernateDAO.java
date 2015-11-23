package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.UserDepartmentACL;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * UserDepartmentACL: MBP
 * Date: 11/13/12
 * Time: 4:35 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserDepartmentACLHibernateDAO extends AbstractHibernateDAO<UserDepartmentACL, Long> implements UserDepartmentACLDAO {
    @Override
    public UserDepartmentACL getItemByDepartmentAndUser(final Long departmentID, final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<UserDepartmentACL>() {
                    public UserDepartmentACL doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserDepartmentACL u WHERE u.department.departmentID = :departmentID and u.user.userID = :userID");
                        query.setParameter("departmentID", departmentID);
                        query.setParameter("userID", userID);
                        return (UserDepartmentACL) query.uniqueResult();
                    }
                });
    }

    @Override
    public List<UserDepartmentACL> findByDepartmentsOfUser(final Long userID, final Long[] departmentIDsInPage) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserDepartmentACL>>() {
                    public List<UserDepartmentACL> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserDepartmentACL u WHERE u.department.departmentID IN (:departmentIDs) and u.user.userID = :userID");
                        query.setParameterList("departmentIDs", departmentIDsInPage);
                        query.setParameter("userID", userID);
                        return (List<UserDepartmentACL>) query.list();
                    }
                });
    }


    @Override
    public List<UserDepartmentACL> findUserDepartmentByUserID(final Long userID) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<UserDepartmentACL>>() {
                    public List<UserDepartmentACL> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM UserDepartmentACL u WHERE u.user.userID = :userID");
                        query.setParameter("userID", userID);
                        return (List<UserDepartmentACL>) query.list();
                    }
                });
    }


}
