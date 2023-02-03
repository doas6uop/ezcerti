package com.icerti.ezcerti.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

public class CSPFilter implements Filter {

    public static final String CONTENT_SECURITY_POLICY_HEADER = "Content-Security-Policy";
    public static final String CONTENT_SECURITY_POLICY_REPORT_ONLY_HEADER = "Content-Security-Policy-Report-Only";

    private static final String REPORT_ONLY = "report-only";
    public static final String REPORT_URI = "report-uri";
    public static final String SANDBOX = "sandbox";
    public static final String DEFAULT_SRC = "default-src";
    public static final String IMG_SRC = "img-src";
    public static final String SCRIPT_SRC = "script-src";
    public static final String STYLE_SRC = "style-src";
    public static final String FONT_SRC = "font-src";
    public static final String CONNECT_SRC = "connect-src";
    public static final String OBJECT_SRC = "object-src";
    public static final String MEDIA_SRC = "media-src";
    public static final String CHILD_SRC = "child-src";
    public static final String BASE_URI = "base-uri";
    
    public static final String KEYWORD_NONE = "'none'";
    public static final String KEYWORD_SELF = "'self'";

    private boolean reportOnly;
    private String sandbox;
    private String defaultSrc;
    private String imgSrc;
    private String scriptSrc;
    private String styleSrc;
    private String fontSrc;
    private String connectSrc;
    private String objectSrc;
    private String mediaSrc;
    private String childSrc;
    private String baseUri;

    public void init(FilterConfig filterConfig) {
        reportOnly = getParameterBooleanValue(filterConfig, REPORT_ONLY);
        sandbox = getParameterValue(filterConfig, SANDBOX);
        defaultSrc = getParameterValue(filterConfig, DEFAULT_SRC, KEYWORD_SELF);
        imgSrc = getParameterValue(filterConfig, IMG_SRC);
        scriptSrc = getParameterValue(filterConfig, SCRIPT_SRC);
        styleSrc = getParameterValue(filterConfig, STYLE_SRC);
        fontSrc = getParameterValue(filterConfig, FONT_SRC);
        connectSrc = getParameterValue(filterConfig, CONNECT_SRC);
        objectSrc = getParameterValue(filterConfig, OBJECT_SRC);
        mediaSrc = getParameterValue(filterConfig, MEDIA_SRC);
        childSrc = getParameterValue(filterConfig, CHILD_SRC);
        baseUri = getParameterValue(filterConfig, BASE_URI);
    }

    private String getParameterValue(FilterConfig filterConfig, String paramName, String defaultValue) {
        String value = filterConfig.getInitParameter(paramName);
        return value;
    }

    private String getParameterValue(FilterConfig filterConfig, String paramName) {
        return filterConfig.getInitParameter(paramName);
    }

    private boolean getParameterBooleanValue(FilterConfig filterConfig, String paramName) {
        return "true".equalsIgnoreCase(filterConfig.getInitParameter(paramName));
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String contentSecurityPolicyHeaderName = reportOnly ? CONTENT_SECURITY_POLICY_REPORT_ONLY_HEADER
        		// : CONTENT_SECURITY_POLICY_HEADER;
        		: CONTENT_SECURITY_POLICY_REPORT_ONLY_HEADER;
        String contentSecurityPolicy = getContentSecurityPolicy();

        httpResponse.addHeader(contentSecurityPolicyHeaderName, contentSecurityPolicy);

        chain.doFilter(request, response);
    }

    private String getContentSecurityPolicy() {
        StringBuilder contentSecurityPolicy = new StringBuilder(DEFAULT_SRC).append(" ").append(defaultSrc);

        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, IMG_SRC, imgSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, SCRIPT_SRC, scriptSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, STYLE_SRC, styleSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, FONT_SRC, fontSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, CONNECT_SRC, connectSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, OBJECT_SRC, objectSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, MEDIA_SRC, mediaSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, CHILD_SRC, childSrc);
        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, BASE_URI, baseUri);
//        addDirectiveToContentSecurityPolicy(contentSecurityPolicy, REPORT_URI, reportUri);
        addSandoxDirectiveToContentSecurityPolicy(contentSecurityPolicy, sandbox);

        return contentSecurityPolicy.toString();
    }

    private void addDirectiveToContentSecurityPolicy(StringBuilder contentSecurityPolicy, String directiveName, String value) {
        if (StringUtils.isNotBlank(value) && !defaultSrc.equals(value)) {
            contentSecurityPolicy.append("; ").append(directiveName).append(" ").append(value);
        }
    }

    private void addSandoxDirectiveToContentSecurityPolicy(StringBuilder contentSecurityPolicy, String value) {
        if (StringUtils.isNotBlank(value)) {
            if ("true".equalsIgnoreCase(value)) {
                contentSecurityPolicy.append("; ").append(SANDBOX);
            } else {
                contentSecurityPolicy.append("; ").append(SANDBOX).append(" ").append(value);
            }
        }
    }

    public void destroy() {
    	
    }
    
}