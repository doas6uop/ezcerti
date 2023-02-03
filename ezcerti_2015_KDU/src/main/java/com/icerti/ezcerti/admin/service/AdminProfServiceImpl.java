package com.icerti.ezcerti.admin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.admin.dao.AdminProfMapper;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;


@Transactional
@Service
public class AdminProfServiceImpl implements AdminProfService{
	
	@Autowired
	private AdminProfMapper adminProfMapper = null;

	@Override
	public PageBean<Prof> getProfList(Map<String, Object> map) {
		PageBean<Prof> pageBean = new PageBean<Prof>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminProfMapper.getProfListCount(map);
		
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
		
		pageBean.setList(adminProfMapper.getProfList(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}


}
