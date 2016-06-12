package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.ConfigurationEntity;

public class ConfigurationBean extends AbstractBean<ConfigurationEntity> {
    public ConfigurationBean()
    {
        this.pojo = new ConfigurationEntity();
    }
}
