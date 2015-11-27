package com.banvien.portal.vms.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sms implements Serializable {

	private Long smsID;
	
	private Content content;

    private Feedback feedback;
	
	private String mobileNumber;
	
	private String smsContent;
	
	private Integer status;
	
	private Timestamp createdDate;
	
	private Timestamp sentDate;

	public Long getSmsID() {
		return smsID;
	}

	public void setSmsID(Long smsID) {
		this.smsID = smsID;
	}

	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getSmsContent() {
		return smsContent;
	}

	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getSentDate() {
		return sentDate;
	}

	public void setSentDate(Timestamp sentDate) {
		this.sentDate = sentDate;
	}

    public Feedback getFeedback() {
        return feedback;
    }

    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }
}
