package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.ConfigurationDAO;
import com.banvien.portal.vms.dao.UserRoleDAO;
import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.domain.UserRoleEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class ConfigurationHibernateDAO extends AbstractHibernateDAO<ConfigurationEntity, Long> implements ConfigurationDAO {

}
