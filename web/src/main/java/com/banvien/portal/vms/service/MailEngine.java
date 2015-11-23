package com.banvien.portal.vms.service;


import com.banvien.portal.vms.exception.SendEmailException;
import com.banvien.portal.vms.util.MailUtil;
import com.banvien.portal.vms.util.MyMimeMessagePreparator;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.ui.velocity.VelocityEngineUtils;

import javax.mail.MessagingException;
import java.util.Map;

/**
 * Class for sending e-mail messages based on Velocity templates
 * or with attachments.
 * 
 */
public class MailEngine {
    private final Log log = LogFactory.getLog(MailEngine.class);
    private VelocityEngine velocityEngine;
    private String defaultFrom;
    private MailSender emailSender;
    
    public void setVelocityEngine(VelocityEngine velocityEngine) {
        this.velocityEngine = velocityEngine;
    }

    public void setFrom(String from) {
        this.defaultFrom = from;
    }

	public void setEmailSender(MailSender emailSender) {
		this.emailSender = emailSender;
	}

	/**
     * Convenience method for sending messages with attachments.
     * 
     * @param recipients array of e-mail addresses
     * @param sender e-mail address of sender
     * @param resource attachment from classpath
     * @param bodyText text in e-mail
     * @param subject subject of e-mail
     * @param attachmentName name for attachment
     * @throws MessagingException thrown when can't communicate with SMTP server
     */
    public void sendMessage(final String[] recipients, final String sender, final String subject, 
    		final String templateName, final Map model, 
            final ClassPathResource resource, final String attachmentName) 
    throws SendEmailException {
    	
        String text = "";
        try {        	
	          text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, templateName, "UTF-8", model);
        } catch (Exception e) {
      	  log.error(e.getMessage(), e);
        }
		MyMimeMessagePreparator preparator = new MyMimeMessagePreparator(sender, subject, defaultFrom, text);
		preparator.setRecipients(recipients);
		try {
			doSendMail(preparator);
		}catch (MailException e) {
			throw new SendEmailException(e.getMessage(), e, text);
		}
    }
    
    //send message with bccrecipients 
    public void sendMessage(final String[] recipients, final String[] bccRecipients, final String sender, final String subject, 
    		final String templateName, final Map model, 
            final ClassPathResource resource, final String attachmentName) 
    throws SendEmailException {
    	
        String text = "";
        try {        	
	          text = VelocityEngineUtils.mergeTemplateIntoString(
	                  velocityEngine, templateName, model);
        } catch (Exception e) {
        	log.error(e.getMessage(), e);
        }
		MyMimeMessagePreparator preparator = new MyMimeMessagePreparator(sender, subject, defaultFrom, text);
		preparator.setRecipients(recipients);
		preparator.setBccRecipients(bccRecipients);
		try {
			doSendMail(preparator);
		}catch (MailException e) {
			throw new SendEmailException(e.getMessage(), e, text);
		}
    }
    public void sendMessage(final String[] recipients, final String[] bccRecipients, final String sender, final String subject, String content) throws MailException { 
		MyMimeMessagePreparator preparator = new MyMimeMessagePreparator(sender, subject, defaultFrom, content);
		preparator.setRecipients(recipients);
		preparator.setBccRecipients(bccRecipients);
		doSendMail(preparator);
    }
    
    /**
     * Convenience method for sending messages in BCC with attachments.
     * 
     * @param bccRecipients array of e-mail addresses
     * @param sender e-mail address of sender
     * @param bodyText text in e-mail
     * @param subject subject of e-mail
     * @throws MessagingException thrown when can't communicate with SMTP server
     */
    public void sendMessageBCC(final String[] bccRecipients, final String sender, final String subject, 
    		final String templateName, final Map model) 
    throws MessagingException, MailException {
          String text = "";
          try {
	          text = VelocityEngineUtils.mergeTemplateIntoString(
	                  velocityEngine, templateName, model);
          } catch (Exception e) {
        	  log.error(e.getMessage(), e);
          }
        MyMimeMessagePreparator preparator = new MyMimeMessagePreparator(sender, subject, defaultFrom, text);
        preparator.setBccRecipients(bccRecipients);
    	doSendMail(preparator);
    }
    private void doSendMail(MyMimeMessagePreparator myPre) throws MailException{
		JavaMailSenderImpl javaMailSender = (JavaMailSenderImpl) emailSender;
		String defaultFrom = MailUtil.getDefaultFrom();
		if(StringUtils.isNotBlank(myPre.getSender())) {
			defaultFrom = myPre.getSender();				
		} else if(StringUtils.isNotBlank(defaultFrom)) {
			myPre.setSender(defaultFrom);
		}
		javaMailSender.send(myPre);
    }
}
