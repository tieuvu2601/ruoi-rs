package com.banvien.portal.vms.bean;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.banvien.portal.vms.domain.ContentEntity;
import com.banvien.portal.vms.xml.contentitem.ContentItem;

public class ContentBean extends AbstractBean<ContentEntity> {
    private FileItem thumbnailFile;

    private Long authoringTemplateId;

    private Timestamp fromDate;

    private Timestamp toDate;

    private ContentItem contentItem;

    private Long categoryId;

    private Map<Long, Boolean> contentPublishedMap;
    
    private Map<String, List<String>> oldNodeAttachementValues;
    
    private List<String> deletedAttchments;

    public ContentBean(){
        this.pojo = new ContentEntity();
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

    public Long getAuthoringTemplateId() {
        return authoringTemplateId;
    }

    public void setAuthoringTemplateId(Long authoringTemplateId) {
        this.authoringTemplateId = authoringTemplateId;
    }

    public ContentItem getContentItem() {
        return contentItem;
    }

    public void setContentItem(ContentItem contentItem) {
        this.contentItem = contentItem;
    }

	public Map<Long, Boolean> getContentPublishedMap() {
		return contentPublishedMap;
	}

	public void setContentPublishedMap(Map<Long, Boolean> contentPublishedMap) {
		this.contentPublishedMap = contentPublishedMap;
	}

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
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
}
