package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.CustomerDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.RoleEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class CustomerHibernateDAO extends AbstractHibernateDAO<CustomerEntity, Long> implements CustomerDAO {

}
