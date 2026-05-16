package com.reservation.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String SENDER_EMAIL = "reservationgrandeats@gmail.com";
    private static final String APP_PASSWORD = "gywumxemayqtlkje";

    // Send email method (Common)
    private void sendEmail(String toEmail, String subject, String htmlContent) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "GrandEats Team"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✅ Email successfully sent to: " + toEmail);

        }
        catch (Exception e) {
            System.err.println("❌ Error sending email to: " + toEmail);
            e.printStackTrace();
        }
    }
}