package com.icerti.ezcerti.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

/**
 * ajax 통신시 session 체크 Filter
 * @author Administrator
 *
 */
public class AjaxSessionTimeoutFilter implements Filter{

  @Override
  public void init(FilterConfig filterConfig) throws ServletException {
    // TODO Auto-generated method stub
    
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        if (isAjaxRequest(req)) {
            try {
                   chain.doFilter(req, res);
            } catch (AccessDeniedException e) {
                   res.sendError(HttpServletResponse.SC_FORBIDDEN);
            } catch (AuthenticationException e) {
                   res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            }
        } else {
          chain.doFilter(req, res);
        }
  }
  private boolean isAjaxRequest(HttpServletRequest req) {
          return req.getHeader("AJAX") != null && req.getHeader("AJAX").equals(Boolean.TRUE.toString());
  }

  @Override
  public void destroy() {
    // TODO Auto-generated method stub
    
  }

}
