package com.icerti.ezcerti.util;

import java.security.MessageDigest;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Service
public class CommonUtil {
	
	@Value("#{config['univ_code']}")
	String globalUnivCode;
	
	public static String randomPassword(int length) {
		Random random = new Random();
		// String str = "";
		StringBuffer str = new StringBuffer();

		for (int i = 0; i < length; i++) {
			if (random.nextBoolean()) {
				// str = str + String.valueOf((char)((int)(random.nextInt(26))+97)).toUpperCase();
				if (random.nextBoolean()) {
					str.append(String.valueOf((char) ((int) (random.nextInt(26)) + 65)));
				}else{
					str.append(String.valueOf((char) ((int) (random.nextInt(26)) + 97)));
				}
			} else {
				// str = str + random.nextInt(length);
				str.append((random.nextInt(10)));
			}
		}
		System.out.println(str);

		String password = str.toString();

		return password;
	}

	public static String getMD5String(String input) {
		StringBuffer sb = new StringBuffer();
		String result = "";

		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(input.getBytes());
			byte[] md5Bytes = md5.digest();

			for(int i = 0 ; i < md5Bytes.length ; i++){
				String md5Char = String.format("%02x", 0xff&(char)md5Bytes[i]); 
				sb.append(md5Char);
			}

			result = sb.toString();
		} catch (Exception e) {

		}

		return result;
	}
	
	public static String SHA256Encryptor(String str) {
		
		String SHA = null;
		
		try {
			
			java.security.MessageDigest sh = java.security.MessageDigest.getInstance("SHA-256");
			
			sh.update(str.getBytes());
			
			byte byteData[] = sh.digest();
			
			StringBuffer sb = new StringBuffer();
			
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				//sb.append(Integer.toString((byteData[i] & 0xff) + 256, 16).substring(1));
				
				/*
				2^4  = 16B   = b0001 0000 = 0x10
				2^5  = 32B   = b0010 0000 = 0x20
				2^6  = 64B   = b0100 0000 = 0x40
				2^7  = 128B  = 0x80
				2^8  = 256B  = b0001 0000 0000 = 0x100
				2^10 = 1KB   = b0100 0000 0000 = 0x400
				2^20 = 1MB   = b0001 0000 0000 0000 0000 0000 = 0x100000
				2^30 = 1GB   = 0x40000000
				2^40 = 1TB   = 0X10000000000
				4KB  = 0x1000 
				64KB = 0x10000 
				1MB  = 0x100000
				*/				
			}
			
			SHA = sb.toString();


			//System.out.println("SHA Key Value : " + SHA + " , Length : " + SHA.length());

		} catch (java.security.NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = "Exception : " + e.getMessage();
		}
		
		return SHA;
	}
	
	public static String getIpAddr() {
		String ip = "";

		try {
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();        
			
			ip = req.getHeader("X-Forwarded-For");  
			
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = req.getHeader("Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = req.getHeader("WL-Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = req.getHeader("HTTP_CLIENT_IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = req.getHeader("HTTP_X_FORWARDED_FOR");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = req.getRemoteAddr();  
	        }  			
		} catch (Exception e) {
		}

		return ip;
	}	

	public static String msgProc(String msg) {
		String retMsg = "";
		
		if(msg != null && msg.length() > 0) {
			if(msg.equalsIgnoreCase("PROC_SUCCESS")) {
				retMsg = "정상 처리되었습니다.";				
			} else if(msg.equalsIgnoreCase("NO_REQUEST")) {
				retMsg = "신청정보가 없습니다.";
			} else if(msg.equalsIgnoreCase("ERROR")) {
				retMsg = "오류가  발생했습니다.";
			}
		}
		
		return retMsg;
	}	

	public int getCntPerPage() {

		int temPage = 0;

		/* 세션 생성 */
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session = req.getSession();
		String user_type = (String) session.getAttribute("USER_TYPE");

		/* 관린자 화면에서만 50개 제한 */
		if (user_type != null && (user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]"))) {

			if (globalUnivCode.equals("53028000")) {
				temPage = 50;
			} else if (globalUnivCode.equals("G001C002")) {
				temPage = 20;
			} else {
				temPage = PageBean.CNT_PER_PAGE;
			}
		} else if (globalUnivCode.equals("G001C002")) {
			temPage = 20;
		} else {
			temPage = PageBean.CNT_PER_PAGE;
		}

		return temPage;
	}
}
