package com.icerti.ezcerti.student.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.student.dao.StudentClaimMapper;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Service
public class StudentClaimServiceImpl implements StudentClaimService {
  
  @Autowired
  private StudentClaimMapper studentClaimMapper = null;

  @Override
  public PageBean<Claim> getStudentClaimList(Map<String, Object> map) {
    PageBean<Claim> pageBean = new PageBean<Claim>();

    Integer currentPage = (Integer) map.get("currentPage");
    map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
    map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

    int allCnt = studentClaimMapper.getStudentClaimListCount(map);

    int cntPerPage = PageBean.CNT_PER_PAGE;
    int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int totalPage = (int) Math.ceil((double) allCnt / cntPerPage);
    if (endPage > totalPage) {
      endPage = totalPage;
    }

    pageBean.setList(studentClaimMapper.getStudentClaimList(map));

    pageBean.setAllCnt(allCnt);
    pageBean.setStartPage(startPage);
    pageBean.setEndPage(endPage);
    pageBean.setTotalPage(totalPage);
    pageBean.setCurrentPage(currentPage);

    return pageBean;
  }

  @Override
  public Claim getStudentClaimView(Claim claim) {
    return studentClaimMapper.getStudentClaimView(claim);
  }

  @Override
  public PageBean<Claim> getStudentImproveList(Map<String, Object> map) {
    PageBean<Claim> pageBean = new PageBean<Claim>();

    Integer currentPage = (Integer) map.get("currentPage");
    map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
    map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

    int allCnt = studentClaimMapper.getStudentImproveListCount(map);

    int cntPerPage = PageBean.CNT_PER_PAGE;
    int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int totalPage = (int) Math.ceil((double) allCnt / cntPerPage);
    if (endPage > totalPage) {
      endPage = totalPage;
    }

    pageBean.setList(studentClaimMapper.getStudentImproveList(map));

    pageBean.setAllCnt(allCnt);
    pageBean.setStartPage(startPage);
    pageBean.setEndPage(endPage);
    pageBean.setTotalPage(totalPage);
    pageBean.setCurrentPage(currentPage);

    return pageBean;
  }
  
  @Override
  public Claim getStudentImproveView(Claim claim) {
    return studentClaimMapper.getStudentImproveView(claim);
  }
  
}
