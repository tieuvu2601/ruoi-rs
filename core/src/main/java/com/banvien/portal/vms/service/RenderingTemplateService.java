package com.banvien.portal.vms.service;

import com.banvien.portal.vms.domain.RenderingTemplate;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:42 PM
 * Author: vien.nguyen@banvien.com
 */
public interface RenderingTemplateService extends GenericService<RenderingTemplate, Long> {
    RenderingTemplate findByCode(String code) throws ObjectNotFoundException;

    void updateItem(RenderingTemplate pojo) throws ObjectNotFoundException, DuplicateException;

    Integer deleteItems(String[] checkList);

}
