package com.icerti.ezcerti.util;
public class PageUtil {
	public static int getStartRow(int currentPage, int cntPerPage){
		return getEndRow(currentPage, cntPerPage) - cntPerPage + 1;
	}
	public static int getEndRow(int currentPage, int cntPerPage) {
		return currentPage * cntPerPage;
	}
	public static int getStartPage(int currentPage, 
			                       int cntPerPageGroup){
		return getEndPage(currentPage, cntPerPageGroup)-cntPerPageGroup+1;
	}
	public static int getEndPage(int currentPage, 
			                     int cntPerPageGroup){
		return cntPerPageGroup * (int)Math.ceil((double)currentPage/cntPerPageGroup);		
	}
}