package com.banvien.portal.vms.bean;

import java.io.Serializable;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/21/12
 * Time: 4:47 PM
 */
public class XmlNodeDTO implements Serializable {
    private String name;

    private String displayName;

    private String type;

    private String defaultValue;

    private String constraintValues;

    private Integer minOccurs;

    private Integer maxOccurs;

    private Integer displayOrder;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getConstraintValues() {
        return constraintValues;
    }

    public void setConstraintValues(String constraintValues) {
        this.constraintValues = constraintValues;
    }

    public Integer getMinOccurs() {
        return minOccurs;
    }

    public void setMinOccurs(Integer minOccurs) {
        this.minOccurs = minOccurs;
    }

    public Integer getMaxOccurs() {
        return maxOccurs;
    }

    public void setMaxOccurs(Integer maxOccurs) {
        this.maxOccurs = maxOccurs;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }
}
