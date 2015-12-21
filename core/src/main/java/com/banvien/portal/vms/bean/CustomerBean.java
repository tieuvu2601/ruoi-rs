package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.CustomerEntity;

public class CustomerBean extends AbstractBean<CustomerEntity> {
    public CustomerBean(){
        this.pojo = new CustomerEntity();
    }
}
