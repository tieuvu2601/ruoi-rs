package com.banvien.portal.vms.util;


import org.apache.commons.lang.StringUtils;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class MailUtil {
	/**
	 * load email config for emailsender 
	 * @param mailSender
	 * @param mailType
	 * @return defaultFrom
	 */
	 public static String loadMailConfig(MailSender mailSender) {
	    	JavaMailSenderImpl javaMailSender = (JavaMailSenderImpl) mailSender;
	    	String host, username, password, defaultFrom;
	    	host = username = password  = defaultFrom = null;
	    	Integer port = null;
	    	Boolean isSsl = Boolean.FALSE;
	    	host = MailConfig.getInstance().getProperty("mail.host");
			try {
				port = Integer.valueOf(MailConfig.getInstance().getProperty("mail.port"));
			}catch (NumberFormatException e) {
				//ignore
			}
			isSsl = Boolean.valueOf(MailConfig.getInstance().getProperty("mail.smtp.ssl.enable"));
	    	if(StringUtils.isBlank(defaultFrom)) {
	    		defaultFrom = MailConfig.getInstance().getProperty("mail.default.from");
	    	}
	    	if(StringUtils.isNotBlank(host)) {
	    		javaMailSender.setHost(host);
	    	}
	    	if(port != null) {
	    		javaMailSender.setPort(port);
	    	}
	    	if(StringUtils.isNotBlank(username)) {
	    		javaMailSender.setUsername(username);
	    	}
	    	if(StringUtils.isNotBlank(password)) {
	    		javaMailSender.setPassword(password);
	    	}
	    	if(!isSsl) {
	    		javaMailSender.getJavaMailProperties().remove("mail.smtp.socketFactory.class");
	    	}
	    	return defaultFrom;
	 }
	 public static String getDefaultFrom() {
		return MailConfig.getInstance().getProperty("mail.default.from"); 
	 }
}
