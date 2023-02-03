package com.icerti.ezcerti.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UrlChecker extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object controller) throws Exception 
   	{
		// System.out.println("request.getRequestURI() = " + request.getRequestURI());
		
		// 이상 URL 체크
		String tmpPath = request.getRequestURI();
		int findText = tmpPath.indexOf(".");
		boolean findExceptUrlText = tmpPath.contains("resources");
		
		// System.out.println("findExceptUrlText = " + findExceptUrlText);
		
		if(findText != -1 && !findExceptUrlText) {
			response.sendRedirect("/?error=invalidURL");
			return false;
		}
		
		return true;
   	}
	
}