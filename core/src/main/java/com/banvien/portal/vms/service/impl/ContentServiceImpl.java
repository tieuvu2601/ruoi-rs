package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.dto.TopViewContentDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.ContentService;
import com.banvien.portal.vms.util.Constants;
import org.apache.commons.lang.StringUtils;

import java.sql.Timestamp;
import java.util.*;

public class ContentServiceImpl extends GenericServiceImpl<ContentEntity, Long> implements ContentService {
    private Integer noOfDateTracking;

    public void setNoOfDateTracking(Integer noOfDateTracking) {
        this.noOfDateTracking = noOfDateTracking;
    }

    private ContentDAO contentDAO;

    public void setContentDAO(ContentDAO contentDAO) {
        this.contentDAO = contentDAO;
    }

    @Override
    protected GenericDAO<ContentEntity, Long> getGenericDAO() {
        return contentDAO;
    }
    
    @Override
    public void updateItem(ContentBean bean) throws ObjectNotFoundException, DuplicateException {
        ContentEntity pojo = bean.getPojo();
        ContentEntity dbItem = this.contentDAO.findByIdNoAutoCommit(pojo.getContentId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getContentId());

        if (StringUtils.isBlank(pojo.getThumbnails())) {
            pojo.setThumbnails(dbItem.getThumbnails());
        }
        pojo.setAuthoringTemplate(dbItem.getAuthoringTemplate());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setModifiedDate(now);

        if(pojo.getStatus() == Constants.CONTENT_PUBLISH){
            if(dbItem.getStatus() == Constants.CONTENT_PUBLISH){
                pojo.setPublishedDate(dbItem.getPublishedDate());
            } else {
                pojo.setPublishedDate(now);
            }

        }
        pojo.setModifiedDate(now);
        this.contentDAO.detach(dbItem);
        pojo = this.contentDAO.update(pojo);
    }

    @Override
    public void updateStatusItem(ContentEntity contentEntity) throws ObjectNotFoundException, DuplicateException {
        ContentEntity dbItem = this.contentDAO.findByIdNoAutoCommit(contentEntity.getContentId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + contentEntity.getContentId());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        ContentEntity newItem = dbItem;
        newItem.setStatus(contentEntity.getStatus());
        if(newItem.getStatus() == Constants.CONTENT_PUBLISH){
            if(dbItem.getStatus() == Constants.CONTENT_PUBLISH){
                newItem.setPublishedDate(dbItem.getPublishedDate());
            } else {
                newItem.setPublishedDate(now);
            }
        }
        newItem.setModifiedDate(now);
        this.contentDAO.detach(dbItem);
        this.contentDAO.update(newItem);
    }

    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                contentDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }

    @Override
    public List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        category = category.replaceAll("-", " ");
        return this.contentDAO.findByCategory(category, startRow, pageSize, isEng, status);
    }

    @Override
    public Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status) {
        category = category.replaceAll("-", " ");

        Object [] result =  this.contentDAO.findByCategoryWithMaxItem(category, startRow, pageSize, isEng, orderBy, status);
        List<ContentEntity> listContentEntity = new ArrayList<ContentEntity>();
        for(ContentEntity contentEntity : (List<ContentEntity>) result[1]){
            ContentEntity contentEntityObj = contentEntity;
            CategoryEntity categoryEntityObj = contentEntity.getCategory();
            if(categoryEntityObj.getParent() != null && categoryEntityObj.getParent().getCategoryId() != null && categoryEntityObj.getParent().getCategoryId() > 0){
                CategoryEntity parent = categoryEntityObj.getParent();
                categoryEntityObj.setParent(parent);
            } else {
                categoryEntityObj.setParent(null);
            }
            listContentEntity.add(contentEntityObj);
        }
        return new Object [] {result[0], listContentEntity};
    }


    @Override
    public List<ContentEntity> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("authoringTemplate.code", authoringCode);
        properties.put("status", Constants.CONTENT_PUBLISH);
        return this.contentDAO.findByProperties(properties, "modifiedDate", Constants.SORT_DESC, true, true, startRow, pageSize);
    }

    @Override
    public List<TopViewContentDTO> findTopViewByAuthoringCode(String authoringCode, String category, Integer pageSize){
        return contentDAO.findTopViewByAuthoringCode(authoringCode, category, pageSize, noOfDateTracking);
    }

    @Override
    public List<TopCommentsContentDTO> findTopCommentByAuthoringCode(String authoringCode, String category, Integer pageSize){
        return contentDAO.findTopCommentByAuthoringCode(authoringCode, category, pageSize, noOfDateTracking);
    }

    @Override
    public ContentEntity saveItem(ContentBean bean) throws DuplicateException {
        ContentEntity pojo = bean.getPojo();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getStatus() != null && pojo.getStatus() == Constants.CONTENT_PUBLISH){
            pojo.setPublishedDate(new Timestamp(System.currentTimeMillis()));
        }

        pojo = this.contentDAO.save(pojo);

        return pojo;
    }

    @Override
    public List<ContentEntity> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize) {
        return this.contentDAO.findByAuthoringTemplateAndDepartment(authoringTemplate, department, begin, pageSize);
    }

    @Override
    public List<ContentEntity> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize) {
        return this.contentDAO.findAnnouncementItemsOfOnlineUser(authoringCode, loginUserId, begin, pageSize);
    }

    @Override
    public List<ContentEntity> findByListTitle(List<String> title, Integer status) {
        return this.contentDAO.findByListTitle(title, status);
    }

    @Override
    public ContentEntity findByTitle(String title, Boolean isEng, Integer status) {
        title = title.replaceAll("-", " ");
        return this.contentDAO.findByTitle(title, isEng, status);
    }

    @Override
    public List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        return this.contentDAO.findByPrefixUrl(prefixUrl, startRow, pageSize, isEng, status);
    }


    @Override
    public List<ContentEntity> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        return this.contentDAO.findByAuthoringPrefixUrl(prefixUrl, startRow, pageSize, isEng, status);
    }

    @Override
    public Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer maxPageItems, String categorySearch, Boolean isEng, Integer status) {
        Date toDate = new Date(System.currentTimeMillis());
        return this.contentDAO.findByCategoryTypeWithMaxItem(categoryType, startRow, maxPageItems, toDate, categorySearch, isEng, status);
    }

    @Override
    public Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Boolean isEng, Integer status) {
        return this.contentDAO.searchInSite(keyword, fromDate, toDate, startRow, maxPageItems, isEng, status);
    }

    @Override
    public ContentEntity findByTitle(String title) throws ObjectNotFoundException {
        title = title.replaceAll("-", " ");
        ContentEntity contentEntity =  this.contentDAO.findEqualUnique("title", title);
        if(contentEntity == null) throw new ObjectNotFoundException("Not found ContentEntity with Title " + title);
        return contentEntity;
    }
}
