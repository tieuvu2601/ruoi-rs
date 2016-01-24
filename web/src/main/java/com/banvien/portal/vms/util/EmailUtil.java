package com.banvien.portal.vms.util;

import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailUtil {
    public static void sendMailForPeople(List<String> recipients, String subject, String content, final String googleAccount, final String passwordAccount) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(googleAccount, passwordAccount);
            }
        });

        String encodingOptions = "UTF-8";

        try {
            MimeMessage message = new MimeMessage(session);
            message.setHeader("Content-Type", encodingOptions);
            message.setFrom(new javax.mail.internet.InternetAddress(googleAccount));
            InternetAddress[] recipientAddress = new InternetAddress[recipients.size()];
            int counter = 0;
            for (String recipient : recipients) {
                recipientAddress[counter] = new InternetAddress(recipient.trim());
                counter++;
            }
            message.setRecipients(Message.RecipientType.BCC, recipientAddress);

            message.setSubject(subject, "UTF-8");
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent( content, "text/html; charset=utf-8" );

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart( messageBodyPart );
            message.setContent( multipart );
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }


}
