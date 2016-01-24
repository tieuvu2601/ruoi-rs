package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.RoleEntity;

import java.util.List;

public interface CustomerDAO extends GenericDAO<CustomerEntity, Long> {

    List<CustomerEntity> loadCustomerByProperties(String email, String fullName, String phoneNumber, String address, Long locationId, List<Long> customersSelected);

    List<String> getEmailFromListCustomerId(List<Long> customerIds, List<Long> locationList);
}
