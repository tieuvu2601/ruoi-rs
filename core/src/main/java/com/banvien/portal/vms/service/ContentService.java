package com.banvien.portal.vms.service;

import com.banvien.portal.vms.bean.ContentBean;
import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.dto.CategoryTypeDTO;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import java.util.List;

public interface ContentService extends GenericService<ContentEntity, Long> {

    void updateItem(ContentBean bean) throws ObjectNotFoundException, DuplicateException;

    void updateStatusItem(ContentEntity contentEntity) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);



    List<ContentEntity> findByAuthoringTemplate(String authoringCode, Integer startRow, Integer pageSize);

    ContentEntity saveItem(ContentBean bean) throws DuplicateException;

    List<ContentEntity> findByAuthoringTemplateAndDepartment(String authoringTemplate, String department, Integer begin, Integer pageSize);

    List<ContentEntity> findAnnouncementItemsOfOnlineUser(String authoringCode, Long loginUserId, Integer begin, Integer pageSize);



    List<ContentEntity> findByPrefixUrl(String prefixUrl, Integer startRow, Integer pageSize, Boolean isEng, Integer status);

    Object[] findByCategoryTypeWithMaxItem(String categoryType, Integer startRow, Integer maxPageItems, String categorySearch, Boolean isEng, Integer status);

    ContentEntity findByTitle(String title) throws ObjectNotFoundException;

    // ---------------------  new update -----------------------------//

    ContentEntity findByTitle(String title, Integer status);

    List<ContentEntity> findByCategory(String category, Integer startRow, Integer pageSize, Integer status);

    List<CategoryTypeDTO> findAllContentsByCategoryType(Integer begin, Integer pageSize, Integer status);

    List<ContentEntity> getHotProduct(Integer startRow, Integer pageSize, Integer status);

    List<ContentEntity> findContentForBuildSlider(Integer pageSize, Integer status);

    List<ContentEntity> findContentByProperties(String title, String keyword, Integer status, Long authoringTemplateId, Long categoryId, List<Long> listContent);

    void updateListSlider(String[] checkList);
}
