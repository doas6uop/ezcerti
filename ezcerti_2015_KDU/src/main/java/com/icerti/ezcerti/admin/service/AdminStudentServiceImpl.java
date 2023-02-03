package com.icerti.ezcerti.admin.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.admin.dao.AdminStudentMapper;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;



@Transactional
@Service
public class AdminStudentServiceImpl implements AdminStudentService{
	
	@Autowired
	private AdminStudentMapper adminStudentMapper = null;

	@Override
	public PageBean<Student> getStudentList(Map<String, Object> map) {
		PageBean<Student> pageBean = new PageBean<Student>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

		int allCnt = adminStudentMapper.getStudentListCount(map);

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

		pageBean.setList(adminStudentMapper.getStudentList(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);

		return pageBean;
	}

	@Transactional
	@Override
	public String updateStudentOff(Map<String, Object> map) {
		String msg = "";
		ArrayList<Attenddethist> attenddethist= (ArrayList<Attenddethist>) adminStudentMapper.getStudentAttendList(map);
		try{
			// 2015.01.07 ///////////////////////////////////
			// - tb_attendmaster_addinfo 테이블의 출결상태별 수 변경 처리하는 부분임
			// - 아래 문장 수행 후, 출결상태별 COUNT후 처리하도록 변경하므로 주석 처리
			/*
			for (Attenddethist attenddethist2 : attenddethist) {
				adminStudentMapper.updateStudentOffAttendmaster(attenddethist2);
			}
			*/
			/////////////////////////////////////////////////

			adminStudentMapper.updateStudentOffAttenddethist(map);
			adminStudentMapper.updateStudentOffStatus(map);

			// 2015.01.07 ///////////////////////////////////
			// - 출결상태별 COUNT 후처리
			for (Attenddethist attenddethist2 : attenddethist) {
				adminStudentMapper.updateStudentOffAttendmasterAddInfo(attenddethist2);
			}
			/////////////////////////////////////////////////
			msg = "정상처리되었습니다";
		}catch(Exception e){
			e.printStackTrace();
			msg = "오류가 발생했습니다.";
		}

		return msg;
	}

	@Transactional
	@Override
	public String updateStudentQuit(Map<String, Object> map) {
		String msg = "";
		ArrayList<Attenddethist> attenddethist= (ArrayList<Attenddethist>) adminStudentMapper.getStudentAttendList(map);
		try{
			// 2015.01.07 ///////////////////////////////////
			// - tb_attendmaster_addinfo 테이블의 출결상태별 수 변경 처리하는 부분임
			// - 아래 문장 수행 후, 출결상태별 COUNT후 처리하도록 변경하므로 주석 처리
			/*
			for (Attenddethist attenddethist2 : attenddethist) {
				adminStudentMapper.updateStudentQuitAttendmaster(attenddethist2);
			}
			*/
			/////////////////////////////////////////////////

			adminStudentMapper.updateStudentQuitAttenddethist(map);
			adminStudentMapper.updateStudentQuitStatus(map);

			// 2015.01.07 ///////////////////////////////////
			// - 출결상태별 COUNT 후처리
			for (Attenddethist attenddethist2 : attenddethist) {
				adminStudentMapper.updateStudentOffAttendmasterAddInfo(attenddethist2);
			}
			/////////////////////////////////////////////////		
			msg = "정상처리되었습니다";
		}catch(Exception e){
			e.printStackTrace();
			msg = "오류가 발생했습니다.";
		}

		return msg;
	}

	@Override
	public void initStudentCertCount(String student_no) {
		adminStudentMapper.initStudentCertCount(student_no);
	}

}
