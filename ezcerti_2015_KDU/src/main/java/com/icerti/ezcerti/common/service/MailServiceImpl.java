package com.icerti.ezcerti.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class MailServiceImpl implements MailService {

	private static final long serialVersionUID = 6049053739135665601L;

@Autowired
  private JavaMailSender mailSender = null;

  @Autowired
  private MessageSource messageSource = null;

  /**
   * setSubject 제목, setTo 수신자, setFrom 발신자, setCc 공동수신자 
   * setText 내용HTML 여부 설정가능
   */
  @Override
  public void sendMail(String subject, String text, String fromUser, String toUser, String[] toCC) {
    MimeMessage message = mailSender.createMimeMessage();

    try {
      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
      if (toCC != null) {
        messageHelper.setCc(toCC);
      }
      messageHelper.setSubject(subject);
      messageHelper.setTo(toUser);
      messageHelper.setFrom(fromUser);
      messageHelper.setText(text, true);
      mailSender.send(message);

    } catch (MessagingException e) {
      e.printStackTrace();
    }
  }
}
