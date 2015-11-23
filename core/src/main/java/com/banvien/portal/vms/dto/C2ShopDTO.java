package com.banvien.portal.vms.dto;

import java.io.Serializable;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 5/4/13
 * Time: 7:30 AM
 * Author: vien.nguyen@banvien.com
 */
public class C2ShopDTO implements Serializable {
    private String shopCode;

    private String parentShopCode;

    public String getShopCode() {
        return shopCode;
    }

    public void setShopCode(String shopCode) {
        this.shopCode = shopCode;
    }

    public String getParentShopCode() {
        return parentShopCode;
    }

    public void setParentShopCode(String parentShopCode) {
        this.parentShopCode = parentShopCode;
    }
}
