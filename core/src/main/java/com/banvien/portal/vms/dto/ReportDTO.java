package com.banvien.portal.vms.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class ReportDTO implements Serializable{
	
	private Long contentID;
	
	private String title;
	
	private String thumbnail;
	
	private Long views;
	
	private Long likes;
	
	private Long comments;
	
	private Timestamp createdDate;
	
	private Timestamp publishedDate;

    private String author;

    private String department;
	
	public Long getContentID() {
		return contentID;
	}

	public void setContentID(Long contentID) {
		this.contentID = contentID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public Long getViews() {
		return views;
	}

	public void setViews(Long views) {
		this.views = views;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Timestamp publishedDate) {
		this.publishedDate = publishedDate;
	}

	public Long getLikes() {
		return likes;
	}

	public void setLikes(Long likes) {
		this.likes = likes;
	}

	public Long getComments() {
		return comments;
	}

	public void setComments(Long comments) {
		this.comments = comments;
	}

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}
