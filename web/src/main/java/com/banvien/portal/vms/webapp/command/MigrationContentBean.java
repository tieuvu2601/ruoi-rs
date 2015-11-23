package com.banvien.portal.vms.webapp.command;

import com.banvien.portal.vms.bean.AbstractBean;
import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.dto.ContentDTO;

import java.io.Serializable;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/22/13
 * Time: 9:39 PM
 */
public class MigrationContentBean extends AbstractBean<ContentDTO> implements Serializable {
    private Long authoringTemplateID;

    private Long categoryID;

    private Long departmentID;

    private String crawlerUrl;

    private Integer maxCrawlItem;

    private String geturl;

    public Long getAuthoringTemplateID() {
        return authoringTemplateID;
    }

    public void setAuthoringTemplateID(Long authoringTemplateID) {
        this.authoringTemplateID = authoringTemplateID;
    }

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

    public String getCrawlerUrl() {
        return crawlerUrl;
    }

    public void setCrawlerUrl(String crawlerUrl) {
        this.crawlerUrl = crawlerUrl;
    }


    public Long getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(Long departmentID) {
        this.departmentID = departmentID;
    }

    public Integer getMaxCrawlItem() {
        return maxCrawlItem;
    }

    public void setMaxCrawlItem(Integer maxCrawlItem) {
        this.maxCrawlItem = maxCrawlItem;
    }

    public String getGeturl() {
        return geturl;
    }

    public void setGeturl(String geturl) {
        this.geturl = geturl;
    }
}
