package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.AuthoringTemplate;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 5:40 PM
 * Author: vien.nguyen@banvien.com
 */
public class AuthoringTemplateBean extends AbstractBean<AuthoringTemplate> {
    public AuthoringTemplateBean(){
        this.pojo = new AuthoringTemplate();
    }

    private List<XmlNodeDTO> authoringTemplateNodes;

    public List<XmlNodeDTO> getAuthoringTemplateNodes() {
        return authoringTemplateNodes;
    }

    public void setAuthoringTemplateNodes(List<XmlNodeDTO> authoringTemplateNodes) {
        this.authoringTemplateNodes = authoringTemplateNodes;
    }
}
