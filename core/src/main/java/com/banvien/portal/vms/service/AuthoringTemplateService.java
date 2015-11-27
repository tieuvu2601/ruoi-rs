package com.banvien.portal.vms.service;

import java.util.List;

import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

public interface AuthoringTemplateService extends GenericService<AuthoringTemplateEntity, Long> {
    AuthoringTemplateEntity findByCode(String code) throws ObjectNotFoundException;

    void updateItem(AuthoringTemplateEntity pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);
    
    public List<AuthoringTemplateEntity> findByUserId(Long loginUserId);
}
