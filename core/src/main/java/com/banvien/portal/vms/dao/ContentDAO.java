package com.banvien.portal.vms.dao;

import java.util.Date;
import java.sql.Timestamp;
import java.util.List;

import com.banvien.portal.vms.domain.ContentEntity;

public interface ContentDAO extends GenericDAO<ContentEntity, Long> {



    Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status);

    List<ContentEntity> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<ContentEntity> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);

    List<ContentEntity> findByListTitle(List<String> title, Integer status);

    List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer pageSize, Date toDate, String categorySearch, Boolean isEng, Integer status);



    List<ContentEntity> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean eng, Integer status);



    //    new content function
    ContentEntity findByTitle(String title, Integer status);

    List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer begin, Integer pageSize, Integer status);

    Object[] findAllContentsByCategoryType(Long categoryTypeId, Integer begin, Integer pageSize, Integer status);

    List<ContentEntity> getHotProduct(Integer startRow, Integer pageSize, Integer status);

    List<ContentEntity> findContentForBuildSlider(Integer pageSize, Integer status);

    List<ContentEntity> findContentByProperties(String title, String keyword, Integer status, Long authoringTemplateId, Long categoryId, List<Long> listContent);

    void removeSlideContent(List<Long> listContent);

    List<ContentEntity> findByListContentId(List<Long> listContent);

    Object[] findByCategoryWithPage(String category, Integer startRow, Integer maxPageSize, Integer status);

    Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Integer status);

    List<ContentEntity> findByListCategory(List<Long> listCategoryId, Integer status);
}
