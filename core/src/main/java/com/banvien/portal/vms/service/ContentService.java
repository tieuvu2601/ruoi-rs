package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;
import java.util.List;

public interface ContentService extends GenericService<Content, Long> {

    void updateItem(ContentBean bean) throws ObjectNotFoundException, DuplicateException;

    void updateStatusItem(Content content) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<Content> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status);

    List<Content> findByCategoryId(Long categoryId, Integer startRow, Integer pageSize, Integer status);

    List<Content> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize);

    Content saveItem(ContentBean bean) throws DuplicateException;

    List<Content> findRelatedItems(String authoringTemplate, String category, Long departmentID, Timestamp modifiedDate, Integer startRow, Integer pageSize);

	List<Content> findByListID(List<Long> contentIDs);

    List<Content> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<Content> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);

    List<Content> findByListTitle(List<String> title, Integer status);

    Content findByTitle(String title, Boolean isEng, Integer status);

    List<Content> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    List<Content> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer maxPageItems, String categorySearch, Boolean isEng, Integer status);

    Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Boolean isEng, Integer status);

    Content findByTitle(String title) throws ObjectNotFoundException;
}
