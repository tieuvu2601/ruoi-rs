package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class SiteSettingEntity implements Serializable {
    private Long siteSettingId;
    private String googleAccount;
    private String passwordGoogleAccount;

    public Long getSiteSettingId() {
        return siteSettingId;
    }

    public void setSiteSettingId(Long siteSettingId) {
        this.siteSettingId = siteSettingId;
    }

    public String getGoogleAccount() {
        return googleAccount;
    }

    public void setGoogleAccount(String googleAccount) {
        this.googleAccount = googleAccount;
    }

    public String getPasswordGoogleAccount() {
        return passwordGoogleAccount;
    }

    public void setPasswordGoogleAccount(String passwordGoogleAccount) {
        this.passwordGoogleAccount = passwordGoogleAccount;
    }
}
