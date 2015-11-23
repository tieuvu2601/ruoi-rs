package com.banvien.portal.vms.crawler;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate;

import java.util.List;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/23/13
 * Time: 10:31 AM
 */
public abstract class AbstractCrawler implements ICrawler {
    protected AuthoringTemplate authoringTemplate;

    protected String crawlerURL;
    public AbstractCrawler(String crawlerURL, AuthoringTemplate authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
        this.crawlerURL = crawlerURL;
    }
    public AuthoringTemplate getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(AuthoringTemplate authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public String getCrawlerURL() {
        return crawlerURL;
    }

    public void setCrawlerURL(String crawlerURL) {
        this.crawlerURL = crawlerURL;
    }
}
