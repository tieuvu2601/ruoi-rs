package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface CustomerService extends GenericService<CustomerEntity, Long> {

    CustomerEntity saveItem(CustomerEntity pojo);

    CustomerEntity updateItem(CustomerEntity pojo) throws ObjectNotFoundException, DuplicateException;

    CustomerEntity findByEmail(String email) throws ObjectNotFoundException;

    Integer deleteItems(String[] checkList);
}
