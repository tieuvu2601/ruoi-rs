package com.banvien.portal.vms.dto;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: viennh
 * Date: 12/26/12
 * Time: 4:28 PM
 * To change this template use File | Settings | File Templates.
 */
public class C2UserDTO implements Serializable {
    private String username;
    private String password;
    private String fullname;
    private String status;

    private String shopcode;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShopcode() {
        return shopcode;
    }

    public void setShopcode(String shopcode) {
        this.shopcode = shopcode;
    }
}
