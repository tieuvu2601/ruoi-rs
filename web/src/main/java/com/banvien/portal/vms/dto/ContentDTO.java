package com.banvien.portal.vms.dto;

import java.io.Serializable;
import java.util.List;

public class ContentDTO implements Serializable {
    private String title;

    private String brief;

    private String detail;

    private String thumbnailURL;

    private String detailURL;

    private String code;

    private String postDate;

    private String documentURL;

    private List<String> attachmentURLs;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getThumbnailURL() {
        return thumbnailURL;
    }

    public void setThumbnailURL(String thumbnailURL) {
        this.thumbnailURL = thumbnailURL;
    }

    public String getDetailURL() {
        return detailURL;
    }

    public void setDetailURL(String detailURL) {
        this.detailURL = detailURL;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPostDate() {
        return postDate;
    }

    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    public String getDocumentURL() {
        return documentURL;
    }

    public void setDocumentURL(String documentURL) {
        this.documentURL = documentURL;
    }

    public List<String> getAttachmentURLs() {
        return attachmentURLs;
    }

    public void setAttachmentURLs(List<String> attachmentURLs) {
        this.attachmentURLs = attachmentURLs;
    }
}
