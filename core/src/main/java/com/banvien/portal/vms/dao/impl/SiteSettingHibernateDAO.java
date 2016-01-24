package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.LocationDAO;
import com.banvien.portal.vms.dao.SiteSettingDAO;
import com.banvien.portal.vms.domain.LocationEntity;
import com.banvien.portal.vms.domain.SiteSettingEntity;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class SiteSettingHibernateDAO extends AbstractHibernateDAO<SiteSettingEntity, Long> implements SiteSettingDAO {

}
