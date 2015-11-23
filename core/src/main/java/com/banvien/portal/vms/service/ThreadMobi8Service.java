package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dto.ThreadDTO;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:39 PM
 * Author: vien.nguyen@banvien.com
 */
public interface ThreadMobi8Service extends GenericService<ThreadDTO, Long> {
    List<ThreadDTO> findThreadHotOnForum() throws Exception;
}
