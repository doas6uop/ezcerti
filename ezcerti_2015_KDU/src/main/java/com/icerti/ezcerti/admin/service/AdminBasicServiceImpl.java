package com.icerti.ezcerti.admin.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.icerti.ezcerti.admin.dao.AdminBasicMapper;
import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Subject;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Transactional
@Service
public class AdminBasicServiceImpl implements AdminBasicService {
	
	@Autowired
	private AdminBasicMapper adminBasicMapper = null;

	@Override
	@Transactional(readOnly = true)
	public Univ getUnivInfo(Univ univ) {
		univ = adminBasicMapper.getUnivInfo(univ);
		
		return univ;
		
	}

	@Override
	public PageBean<Coll> getCollInfo(Map<String, Object> map) {
		PageBean<Coll> pageBean = new PageBean<Coll>();

		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminBasicMapper.getCollInfoCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminBasicMapper.getCollInfo(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public PageBean<Dept> getDeptInfo(Map<String, Object> map) {
		PageBean<Dept> pageBean = new PageBean<Dept>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminBasicMapper.getDeptInfoCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminBasicMapper.getDeptInfo(map));
		
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public PageBean<Subject> getSubjectInfo(Map<String, Object> map) {
		PageBean<Subject> pageBean = new PageBean<Subject>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminBasicMapper.getSubjectInfoCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminBasicMapper.getSubjectInfo(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		
		return pageBean;
	}

	@Override
	public PageBean<Classday> getClassdayInfo(Map<String, Object> map) {
		PageBean<Classday> pageBean = new PageBean<Classday>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = adminBasicMapper.getClassdayInfoCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminBasicMapper.getClassdayInfo(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public Collection<Classhour> getClasshourInfo(Classhour classhour) {
		return adminBasicMapper.getClasshourInfo(classhour);
	}

	@Override
	public boolean getTermEnd(Univ univ) {
		univ = adminBasicMapper.getTermEnd(univ);
		
		if(univ != null){
			return true;
		}
		
		return false;
	}

	@Transactional
	@Override
	public boolean updateUnivTerm(Univ univ){
		try{
			adminBasicMapper.updateUnivTerm(univ);
			adminBasicMapper.updateProfTerm(univ);
		}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
}