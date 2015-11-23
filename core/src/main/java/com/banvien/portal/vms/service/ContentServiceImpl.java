package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.dao.ContentCategoryDAO;
import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.dao.ContentDepartmentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.dto.TopViewContentDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.util.Constants;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.i18n.LocaleContextHolder;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;


/**
* Copyright (c) by Ban Vien Co., Ltd.
* User: MBP
* Date: 11/13/12
* Time: 4:47 PM
* Author: vien.nguyen@banvien.com
*/
public class ContentServiceImpl extends GenericServiceImpl<Content, Long> implements ContentService {
    private Integer noOfDateTracking;

    public void setNoOfDateTracking(Integer noOfDateTracking) {
        this.noOfDateTracking = noOfDateTracking;
    }

    private ContentDAO contentDAO;

    private ContentCategoryDAO contentCategoryDAO;

    private ContentDepartmentDAO contentDepartmentDAO;

    public void setContentDAO(ContentDAO contentDAO) {
        this.contentDAO = contentDAO;
    }

    public void setContentCategoryDAO(ContentCategoryDAO contentCategoryDAO) {
        this.contentCategoryDAO = contentCategoryDAO;
    }

    public void setContentDepartmentDAO(ContentDepartmentDAO contentDepartmentDAO) {
        this.contentDepartmentDAO = contentDepartmentDAO;
    }

    @Override
    protected GenericDAO<Content, Long> getGenericDAO() {
        return contentDAO;
    }
    
    @Override
    public void updateItem(ContentBean bean) throws ObjectNotFoundException, DuplicateException {
        Content pojo = bean.getPojo();
        Content dbItem = this.contentDAO.findByIdNoAutoCommit(pojo.getContentID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getContentID());

        if (StringUtils.isBlank(pojo.getThumbnail())) {
            pojo.setThumbnail(dbItem.getThumbnail());
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
    public void updateStatusItem(Content content) throws ObjectNotFoundException, DuplicateException {
        Content dbItem = this.contentDAO.findByIdNoAutoCommit(content.getContentID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + content.getContentID());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Content newItem = dbItem;
        newItem.setStatus(content.getStatus());
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
    public List<Content> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        category = category.replaceAll("-", " ");
        return this.contentDAO.findByCategory(category, startRow, pageSize, isEng, status);
    }

    @Override
    public Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status) {
        category = category.replaceAll("-", " ");

        Object [] result =  this.contentDAO.findByCategoryWithMaxItem(category, startRow, pageSize, isEng, orderBy, status);
        List<Content> listContent = new ArrayList<Content>();
        for(Content content : (List<Content>) result[1]){
            Content contentObj = content;
            Category categoryObj = content.getCategory();
            if(categoryObj.getParentCategory() != null && categoryObj.getParentCategory().getCategoryID() != null && categoryObj.getParentCategory().getCategoryID() > 0){
                Category parent = categoryObj.getParentCategory();
                categoryObj.setParentCategory(parent);
            } else {
                categoryObj.setParentCategory(null);
            }
            listContent.add(contentObj);
        }
        return new Object [] {result[0], listContent};
    }

    @Override
    public List<Content> findByCategoryId(Long categoryId, Integer startRow, Integer pageSize, Integer status) {
        return this.contentDAO.findByCategoryId(categoryId, startRow, pageSize, status);
    }

    @Override
    public List<Content> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize) {
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
    public Content saveItem(ContentBean bean) throws DuplicateException {
        Content pojo = bean.getPojo();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        pojo.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        pojo.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        if(pojo.getStatus() != null && pojo.getStatus() == Constants.CONTENT_PUBLISH){
            pojo.setPublishedDate(new Timestamp(System.currentTimeMillis()));
        }

        pojo = this.contentDAO.save(pojo);
        if(bean.getCategoryIDs() != null){
            for (Long categoryID : bean.getCategoryIDs()) {
                ContentCategory contentCategory = new ContentCategory();
                contentCategory.setContent(pojo);
                Category category = new Category();
                category.setCategoryID(categoryID);
                contentCategory.setCategory(category);
                contentCategory.setCreatedDate(now);
                contentCategory.setModifiedDate(now);

                contentCategoryDAO.save(contentCategory);
            }
        }

        if (bean.getDepartmentIDs() != null) {
            for(Long departmentID : bean.getDepartmentIDs()) {
                ContentDepartment contentDepartment = new ContentDepartment();
                contentDepartment.setContent(pojo);
                Department department = new Department();
                department.setDepartmentID(departmentID);
                contentDepartment.setDepartment(department);
                contentDepartmentDAO.save(contentDepartment);
            }
        }

        return pojo;
    }

    @Override
    public List<Content> findRelatedItems(String authoringTemplate, String category, Long departmentID, Timestamp modifiedDate, Integer startRow, Integer pageSize) {
        return this.contentDAO.findRelatedItems(authoringTemplate, category, departmentID, modifiedDate, startRow, pageSize);
    }

	@Override
	public List<Content> findByListID(List<Long> contentIDs) {
		return this.contentDAO.findByListID(contentIDs);
	}

    @Override
    public List<Content> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize) {
        return this.contentDAO.findByAuthoringTemplateAndDepartment(authoringTemplate, department, begin, pageSize);
    }

    @Override
    public List<Content> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize) {
        return this.contentDAO.findAnnouncementItemsOfOnlineUser(authoringCode, loginUserId, begin, pageSize);
    }

    @Override
    public List<Content> findByListTitle(List<String> title, Integer status) {
        return this.contentDAO.findByListTitle(title, status);
    }

    @Override
    public Content findByTitle(String title, Boolean isEng, Integer status) {
        title = title.replaceAll("-", " ");
        return this.contentDAO.findByTitle(title, isEng, status);
    }

    @Override
    public List<Content> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        return this.contentDAO.findByPrefixUrl(prefixUrl, startRow, pageSize, isEng, status);
    }


    @Override
    public List<Content> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
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
    public Content findByTitle(String title) throws ObjectNotFoundException {
        title = title.replaceAll("-", " ");
        Content content =  this.contentDAO.findEqualUnique("title", title);
        if(content == null) throw new ObjectNotFoundException("Not found Content with Title " + title);
        return content;
    }
}
