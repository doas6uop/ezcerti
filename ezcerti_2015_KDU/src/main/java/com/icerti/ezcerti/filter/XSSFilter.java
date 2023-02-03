package com.icerti.ezcerti.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter{

@Override
 public void init(final FilterConfig filterConfig) throws ServletException {
 }

@Override
 public void destroy() {
 }

@Override
 public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain)
 throws IOException, ServletException {

if(excludeUrl((HttpServletRequest)request)) {
 chain.doFilter(request, response);
 } else {
 chain.doFilter( XSSRequestWrapper.newInstance((HttpServletRequest) request), response);
 }
 }

private boolean excludeUrl(final HttpServletRequest request) {
 final String uri = request.getRequestURI().toString().trim();
 final String xssExclude = "";
 final String[] xssExclues = org.springframework.util.StringUtils.tokenizeToStringArray(xssExclude, ",; \t\n");
 for (final String exclude : xssExclues) {
 if(uri.endsWith(exclude)) {
 return true;
 }
 }
 return false;
 }

}



