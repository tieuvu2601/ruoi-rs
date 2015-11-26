package com.banvien.portal.vms.bean;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.banvien.portal.vms.domain.Content;
import com.banvien.portal.vms.xml.contentitem.ContentItem;

public class ContentBean extends AbstractBean<Content> {
    private FileItem thumbnailFile;

    private Long authoringTemplateId;

    private Timestamp fromDate;

    private Timestamp toDate;

    private ContentItem contentItem;

    private Map<String, List<String>> oldNodeAttachementValues;
    
    private List<String> deletedAttchments;

    public FileItem getThumbnailFile() {
        return thumbnailFile;
    }

    public void setThumbnailFile(FileItem thumbnailFile) {
        this.thumbnailFile = thumbnailFile;
    }

    public Long getAuthoringTemplateId() {
        return authoringTemplateId;
    }

    public void setAuthoringTemplateId(Long authoringTemplateId) {
        this.authoringTemplateId = authoringTemplateId;
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

    public ContentItem getContentItem() {
        return contentItem;
    }

    public void setContentItem(ContentItem contentItem) {
        this.contentItem = contentItem;
    }

    public Map<String, List<String>> getOldNodeAttachementValues() {
        return oldNodeAttachementValues;
    }

    public void setOldNodeAttachementValues(Map<String, List<String>> oldNodeAttachementValues) {
        this.oldNodeAttachementValues = oldNodeAttachementValues;
    }

    public List<String> getDeletedAttchments() {
        return deletedAttchments;
    }

    public void setDeletedAttchments(List<String> deletedAttchments) {
        this.deletedAttchments = deletedAttchments;
    }
}
