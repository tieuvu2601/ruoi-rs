package com.banvien.portal.vms.domain;

import java.io.Serializable;

public class LocationEntity implements Serializable {
    private Long locationId;
    private String code;
    private String name;
    private Integer displayOrder;
    private LocationEntity parent;

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public LocationEntity getParent() {
        return parent;
    }

    public void setParent(LocationEntity parent) {
        this.parent = parent;
    }
}
