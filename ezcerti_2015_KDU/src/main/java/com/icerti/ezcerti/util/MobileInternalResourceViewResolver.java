package com.icerti.ezcerti.util;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.view.AbstractUrlBasedView;
import org.springframework.web.servlet.view.InternalResourceView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;



/**
 * mobile device에서 접속했을때 viewName 앞에 /m/을 붙여줌
 *
 */
public class MobileInternalResourceViewResolver extends InternalResourceViewResolver {

	private Logger logger = LoggerFactory.getLogger(MobileInternalResourceViewResolver.class);




	@Override

	protected AbstractUrlBasedView buildView(String viewName) throws Exception {

		Device device = DeviceUtils.getCurrentDevice(RequestContextHolder.currentRequestAttributes());
		
		if (device.isMobile()) {

			viewName = getMobileViewName(viewName);

		} 
		
//		viewName = getMobileViewName(viewName); // TODO 삭제해야 함.
		
		logger.debug("ViewName : {}", viewName);

		return (InternalResourceView) super.buildView(viewName);

	}




	private String getMobileViewName(String viewName) {
	  if(viewName.contains("admin/")){
	    return viewName;
	  }
	  
	  if(viewName.contains("gateway")){
	    return viewName;
	  }
	  
	  return "/m/" + viewName;

	}




	@Override

	protected Object getCacheKey(String viewName, Locale locale) {

		Device device = DeviceUtils.getCurrentDevice(RequestContextHolder.currentRequestAttributes());

		if (device.isMobile()) {

			return super.getCacheKey(getMobileViewName(viewName), locale);

		} else {

			return super.getCacheKey(viewName, locale);

		}

	}

}
