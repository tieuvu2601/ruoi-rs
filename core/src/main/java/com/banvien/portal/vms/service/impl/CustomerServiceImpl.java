package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.CustomerDAO;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.CustomerService;

import java.sql.Timestamp;

public class CustomerServiceImpl extends GenericServiceImpl<CustomerEntity, Long> implements CustomerService {
    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO CustomerDAO) {
        this.customerDAO = CustomerDAO;
    }

    @Override
    protected GenericDAO<CustomerEntity, Long> getGenericDAO() {
        return customerDAO;
    }

    @Override
    public CustomerEntity saveItem(CustomerEntity pojo) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(now);
        pojo.setModifiedDate(now);
        return this.customerDAO.save(pojo);
    }

    @Override
    public CustomerEntity updateItem(CustomerEntity pojo) throws ObjectNotFoundException, DuplicateException {
        CustomerEntity dbItem = this.customerDAO.findByIdNoAutoCommit(pojo.getCustomerId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Customer " + pojo.getCustomerId());
        pojo.setCreatedBy(dbItem.getCreatedBy());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.customerDAO.detach(dbItem);
        return this.customerDAO.update(pojo);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                this.customerDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public CustomerEntity findByEmail(String email) throws ObjectNotFoundException {
        CustomerEntity res = this.customerDAO.findEqualUnique("email", email);
        if (res == null) throw new ObjectNotFoundException("Not found Customer with email: " + email);
        return res;
    }
}
