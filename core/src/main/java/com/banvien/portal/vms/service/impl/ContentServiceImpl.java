package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.dao.CategoryTypeDAO;
import com.banvien.portal.vms.dao.ContentDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.*;
import com.banvien.portal.vms.dto.CategoryTypeDTO;
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

    private CategoryTypeDAO categoryTypeDAO;

    public void setContentDAO(ContentDAO contentDAO) {
        this.contentDAO = contentDAO;
    }

    public CategoryTypeDAO getCategoryTypeDAO() {
        return categoryTypeDAO;
    }

    public void setCategoryTypeDAO(CategoryTypeDAO categoryTypeDAO) {
        this.categoryTypeDAO = categoryTypeDAO;
    }

    @Override
    protected GenericDAO<ContentEntity, Long> getGenericDAO() {
        return contentDAO;
    }
    
    @Override
    public void updateItem(ContentBean bean, Boolean updatePublishedDate) throws ObjectNotFoundException, DuplicateException {
        ContentEntity pojo = bean.getPojo();
        ContentEntity dbItem = this.contentDAO.findByIdNoAutoCommit(pojo.getContentId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getContentId());

        if (StringUtils.isBlank(pojo.getThumbnails())) {
            pojo.setThumbnails(dbItem.getThumbnails());
        }
        pojo.setAuthoringTemplate(dbItem.getAuthoringTemplate());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        pojo.setCreatedDate(dbItem.getCreatedDate());
        pojo.setEmailSubject(dbItem.getEmailSubject());
        pojo.setEmailContent(dbItem.getEmailContent());
        pojo.setModifiedDate(now);

        if(pojo.getStatus() == Constants.CONTENT_PUBLISH){
            if(updatePublishedDate){
                pojo.setPublishedDate(now);
            } else {
                if(dbItem.getStatus() == Constants.CONTENT_PUBLISH){
                    pojo.setPublishedDate(dbItem.getPublishedDate());
                } else {
                    pojo.setPublishedDate(now);
                }
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
    public void updateEmailContent(Long contentId, String emailSubject, String emailContent) throws ObjectNotFoundException {
        ContentEntity dbItem = this.contentDAO.findByIdNoAutoCommit(contentId);
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + contentId.toString());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        ContentEntity newItem = dbItem;
        newItem.setEmailSubject(emailSubject);
        newItem.setEmailContent(emailContent);

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
    public List<ContentEntity> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize) {
        Map<String, Object> properties = new HashMap<String, Object>();
        properties.put("authoringTemplate.code", authoringCode);
        properties.put("status", Constants.CONTENT_PUBLISH);
        return this.contentDAO.findByProperties(properties, "modifiedDate", Constants.SORT_DESC, true, true, startRow, pageSize);
    }

    @Override
    public ContentEntity saveItem(ContentBean bean) throws DuplicateException {
        ContentEntity pojo = bean.getPojo();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        pojo.setCreatedDate(now);
        pojo.setModifiedDate(now);
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
    public List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status) {
        return this.contentDAO.findByPrefixUrl(prefixUrl, startRow, pageSize, isEng, status);
    }

    @Override
    public Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer maxPageItems, String categorySearch, Boolean isEng, Integer status) {
        Date toDate = new Date(System.currentTimeMillis());
        return this.contentDAO.findByCategoryTypeWithMaxItem(categoryType, startRow, maxPageItems, toDate, categorySearch, isEng, status);
    }

    @Override
    public ContentEntity findByTitle(String title) throws ObjectNotFoundException {
        title = title.replaceAll("-", " ");
        ContentEntity contentEntity =  this.contentDAO.findEqualUnique("title", title);
        if(contentEntity == null) throw new ObjectNotFoundException("Not found ContentEntity with Title " + title);
        return contentEntity;
    }

    // ---------------------  new update -----------------------------//

    @Override
    public ContentEntity findByTitle(String title, Integer status) {
        return this.contentDAO.findByTitle(title, status);
    }

    @Override
    public List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Integer status) {
        return this.contentDAO.findByCategory(category, startRow, pageSize, status);
    }


    @Override
    public List<CategoryTypeDTO> findAllContentsByCategoryType(Integer begin, Integer pageSize, Integer status) {
        List<CategoryTypeDTO> resultList = new ArrayList<CategoryTypeDTO>();

        List<CategoryTypeEntity> categoryTypes = this.categoryTypeDAO.findAllCategoryType();

        for(CategoryTypeEntity categoryTypeEntity : categoryTypes){
            Object [] listCategoryType = this.contentDAO.findAllContentsByCategoryType(categoryTypeEntity.getCategoryTypeId(), begin, pageSize, status);
            CategoryTypeDTO categoryTypeDTO = new CategoryTypeDTO();

            List<ContentEntity> contents = (List<ContentEntity>) listCategoryType[0];
            Long totalNumber = (Long)  listCategoryType[1];
            categoryTypeDTO.setContents(contents);
            categoryTypeDTO.setTotalNumber(totalNumber != null && totalNumber > 0l ? totalNumber : 0l);
            categoryTypeDTO.setCategoryType(categoryTypeEntity);

            resultList.add(categoryTypeDTO);
        }
        return resultList;
    }

    @Override
    public List<ContentEntity> getHotProduct(Integer startRow, Integer pageSize, Integer status) {
        return this.contentDAO.getHotProduct(startRow, pageSize, status);
    }

    @Override
    public List<ContentEntity> findContentForBuildSlider(Integer pageSize, Integer status) {
        return this.contentDAO.findContentForBuildSlider(pageSize, status);
    }

    @Override
    public List<ContentEntity> findContentByProperties(String title, String keyword, Integer status, Long authoringTemplateId, Long categoryId, List<Long> listContent) {
        return this.contentDAO.findContentByProperties(title, keyword, status, authoringTemplateId, categoryId, listContent);
    }

    @Override
    public void updateListSlider(String[] checkList) {
        if(checkList != null && checkList.length > 0){
            List<Long> listContent = new ArrayList<Long>();
            for(String contentId : checkList){
                listContent.add(Long.valueOf(contentId));
            }
            this.contentDAO.removeSlideContent(listContent);
            List<ContentEntity> contents = this.contentDAO.findByListContentId(listContent);

            HashMap<Long, ContentEntity> hashMap = new HashMap<Long, ContentEntity>();

            for(ContentEntity content: contents){
                hashMap.put(content.getContentId(), content);

            }

            Integer index = 1;
            for(Long contentId : listContent){
                ContentEntity content = hashMap.get(contentId);
                if(content != null){
                    content.setDisplayOrder(index);
                    content.setSlide(1);
                    content.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                    this.contentDAO.detach(content);
                    this.contentDAO.saveOrUpdate(content);
                    index++;
                }
            }
        }
    }

    @Override
    public Object[] findByCategoryWithPage(String category, Integer startRow, Integer maxPageSize, Integer status) {
        return this.contentDAO.findByCategoryWithPage(category, startRow, maxPageSize, status);
    }

    @Override
    public Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Integer status) {
        return this.contentDAO.searchInSite(keyword.toLowerCase(), fromDate, toDate, startRow, maxPageItems, status);
    }

    @Override
    public List<ContentEntity> findByListCategory(List<Long> listCategoryId, Integer status) {
        return this.contentDAO.findByListCategory(listCategoryId, status);
    }
}
