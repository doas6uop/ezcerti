package com.icerti.ezcerti.admin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.admin.dao.AdminAttendeeMapper;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;


@Transactional
@Service
public class AdminAttendeeServiceImpl implements AdminAttendeeService{
	
	@Autowired
	private AdminAttendeeMapper adminAttendeeMapper = null;

	@Override
	public PageBean<Student> getAttendeeList(Map<String, Object> map) {
		PageBean<Student> pageBean = new PageBean<Student>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminAttendeeMapper.getAttendeeListCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminAttendeeMapper.getAttendeeList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public PageBean<Lecture> getLectureList(Map<String, Object> map) {
		PageBean<Lecture> pageBean = new PageBean<Lecture>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminAttendeeMapper.getLectureListCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminAttendeeMapper.getLectureList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public Lecture getLecture(Map<String, Object> map) {
		return adminAttendeeMapper.getLecture(map);
	}

	@Override
	public Attendmaster getAttendMaster(Map<String, Object> map) {
		return adminAttendeeMapper.getAttendMaster(map);
	}

	@Override
	public Map<String, Object> getAttendeeListStatus(Map<String, Object> map) {
		return adminAttendeeMapper.getAttendeeListStatus(map);
	}


}
