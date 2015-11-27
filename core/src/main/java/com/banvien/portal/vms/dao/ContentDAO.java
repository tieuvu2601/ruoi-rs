package com.banvien.portal.vms.dao;

import java.util.Date;
import java.sql.Timestamp;
import java.util.List;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.dto.TopViewContentDTO;

public interface ContentDAO extends GenericDAO<ContentEntity, Long> {

    List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status);

    List<ContentEntity> findByCategoryId(Long categoryID, Integer startRow, Integer pageSize, Integer status);

    List<ContentEntity> findRelatedItems(String authoringTemplate, String category, Long departmentID, Timestamp modifiedDate, Integer startRow, Integer pageSize);

    List<TopViewContentDTO> findTopViewByAuthoringCode(String authoringCode, String category, Integer pageSize, Integer noOfDateTracking);

    List<TopCommentsContentDTO> findTopCommentByAuthoringCode(String authoringCode, String category, Integer pageSize, Integer noOfDateTracking);
    
    Object[] reportByPublishedDate(Timestamp fromDate, Timestamp toDate, Integer startIndex, Integer pageSize, String sortProperty, String sortDirection);
    
    Object[] reportByDepartment(Timestamp fromDate, Timestamp toDate, Long departmentID, Integer status, Integer startIndex, Integer pageSize, String sortProperty, String sortDirection);
    
    Object[] reportByAccessViewOrUserLike(Timestamp fromDate, Timestamp toDate, Integer top, Integer startIndex, Integer pageSize, String sortProperty, String sortDirection, Boolean isAccessViewReport);
    
    Object[] reportByComment(Timestamp fromDate, Timestamp toDate, Integer top, Integer startIndex, Integer pageSize, String sortProperty, String sortDirection);

	List<ContentEntity> findByListID(List<Long> contentIDs);

    List<ContentEntity> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<ContentEntity> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);

    List<ContentEntity> findByListTitle(List<String> title, Integer status);

    List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer pageSize, Date toDate, String categorySearch, Boolean isEng, Integer status);

    Object[] findByParentCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Integer status);

    ContentEntity findByTitle(String title, Boolean isEng, Integer status);

    Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Boolean isEng, Integer status);

    List<ContentEntity> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean eng, Integer status);
}
