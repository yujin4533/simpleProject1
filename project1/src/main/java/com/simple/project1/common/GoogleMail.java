package com.simple.project1.common;

import java.text.DecimalFormat;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.simple.project1.model.HotelRoomVO;
import com.simple.project1.model.MemberVO;

public class GoogleMail {

	public void sendmail(String recipient, String certificationCode) throws Exception{

    	// 1. 정보를 담기 위한 객체
    	Properties prop = new Properties(); 
    	
    	// 2. SMTP (simple mail transfer protocol) 서버의 계정 설정
   	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
    	prop.put("mail.smtp.user", "ollehJeju@gallehJeju.com");
        	
    	
    	// 3. SMTP 서버 정보 설정
    	//    Google Gmail 인 경우  smtp.gmail.com
    	prop.put("mail.smtp.host", "smtp.gmail.com");
         	
    	
    	prop.put("mail.smtp.port", "465");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.smtp.debug", "true");
    	prop.put("mail.smtp.socketFactory.port", "465");
    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	prop.put("mail.smtp.socketFactory.fallback", "false");
    	
    	prop.put("mail.smtp.ssl.enable", "true");
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      	
    	
    	Authenticator smtpAuth = new MySMTPAuthenticator();
    	Session ses = Session.getInstance(prop, smtpAuth);
    		
    	// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
    	ses.setDebug(true);
    	        
    	// 메일의 내용을 담기 위한 객체생성
    	MimeMessage msg = new MimeMessage(ses);

    	// 제목 설정
    	String subject = "ollehJeju에서 회원님의 비밀번호를 찾기위한 인증코드 발송";
    	msg.setSubject(subject);
    	        
    	// 보내는 사람의 메일주소
    	String sender = "ollehJeju@gallehJeju.com";
    	Address fromAddr = new InternetAddress(sender);
    	msg.setFrom(fromAddr);
    	        
    	// 받는 사람의 메일주소
    	Address toAddr = new InternetAddress(recipient);
    	msg.addRecipient(Message.RecipientType.TO, toAddr);
    	        
    	// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
    	msg.setContent("인증코드 : <span style='font-size:14pt; color:#ffaa34;'>"+certificationCode+"</span>", "text/html;charset=UTF-8");
    	        
    	// 메일 발송하기
    	Transport.send(msg);
	}
	
	public void sendmailReserve(MemberVO loginuser, HotelRoomVO reserveVO) throws Exception{
		DecimalFormat formatter = new DecimalFormat("###,###");
		
    	Properties prop = new Properties(); 
    	
    	prop.put("mail.smtp.user", "ollehJeju@gallehJeju.com");
    	prop.put("mail.smtp.host", "smtp.gmail.com");
    	prop.put("mail.smtp.port", "465");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.smtp.debug", "true");
    	prop.put("mail.smtp.socketFactory.port", "465");
    	prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	prop.put("mail.smtp.socketFactory.fallback", "false");
    	
    	prop.put("mail.smtp.ssl.enable", "true");
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      	
    	
    	Authenticator smtpAuth = new MySMTPAuthenticator();
    	Session ses = Session.getInstance(prop, smtpAuth);
    		
    	ses.setDebug(true);
    	        
    	MimeMessage msg = new MimeMessage(ses);

    	String subject = "ollehJeju 에서 회원님의 숙소 예약내역 입니다.";
    	msg.setSubject(subject);
    	        
    	String sender = "ollehJeju@gallehJeju.com";
    	Address fromAddr = new InternetAddress(sender);
    	msg.setFrom(fromAddr);
    	        
    	Address toAddr = new InternetAddress(loginuser.getEmail());
    	msg.addRecipient(Message.RecipientType.TO, toAddr);
    	
    	String htmlContent = "<h2>"+loginuser.getMemberName()+" 님의 숙박예약 내역입니다.</h2><table style='border-collapse: collapse;'><tr>";
    //	htmlContent += "<td colspan='2' style='border: 1px solid gray; width: 100%; font-weight: bold; padding: 0 30px;'><img src='/god/resources/images/hotel/"+img+"' width='100%;'></td><tr>"
    	htmlContent += "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>숙박명</td>" 
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+reserveVO.getHotelName()+"</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>주소</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+reserveVO.getAddress()+"</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>체크인-체크아웃</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+reserveVO.getCheckin_date()+"-"+reserveVO.getCheckout_date()+"</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>룸타입/객실정원</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+reserveVO.getRoomName()+"/"+reserveVO.getRoomType().substring(2)+"(명)</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>1개 객실(세금미포함)</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+formatter.format(reserveVO.getWeekPrice())+" 원</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>세금&amp;서비스금액</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+formatter.format(reserveVO.getWeekendPrice())+" 원</td></tr><tr>"
    				 + "<td style='border: 1px solid gray; width: 40%; background-color: #ddd; font-weight: bold; padding: 0 30px;'>총 금액</td>"
    				 + "<td style='border: 1px solid gray; width: 60%; height: 50px; text-align: center;'>"+formatter.format(reserveVO.getWeekPrice()+reserveVO.getWeekendPrice())+" 원</td></tr>"
    				 + "</table>";
    	msg.setContent(htmlContent, "text/html;charset=UTF-8");
    	        
    	Transport.send(msg);
    	
    }// end of sendmailReserve(String recipient, String certificationCode)-----------------
	     

}
