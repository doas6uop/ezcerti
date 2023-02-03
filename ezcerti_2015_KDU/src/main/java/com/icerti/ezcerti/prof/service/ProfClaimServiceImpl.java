package com.icerti.ezcerti.prof.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.prof.dao.ProfClaimMapper;
import com.icerti.ezcerti.prof.dao.ProfClassMapper;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;


@Transactional
@Service
public class ProfClaimServiceImpl implements ProfClaimService {

  @Autowired
  private ProfClaimMapper profClaimMapper = null;
  
  @Autowired
  private ProfClassMapper profClassMapper = null;

  @Override
  public PageBean<Claim> getProfClaimList(Map<String, Object> map) {
    PageBean<Claim> pageBean = new PageBean<Claim>();

    Integer currentPage = (Integer) map.get("currentPage");
    map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
    map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

    int allCnt = profClaimMapper.getProfClaimListCount(map);

    int cntPerPage = PageBean.CNT_PER_PAGE;
    int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int totalPage = (int) Math.ceil((double) allCnt / cntPerPage);
    if (endPage > totalPage) {
      endPage = totalPage;
    }

    pageBean.setList(profClaimMapper.getProfClaimList(map));

    pageBean.setAllCnt(allCnt);
    pageBean.setStartPage(startPage);
    pageBean.setEndPage(endPage);
    pageBean.setTotalPage(totalPage);
    pageBean.setCurrentPage(currentPage);

    return pageBean;
  }
  
  @Override
  public PageBean<Claim> getProfImproveList(Map<String, Object> map) {
    PageBean<Claim> pageBean = new PageBean<Claim>();

    Integer currentPage = (Integer) map.get("currentPage");
    map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
    map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

    int allCnt = profClaimMapper.getProfImproveListCount(map);

    int cntPerPage = PageBean.CNT_PER_PAGE;
    int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
    int totalPage = (int) Math.ceil((double) allCnt / cntPerPage);
    if (endPage > totalPage) {
      endPage = totalPage;
    }

    pageBean.setList(profClaimMapper.getProfImproveList(map));

    pageBean.setAllCnt(allCnt);
    pageBean.setStartPage(startPage);
    pageBean.setEndPage(endPage);
    pageBean.setTotalPage(totalPage);
    pageBean.setCurrentPage(currentPage);

    return pageBean;
  }

  @Override
  public Claim getProfClaimView(Claim claim) {
    return profClaimMapper.getProfClaimView(claim);
  }
  
  @Override
  public Claim getProfImproveView(Claim claim) {
    return profClaimMapper.getProfImproveView(claim);
  }

  @Override
  public String getClassInfoFlag(Map<String, Object> map) {
    return profClaimMapper.getClassInfoFlag(map);
  }
  
  @Transactional
  @Override
  public String claimConfirm(Attendmaster attendmaster, Attenddethist attendStudent, Claim claim, String resClassFlag) {
    
	String msg = "";

    try {
        	profClaimMapper.updateProfClaim(claim);
        	
        	if(resClassFlag.equals("Y")) {
        		
        		int attend_present_cnt = 0;
        		int attend_late_cnt = 0;
        		int attend_absent_cnt = 0;


        		if(attendStudent.getAttend_sts_cd().equals("G023C002")){
        		  attend_present_cnt--;
        		}else if(attendStudent.getAttend_sts_cd().equals("G023C003")){
        		  attend_late_cnt--;
        		}else if(attendStudent.getAttend_sts_cd().equals("G023C004")){
        		  attend_absent_cnt--;
        		}
        		if(claim.getReply_claim_cd().equals("G023C002")){
        		  attend_present_cnt++;
        		}else if(claim.getReply_claim_cd().equals("G023C003")){
        		  attend_late_cnt++;
        		}else if(claim.getReply_claim_cd().equals("G023C004")){
        		  attend_absent_cnt++;
        		}

        		attendmaster.setAttend_present_cnt(attend_present_cnt);
        		attendmaster.setAttend_late_cnt(attend_late_cnt);
        		attendmaster.setAttend_absent_cnt(attend_absent_cnt);
        		attendStudent.setAttend_sts_cd(claim.getReply_claim_cd());
        		
        		profClassMapper.updateProfAttendAuthorityAttenddethist(attendStudent);
        	      
        	    // 2015.01.05 ///////////////////////
        	    // - 출결상태별 수강생 수는 별도로 조회하도록 변경
        	    Attendmaster attendmasterAttendCnt = profClassMapper.getProfClassAttendCnt(attendStudent);
        	      
        	    if(attendmasterAttendCnt != null) {
        	      	attendmaster.setAttend_present_cnt(attendmasterAttendCnt.getAttend_present_cnt());
        	      	attendmaster.setAttend_late_cnt(attendmasterAttendCnt.getAttend_late_cnt());
        	      	attendmaster.setAttend_absent_cnt(attendmasterAttendCnt.getAttend_absent_cnt());
        	      	attendmaster.setAttend_off_cnt(attendmasterAttendCnt.getAttend_off_cnt());
        	      	attendmaster.setAttend_quit_cnt(attendmasterAttendCnt.getAttend_quit_cnt());
        	    }
        	    /////////////////////////////////////
        	      
        	    profClassMapper.updateProfAttendAuthorityAttendmaster(attendmaster);
        	}
      
      msg = "처리되었습니다.";
    } catch (Exception e) {
      msg = "오류가 발생했습니다.";
      e.printStackTrace();
    }
    
    return msg;
  }


}
