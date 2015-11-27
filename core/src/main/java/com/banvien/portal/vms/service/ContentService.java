package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.dto.TopCommentsContentDTO;
import com.banvien.portal.vms.dto.TopViewContentDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.sql.Timestamp;
import java.util.List;

public interface ContentService extends GenericService<ContentEntity, Long> {

    void updateItem(ContentBean bean) throws ObjectNotFoundException, DuplicateException;

    void updateStatusItem(ContentEntity contentEntity) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

    List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object [] findByCategoryWithMaxItem(String category, Integer startRow, Integer pageSize, Boolean isEng, Integer orderBy, Integer status);

    List<ContentEntity> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize);

    List<TopViewContentDTO> findTopViewByAuthoringCode(String authoringCode, String category, Integer pageSize);

    List<TopCommentsContentDTO> findTopCommentByAuthoringCode(String authoringCode, String category, Integer pageSize);

    ContentEntity saveItem(ContentBean bean) throws DuplicateException;

    List<ContentEntity> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<ContentEntity> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);

    List<ContentEntity> findByListTitle(List<String> title, Integer status);

    ContentEntity findByTitle(String title, Boolean isEng, Integer status);

    List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    List<ContentEntity> findByAuthoringPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer maxPageItems, String categorySearch, Boolean isEng, Integer status);

    Object[] searchInSite(String keyword, Timestamp fromDate, Timestamp toDate, Integer startRow, Integer maxPageItems, Boolean isEng, Integer status);

    ContentEntity findByTitle(String title) throws ObjectNotFoundException;
}
