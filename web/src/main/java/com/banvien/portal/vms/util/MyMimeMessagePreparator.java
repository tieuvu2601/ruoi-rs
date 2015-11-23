package com.banvien.portal.vms.util;


import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import javax.mail.internet.MimeMessage;
import java.io.Serializable;

public class MyMimeMessagePreparator implements MimeMessagePreparator, Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7379677814610436281L;
	private String[] bccRecipients;
	private String[] recipients;
	private String sender;
	private String subject;
	private String text;
	private String defaultFrom;
	
	 public String[] getBccRecipients() {
		return bccRecipients;
	}

	public void setBccRecipients(String[] bccRecipients) {
		this.bccRecipients = bccRecipients;
	}
	
	public String[] getRecipients() {
		return recipients;
	}

	public void setRecipients(String[] recipients) {
		this.recipients = recipients;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getDefaultFrom() {
		return defaultFrom;
	}

	public void setDefaultFrom(String defaultFrom) {
		this.defaultFrom = defaultFrom;
	}

	public MyMimeMessagePreparator(String sender,
			String subject, String defaultFrom, String text) {
		this.sender = sender;
		this.subject = subject;
		this.defaultFrom = defaultFrom;
		this.text = text;
	}

	public void prepare(MimeMessage mimeMessage) throws Exception {		
         MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
         if(recipients != null && recipients.length > 0) {
        	 message.setTo(recipients);
         }
         if(bccRecipients != null && bccRecipients.length > 0) {
        	 message.setBcc(bccRecipients);
         }
         if(sender != null) {
         	message.setFrom(sender);
         }else if(defaultFrom != null) {
         	message.setFrom(defaultFrom);
         }
         message.setSubject(subject);
         message.setText(text, true);
      }
}
