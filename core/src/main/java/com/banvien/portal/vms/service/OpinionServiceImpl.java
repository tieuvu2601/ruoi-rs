package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.OpinionDAO;
import com.banvien.portal.vms.domain.Opinion;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;

public class OpinionServiceImpl extends GenericServiceImpl<Opinion, Long> implements OpinionService{
    private OpinionDAO opinionDAO;

    public OpinionDAO getOpinionDAO() {
        return opinionDAO;
    }

    public void setOpinionDAO(OpinionDAO opinionDAO) {
        this.opinionDAO = opinionDAO;
    }

    @Override
    protected GenericDAO<Opinion, Long> getGenericDAO() {
        return opinionDAO;
    }

    @Override
    public Opinion updateItem(Opinion pojo) throws ObjectNotFoundException {
        Opinion dbItem = this.opinionDAO.findByIdNoAutoCommit(pojo.getOpinionID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getOpinionID());

        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setResolvedDate(new Timestamp(System.currentTimeMillis()));
        this.opinionDAO.detach(dbItem);
        return this.opinionDAO.update(pojo);
    }

}
