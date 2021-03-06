package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.CustomerDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.util.Constants;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

public class CustomerHibernateDAO extends AbstractHibernateDAO<CustomerEntity, Long> implements CustomerDAO {

    @Override
    public List<CustomerEntity> loadCustomerByProperties(final String email, final String fullName, final String phoneNumber, final  String address, final  Long locationId, final  List<Long> customersSelected) {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<CustomerEntity>>() {

                    public List<CustomerEntity> doInHibernate(Session session) throws HibernateException, SQLException {
                        StringBuilder sql = new StringBuilder("FROM CustomerEntity ce WHERE 1 = 1 ");

                        if(StringUtils.isNotBlank(email)){
                            sql.append(" AND lower(ce.email) like '%").append(email.toLowerCase().trim()).append("%' ");
                        }

                        if(StringUtils.isNotBlank(fullName)){
                            sql.append(" AND lower(ce.fullName) like '%").append(fullName.toLowerCase().trim()).append("%' ");
                        }

                        if(StringUtils.isNotBlank(phoneNumber)){
                            sql.append(" AND lower(ce.phoneNumber) like '%").append(phoneNumber.toLowerCase().trim()).append("%' ");
                        }

                        if(StringUtils.isNotBlank(address)){
                            sql.append(" AND lower(ce.address) like '%").append(address.toLowerCase().trim()).append("%' ");
                        }

                        if(locationId != null && locationId > 0){
                            sql.append(" AND ce.location.locationId = :locationId ");
                        }

                        if(customersSelected != null && customersSelected.size() > 0){
                            sql.append(" AND ce.customerId NOT IN (:customersSelected) ");
                        }

                        Query query = session.createQuery(sql.toString());
                        if(locationId != null && locationId > 0){
                            query.setParameter("locationId", locationId);
                        }
                        if(customersSelected != null && customersSelected.size() > 0){
                            query.setParameterList("customersSelected", customersSelected);
                        }
                        return (List<CustomerEntity>) query.list();
                    }
                });
    }

    @Override
    public List<String> getEmailFromListCustomerId(final List<Long> customerIds, final List<Long> locations) {
        return getHibernateTemplate().execute(
            new HibernateCallback<List<String>>() {

                public List<String> doInHibernate(Session session) throws HibernateException, SQLException {
                    StringBuilder sql = new StringBuilder("SELECT ce.email FROM CustomerEntity ce WHERE 1 = 1 ");

                    if(locations != null && locations.size() > 0){
                        sql.append(" AND ce.location.locationId IN (:locations) ");
                        if(customerIds != null && customerIds.size() > 0){
                            sql.append(" OR ce.customerId IN (:customerIds) ");
                        }
                    } else {
                        if(customerIds != null && customerIds.size() > 0){
                            sql.append(" AND ce.customerId IN (:customerIds) ");
                        }
                    }
                    Query query = session.createQuery(sql.toString());
                    if(locations != null && locations.size() > 0){
                        query.setParameterList("locations", locations);
                        if(customerIds != null && customerIds.size() > 0){
                            query.setParameterList("customerIds", customerIds);
                        }
                    } else {
                        if(customerIds != null && customerIds.size() > 0){
                            query.setParameterList("customerIds", customerIds);
                        }
                    }
                    return (List<String>) query.list();
                }
            });
    }
}
