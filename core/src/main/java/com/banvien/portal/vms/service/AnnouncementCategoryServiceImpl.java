package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.AnnouncementCategoryDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.AnnouncementCategory;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 2/26/13
 * Time: 9:00 AM
 */
public class AnnouncementCategoryServiceImpl extends GenericServiceImpl<AnnouncementCategory, Long> implements AnnouncementCategoryService {
    private AnnouncementCategoryDAO announcementCategoryDAO;

    @Override
    protected GenericDAO<AnnouncementCategory, Long> getGenericDAO() {
        return announcementCategoryDAO;
    }

    public void setAnnouncementCategoryDAO(AnnouncementCategoryDAO announcementCategoryDAO) {
        this.announcementCategoryDAO = announcementCategoryDAO;
    }
}
