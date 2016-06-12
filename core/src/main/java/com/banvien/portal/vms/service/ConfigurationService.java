package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.domain.CustomerEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

public interface ConfigurationService extends GenericService<ConfigurationEntity, Long> {

    ConfigurationEntity saveItem(ConfigurationEntity pojo);

    ConfigurationEntity updateItem(ConfigurationEntity pojo) throws ObjectNotFoundException, DuplicateException;

    ConfigurationEntity getConfigurationSite() throws ObjectNotFoundException;
}
