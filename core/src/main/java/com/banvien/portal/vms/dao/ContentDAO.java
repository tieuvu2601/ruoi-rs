package com.banvien.portal.vms.dao;

import java.util.Date;
import java.sql.Timestamp;
import java.util.List;

import com.banvien.portal.vms.domain.Content;

public interface ContentDAO extends GenericDAO<Content, Long> {

    List<Content> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status);

    List<Content> findByCategoryId(Long categoryID, Integer startRow, Integer pageSize, Integer status);

    List<Content> findRelatedItems(String authoringTemplate, String category, Long departmentID, Timestamp modifiedDate, Integer startRow, Integer pageSize);

	List<Content> findByListID(List<Long> contentIDs);

    List<Content> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<Content> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);

    List<Content> findByListTitle(List<String> title, Integer status);

    List<Content> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer pageSize, Date toDate, String categorySearch, Boolean isEng, Integer status);

    Content findByTitle(String title, Boolean isEng, Integer status);

    Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Boolean isEng, Integer status);

    List<Content> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean eng, Integer status);
}
