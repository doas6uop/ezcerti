package com.icerti.ezcerti.util;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.context.request.RequestContextHolder;

import com.icerti.ezcerti.prof.controller.ProfClassController;
public class PageBean<T> {
	/**
	 * 한 페이지에 보여줄 목록 수
	 */
	public static int CNT_PER_PAGE=10;
	/**
	 * 한 페이지에 보여줄 페이지 수
	 */
	public static int CNT_PER_PAGE_GROUP=10;
	private int currentPage;	//현재 페이지
	private int startPage;		//시작 페이지
	private int endPage;		//마지막 페이지
	private int totalPage; 	//전체 페이지
	private int allCnt;		//전체 데이터 수
	private Collection<T>list;	
	
	private static final Logger logger = LoggerFactory.getLogger(PageBean.class);
	
	public PageBean() {
		super();
		
		Device device = DeviceUtils.getCurrentDevice(RequestContextHolder.currentRequestAttributes());
		
		/*
		if(device.isMobile()) {
			CNT_PER_PAGE = 5;
			CNT_PER_PAGE_GROUP = 5;
		}
		*/
		
		logger.info("[PageBean]device.isMobile:["+device.isMobile()+"],CNT_PER_PAGE:["+CNT_PER_PAGE+"],CNT_PER_PAGE_GROUP:["+CNT_PER_PAGE_GROUP+"]");
		//System.out.println("[PageBean]device.isMobile:["+device.isMobile()+"],CNT_PER_PAGE:["+CNT_PER_PAGE+"],CNT_PER_PAGE_GROUP:["+CNT_PER_PAGE_GROUP+"]");
	}
	
	public PageBean(int currentPage, int startPage, int endPage, int totalPage,
			int allCnt, Collection<T> list) {
		super();
		this.currentPage = currentPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.totalPage = totalPage;
		this.allCnt = allCnt;
		this.list = list;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getTotalPage() {
		return totalPage;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	public int getAllCnt() {
		return allCnt;
	}

	public void setAllCnt(int allCnt) {
		this.allCnt = allCnt;
	}

	public Collection<T> getList() {
		return list;
	}
	
	public void setList(Collection<T> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "PageBean [currentPage=" + currentPage + ", startPage="
				+ startPage + ", endPage=" + endPage + ", totalPage="
				+ totalPage + ", allCnt=" + allCnt + ", list=" + list + "]";
	}


}
