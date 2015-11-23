package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Page;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/26/12
 * Time: 2:54 PM
 */
public class PageBean extends AbstractBean<Page>{
    private String theme;
    private String layout = "onecolumn";

    private com.banvien.portal.vms.xml.page.Page pageXML;

    public PageBean() {
        this.pojo = new Page();
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getLayout() {
        return layout;
    }

    public void setLayout(String layout) {
        this.layout = layout;
    }

    public com.banvien.portal.vms.xml.page.Page getPageXML() {
        return pageXML;
    }

    public void setPageXML(com.banvien.portal.vms.xml.page.Page pageXML) {
        this.pageXML = pageXML;
    }
}
