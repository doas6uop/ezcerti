package com.icerti.ezcerti.prof.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.prof.dao.ProfAttendeeMapper;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;


@Transactional
@Service
public class ProfAttendeeServiceImpl implements ProfAttendeeService{
	
	@Autowired
	private ProfAttendeeMapper profAttendeeMapper = null;

  @Override
  public PageBean<Student> getProfAttendeeList(Map<String, Object> map) {
    PageBean<Student> pageBean = new PageBean<Student>();
    
    Integer currentPage = (Integer) map.get("currentPage");
    map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
    map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
    
    int allCnt = profAttendeeMapper.getProfAttendeeListCount(map);
    
    int cntPerPage = PageBean.CNT_PER_PAGE;
    int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
    if(endPage > totalPage){
        endPage = totalPage;
    }
    
    pageBean.setList(profAttendeeMapper.getAttendeeList(map));
    
    pageBean.setAllCnt(allCnt);
    pageBean.setStartPage(startPage);
    pageBean.setEndPage(endPage);
    pageBean.setTotalPage(totalPage);
    pageBean.setCurrentPage(currentPage);
    
    
    return pageBean;
  }

  @Override
  public Collection<Attenddethist> getAttendDetailList(Map<String, Object> map) {
    return profAttendeeMapper.getAttendDetailList(map);
  }

  @Override
  public Lecture getLectureDetail(Map<String, Object> map) {
    return profAttendeeMapper.getLectureDetail(map);
  }



}
