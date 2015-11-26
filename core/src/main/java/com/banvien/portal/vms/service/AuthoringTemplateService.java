package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.AuthoringTemplate;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface AuthoringTemplateService extends GenericService<AuthoringTemplate, Long> {
    AuthoringTemplate findByCode(String code) throws ObjectNotFoundException;

    void updateItem(AuthoringTemplate pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    public List<AuthoringTemplate> findByUserId(Long loginUserId);
}
