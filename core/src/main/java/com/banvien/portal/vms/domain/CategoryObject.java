package com.banvien.portal.vms.domain;

/**
 * Created with IntelliJ IDEA.
 * User: KhanhTran
 * Date: 10/9/15
 * Time: 2:20 PM
 * To change this template use File | Settings | File Templates.
 */
public class CategoryObject {
    private Long categoryID;

    private String code;

    private String name;

    private String prefixUrl;

    private Integer nodeLevel;

    private Integer displayOrder;

    private CategoryObject parent;

    private Integer childrenSize;

    private Long parentRootId;

    private AuthoringTemplate authoringTemplate;

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
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

    public CategoryObject getParent() {
        return parent;
    }

    public void setParent(CategoryObject parent) {
        this.parent = parent;
    }

    public AuthoringTemplate getAuthoringTemplate() {
        return authoringTemplate;
    }

    public void setAuthoringTemplate(AuthoringTemplate authoringTemplate) {
        this.authoringTemplate = authoringTemplate;
    }

    public Integer getNodeLevel() {
        return nodeLevel;
    }

    public void setNodeLevel(Integer nodeLevel) {
        this.nodeLevel = nodeLevel;
    }

    public String getPrefixUrl() {
        return prefixUrl;
    }

    public void setPrefixUrl(String prefixUrl) {
        this.prefixUrl = prefixUrl;
    }

    public Integer getChildrenSize() {
        return childrenSize;
    }

    public void setChildrenSize(Integer childrenSize) {
        this.childrenSize = childrenSize;
    }

    public Long getParentRootId() {
        return parentRootId;
    }

    public void setParentRootId(Long parentRootId) {
        this.parentRootId = parentRootId;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }
}
