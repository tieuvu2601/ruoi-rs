package com.banvien.portal.vms.crawler;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.dto.ContentDTO;

import java.util.List;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/23/13
 * Time: 10:34 AM
 */
public interface ICrawler {
    public List<ContentDTO> extractContents();
}
