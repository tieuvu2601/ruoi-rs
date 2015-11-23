package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.RenderingTemplateDAO;
import com.banvien.portal.vms.domain.RenderingTemplate;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;

import java.sql.Timestamp;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:55 PM
 * Author: vien.nguyen@banvien.com
 */
public class RenderingTemplateServiceImpl extends GenericServiceImpl<RenderingTemplate, Long> implements RenderingTemplateService {
    private RenderingTemplateDAO renderingTemplateDAO;

    public void setRenderingTemplateDAO(RenderingTemplateDAO renderingTemplateDAO) {
        this.renderingTemplateDAO = renderingTemplateDAO;
    }

    @Override
    protected GenericDAO<RenderingTemplate, Long> getGenericDAO() {
        return renderingTemplateDAO;
    }

    @Override
    public  RenderingTemplate findByCode(String Code) throws ObjectNotFoundException {
        RenderingTemplate res = renderingTemplateDAO.findEqualUnique("code", Code);
        if (res == null) throw new ObjectNotFoundException("Not found authoring rendering template " + Code);
        return res;
    }
    
    @Override
    public void updateItem(RenderingTemplate pojo) throws ObjectNotFoundException, DuplicateException {

        RenderingTemplate dbItem = this.renderingTemplateDAO.findByIdNoAutoCommit(pojo.getRenderingTemplateID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getRenderingTemplateID());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));

        this.renderingTemplateDAO.detach(dbItem);
        this.renderingTemplateDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                renderingTemplateDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }
    
}
