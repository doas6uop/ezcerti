package com.icerti.ezcerti.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class XSSRequestWrapper extends HttpServletRequestWrapper {

  protected final Log logger = LogFactory.getLog(getClass());

//  private final String[] TARGET_ARRAY = {"<", ">", "#", "'", "\""}; // 적용문자
//  private final String[] REPLACE_ARRAY = {"&lt;", "&gt;", "&#35;", "&#39;", "&quot;"}; // 대응문자
  private final String[] TARGET_ARRAY = {"<", ">", "'", "\""}; // 적용문자
  private final String[] REPLACE_ARRAY = {"&lt;", "&gt;", "&#39;", "&quot;"}; // 대응문자

  private XSSRequestWrapper(final HttpServletRequest servletRequest) {
    super(servletRequest);
  }

  static XSSRequestWrapper newInstance(final HttpServletRequest servletRequest) {
    return new XSSRequestWrapper(servletRequest);
  }

  @Override
  public String[] getParameterValues(final String parameter) {
    final String[] values = super.getParameterValues(parameter);
    logger.debug("===== getParameterValues ==");

    if (values == null) {
      return null;
    }

    final int count = values.length;
    final String[] encodedValues = new String[count];

    for (int i = 0; i < count; i++) {
      encodedValues[i] = cleanXSS(values[i]);
    }

    logger.debug("===== getParameterValues encodedValues==");

    return encodedValues;
  }

  @Override
  public String getParameter(final String parameter) {
    final String value = super.getParameter(parameter);
    logger.debug("===== getParameter ==" + value);

    if (value == null) {
      return null;
    }

    return cleanXSS(value);
  }

  @Override
  public String getHeader(final String name) {
    final String value = super.getHeader(name);

    if (value == null) {
      return null;
    }

    return cleanXSS(value);
  }

  private String cleanXSS(String value) {
    // You'll need to remove the spaces from the html entities below
    int cnt = 0;

    for (int i = 0; i < TARGET_ARRAY.length; i++) {
      final int idx = value.indexOf(TARGET_ARRAY[i]);

      if (idx != -1) {
        cnt++;
      }

      value = value.replaceAll(TARGET_ARRAY[i], REPLACE_ARRAY[i]);
    }

    if (cnt > 0) {
      logger.error("cleanXSS==========");
    }

    return value;
  }

}
