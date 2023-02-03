package com.icerti.ezcerti.admin.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icerti.ezcerti.admin.dao.AdminStatsMapper;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Service
public class AdminStatsServiceImpl implements AdminStatsService{

	@Autowired
	private AdminStatsMapper adminStatsMapper = null;

	@Override
	public PageBean<String> getAdminStatsAttendStatus(Map<String, Object> map) {
		PageBean<String> pageBean = new PageBean<String>();
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminStatsAttendStatusCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		pageBean.setList(adminStatsMapper.getAdminStatsAttendStatus(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}

	@Override
	public Collection<String> getAdminStatsTerm(Map<String, Object> map) {
		return adminStatsMapper.getAdminStatsTerm(map);
	}

	@Override
	public PageBean<String> getAdminStatsStudentStatus(Map<String, Object> map) {
		PageBean<String> pageBean = new PageBean<String>();
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminStatsStudentStatusCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminStatsMapper.getAdminStatsStudentStatus(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}

	@Override
	public PageBean<String> getAdminStatsProf(Map<String, Object> map) {
		PageBean<String> pageBean = new PageBean<String>();
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminStatsProfCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminStatsMapper.getAdminStatsProf(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}

	/*
	 *  학사팀 통계(대전대 - 2015.03.18)
	 */
	@Override
	public PageBean<String> getAdminAcademicStats(Map<String, Object> map) {
		PageBean<String> pageBean = new PageBean<String>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 
		
		int allCnt = adminStatsMapper.getAdminAcademicStatsCount(map);

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminStatsMapper.getAdminAcademicStats(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}
	
	/* 
	 * 학사팀 교수 통계(2015.04.07)
	 */
	@Override
	public Map<String, Object> getLectureDetail(Map<String, Object> map) {
		return adminStatsMapper.getLectureDetail(map);
	}	

	/* 
	 * 학사팀 교수 통계(2015.04.07)
	 */
	@Override
	public int getLectureCount(Map<String, Object> map) {
		return adminStatsMapper.getLectureCount(map);
	}	
	
	/* 
	 * 학사팀 교수 통계(2015.04.07)
	 */
	@Override
	public Collection<String> getAdminAcademicProfClassStats(Map<String, Object> map) {
		return adminStatsMapper.getAdminAcademicProfClassStats(map);
	}	

	/* 
	 * 결강현황(2015.04.16)
	 */
	@Override
	public PageBean<Attendmaster> getAdminCancelClassList(Map<String, Object> map) {
		PageBean<Attendmaster> pageBean = new PageBean<Attendmaster>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminCancelClassListCount(map);
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		pageBean.setList(adminStatsMapper.getAdminCancelClassList(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}
	
	/* 
	 * 결석현황(2015.04.16)
	 */
	@Override
	public PageBean<Student> getAdminAbsenceList(Map<String, Object> map) {
		PageBean<Student> pageBean = new PageBean<Student>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminAbsenceListCount(map);
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		pageBean.setList(adminStatsMapper.getAdminAbsenceList(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}
	
	/* 
	 * 결석현황 엑셀다운로드(20160929)
	 */
	@Override
	public PageBean<Student> getAdminAbsenceListExcel(Map<String, Object> map) {
		PageBean<Student> pageBean = new PageBean<Student>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminStatsMapper.getAdminAbsenceListExcelCount(map);
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		pageBean.setList(adminStatsMapper.getAdminAbsenceListExcel(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}
	
	/*
	 *  교수별 출결 통계(2015.10.29)
	 */
	@Override
	public PageBean<String> getAdminProfUsageStats(Map<String, Object> map) {
		PageBean<String> pageBean = new PageBean<String>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 
		
		int allCnt = adminStatsMapper.getAdminProfUsageStatsCount(map);

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminStatsMapper.getAdminProfUsageStats(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);		
		
		return pageBean;
	}	
	
}
