package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.dao.AuthoringTemplateDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.AuthoringTemplateEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.AuthoringTemplateService;

import java.sql.Timestamp;
import java.util.List;

public class AuthoringTemplateServiceImpl extends GenericServiceImpl<AuthoringTemplateEntity, Long> implements AuthoringTemplateService {
    private AuthoringTemplateDAO authoringTemplateDAO;

    public void setAuthoringTemplateDAO(AuthoringTemplateDAO authoringTemplateDAO) {
        this.authoringTemplateDAO = authoringTemplateDAO;
    }

    @Override
    protected GenericDAO<AuthoringTemplateEntity, Long> getGenericDAO() {
        return authoringTemplateDAO;
    }

    @Override
    public AuthoringTemplateEntity findByCode(String Code) throws ObjectNotFoundException {
        AuthoringTemplateEntity res = authoringTemplateDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring template " + Code);
        return res;
    }

    @Override
    public void updateItem(AuthoringTemplateEntity pojo) throws ObjectNotFoundException, DuplicateException {

        AuthoringTemplateEntity dbItem = this.authoringTemplateDAO.findByIdNoAutoCommit(pojo.getAuthoringTemplateId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getAuthoringTemplateId());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        this.authoringTemplateDAO.detach(dbItem);
        this.authoringTemplateDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                authoringTemplateDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
}
