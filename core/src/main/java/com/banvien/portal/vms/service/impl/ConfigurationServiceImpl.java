package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.ConfigurationDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.ConfigurationEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.ConfigurationService;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ConfigurationServiceImpl extends GenericServiceImpl<ConfigurationEntity, Long> implements ConfigurationService {
    private ConfigurationDAO configurationDAO;

    public void setConfigurationDAO(ConfigurationDAO ConfigurationDAO) {
        this.configurationDAO = ConfigurationDAO;
    }

    @Override
    protected GenericDAO<ConfigurationEntity, Long> getGenericDAO() {
        return configurationDAO;
    }

    @Override
    public ConfigurationEntity saveItem(ConfigurationEntity pojo) {
        return this.configurationDAO.save(pojo);
    }

    @Override
    public ConfigurationEntity updateItem(ConfigurationEntity pojo) throws ObjectNotFoundException, DuplicateException {
        ConfigurationEntity dbItem = this.configurationDAO.findByIdNoAutoCommit(pojo.getConfigurationId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found Configuration " + pojo.getConfigurationId());
        this.configurationDAO.detach(dbItem);
        return this.configurationDAO.update(pojo);
    }

    @Override
    public ConfigurationEntity getConfigurationSite() throws ObjectNotFoundException {
        List<ConfigurationEntity> listConfigurations = this.configurationDAO.findAll();
        if(listConfigurations != null && listConfigurations.size() > 0){
            return listConfigurations.get(0);
        } else {
            return new ConfigurationEntity();
        }
    }


}
