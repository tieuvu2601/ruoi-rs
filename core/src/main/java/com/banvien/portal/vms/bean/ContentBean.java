package com.banvien.portal.vms.bean;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.xml.contentitem.ContentItem;

public class ContentBean extends AbstractBean<Content> {
    private FileItem thumbnailFile;

    private Long authoringTemplateID;

    private Timestamp fromDate;

    private Timestamp toDate;

    private ContentItem contentItem;

    private Long categoryID;

    private Long[] categoryIDs;

    private Long[] departmentIDs;

    private Map<Long, Boolean> contentPublishedMap;
    
    private Map<String, List<String>> oldNodeAttachementValues;
    
    private List<String> deletedAttchments;

    public ContentBean()
    {
        this.pojo = new Content();
    }

    public FileItem getThumbnailFile() {
        return thumbnailFile;
    }

    public void setThumbnailFile(FileItem thumbnailFile) {
        this.thumbnailFile = thumbnailFile;
    }

    public Timestamp getFromDate() {
        return fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    public Timestamp getToDate() {
        return toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }


    public Long getAuthoringTemplateID() {
        return authoringTemplateID;
    }

    public void setAuthoringTemplateID(Long authoringTemplateID) {
        this.authoringTemplateID = authoringTemplateID;
    }

    public ContentItem getContentItem() {
        return contentItem;
    }

    public void setContentItem(ContentItem contentItem) {
        this.contentItem = contentItem;
    }

    public Long[] getCategoryIDs() {
        return categoryIDs;
    }

    public void setCategoryIDs(Long[] categoryIDs) {
        this.categoryIDs = categoryIDs;
    }

	public Map<Long, Boolean> getContentPublishedMap() {
		return contentPublishedMap;
	}

	public void setContentPublishedMap(Map<Long, Boolean> contentPublishedMap) {
		this.contentPublishedMap = contentPublishedMap;
	}

    public Long getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

	public Map<String, List<String>> getOldNodeAttachementValues() {
		return oldNodeAttachementValues;
	}

	public void setOldNodeAttachementValues(
			Map<String, List<String>> oldNodeAttachementValues) {
		this.oldNodeAttachementValues = oldNodeAttachementValues;
	}

	public List<String> getDeletedAttchments() {
		return deletedAttchments;
	}

	public void setDeletedAttchments(List<String> deletedAttchments) {
		this.deletedAttchments = deletedAttchments;
	}

    public Long[] getDepartmentIDs() {
        return departmentIDs;
    }

    public void setDepartmentIDs(Long[] departmentIDs) {
        this.departmentIDs = departmentIDs;
    }
}
