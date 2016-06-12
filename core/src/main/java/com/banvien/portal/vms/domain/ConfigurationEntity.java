package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class ConfigurationEntity implements Serializable {
    private Long configurationId;
    private String hotLine;
    private String aboutMe;
    private String customCSS;

    public Long getConfigurationId() {
        return configurationId;
    }

    public void setConfigurationId(Long configurationId) {
        this.configurationId = configurationId;
    }

    public String getHotLine() {
        return hotLine;
    }

    public void setHotLine(String hotLine) {
        this.hotLine = hotLine;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public String getCustomCSS() {
        return customCSS;
    }

    public void setCustomCSS(String customCSS) {
        this.customCSS = customCSS;
    }
}
