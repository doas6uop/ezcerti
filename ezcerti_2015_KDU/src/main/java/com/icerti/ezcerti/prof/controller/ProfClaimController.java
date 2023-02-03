package com.icerti.ezcerti.prof.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.prof.service.ProfClaimService;
import com.icerti.ezcerti.util.CommonUtil;

@Controller
@RequestMapping({"/prof/claim", "/m/prof/claim"})
public class ProfClaimController {

  @Autowired
  private ProfClaimService profClaimService = null;
  
  @Autowired
  private CommonService commonService = null;


  @RequestMapping(value = "/claim_list", method = RequestMethod.GET)
  public String profClaimList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
		  						@RequestParam(value = "curr_year", defaultValue = "") String year,
								@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
                                @RequestParam(value = "claim_sts_cd", defaultValue = "") String claim_sts_cd,
                                @RequestParam(value = "class_cd", defaultValue = "") String class_cd,
                                Model model, HttpSession session){
    Map<String, Object> map = new HashMap<String, Object>();
    String univ_cd = session.getAttribute("UNIV_CD").toString();
    map.put("prof_no", session.getAttribute("PROF_NO"));

    if (year.equals("")) {
    	year = session.getAttribute("YEAR").toString();
    }
    
    if (term_cd.equals("")) {
      term_cd = session.getAttribute("TERM_CD").toString();
    }
    
    if (currentPage == null){
      currentPage = 1;
    }

    map.put("univ_cd", univ_cd);
    map.put("year", year);
    map.put("term_cd", term_cd);
    map.put("currentPage", currentPage);
    map.put("class_cd", class_cd);
    map.put("claim_sts_cd", claim_sts_cd);
    
    model.addAttribute("claimCodeList", commonService.getCode("G028"));
    model.addAttribute("termList", commonService.getProfTermList(map));
    model.addAttribute("pageBean", profClaimService.getProfClaimList(map));
    
    model.addAttribute("year", year);
    model.addAttribute("term_cd", term_cd);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("claim_sts_cd", claim_sts_cd);
    
    return "prof/claim/claim_list";
  }
  
  @RequestMapping(value = "/improve_list", method = RequestMethod.GET)
  public String profImproveList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                @RequestParam(value = "curr_year", defaultValue = "") String year,
								@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
                                @RequestParam(value = "class_cd", defaultValue = "") String class_cd,
                                Model model, HttpSession session){
    Map<String, Object> map = new HashMap<String, Object>();
    String univ_cd = session.getAttribute("UNIV_CD").toString();
    map.put("prof_no", session.getAttribute("PROF_NO"));

    if (year.equals("")) {
    	year = session.getAttribute("YEAR").toString();
    }
    
    if (term_cd.equals("")) {
      term_cd = session.getAttribute("TERM_CD").toString();
    }
    
    if (currentPage == null){
      currentPage = 1;
    }

    map.put("univ_cd", univ_cd);
    map.put("year", year);
    map.put("term_cd", term_cd);
    map.put("currentPage", currentPage);
    map.put("class_cd", class_cd);
    
    model.addAttribute("termList", commonService.getProfTermList(map));
    model.addAttribute("pageBean", profClaimService.getProfImproveList(map));
    
    model.addAttribute("year", year);
    model.addAttribute("term_cd", term_cd);
    model.addAttribute("class_cd", class_cd);
    
    return "prof/claim/improve_list";
  }
  
  @RequestMapping(value = "/improve_view", method = RequestMethod.POST)
  public String profImproveView(String claim_no, Model model, HttpSession session){
    Claim claim = new Claim();
    claim.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
    claim.setYear(session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    claim.setClaim_no(claim_no);
    claim = profClaimService.getProfImproveView(claim);
    
    model.addAttribute("claim", claim);
    
    return "prof/claim/improve_view";
  }
  
  @RequestMapping(value = "/claim_view", method = RequestMethod.POST)
  public String profClaimView(String claim_no, Model model, HttpSession session){
    Claim claim = new Claim();
    claim.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
    claim.setYear(session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    claim.setClaim_no(claim_no);
    claim = profClaimService.getProfClaimView(claim);
    
    Map<String, Object> map2 = new HashMap<String, Object>();
    map2.put("class_cd", claim.getClass_cd());
    map2.put("classday", claim.getClassday());
    map2.put("classhour_start_time", claim.getClasshour_start_time());
    
    // 출결이의신청 강의확인
    // 대상 강의가 존재하는지 확인 
    // (휴강 보강 신청 및 취소 등으로 인해 존재하는지 확인) 
    String resClassFlag = profClaimService.getClassInfoFlag(map2);
    model.addAttribute("resClassFlag", resClassFlag);
    
    model.addAttribute("codeListG024", commonService.getCode("G024"));
    model.addAttribute("claim", claim);
    
    return "prof/claim/claim_view";
  }
  
  @RequestMapping(value = "/claim_confirm", method = RequestMethod.POST)
  public String profClaimConfirm(@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
                                  @RequestParam(value = "claim_no") String claim_no,
                                  @RequestParam(value = "class_cd") String class_cd, 
                                  @RequestParam(value = "classday") String classday,
                                  @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                  @RequestParam(value = "reply_claim_cd", defaultValue = "") String reply_claim_cd,
                                  @RequestParam(value = "reply_claim_content", defaultValue = "") String reply_claim_content,
                                  @RequestParam(value = "attend_auth_reason_cd", defaultValue = "") String attend_auth_reason_cd,
                                  @RequestParam(value = "before_claim_cd") String before_claim_cd,
                                  @RequestParam(value = "student_no") String student_no,
                                  Model model, HttpSession session){
    
	Map<String, Object> map = new HashMap<String, Object>();  
    String msg = "";
    String univ_cd = session.getAttribute("UNIV_CD").toString();
    String prof_no = session.getAttribute("PROF_NO").toString();
    String resClassFlag = "Y";
    
    if (term_cd.equals("")) {
      term_cd = session.getAttribute("TERM_CD").toString();
    }
    map.put("univ_cd", univ_cd);
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", term_cd);
    map.put("prof_no", prof_no);
    map.put("class_cd", class_cd);
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    map.put("student_no", student_no);
    
    Attendmaster attendmaster = commonService.getAttendmaster(map);
    Attenddethist attenddethist = commonService.getAttenddethist(map);
    
    // 강의데이터가 없는 경우의 처리
    if(attendmaster == null) {
    	attendmaster = new Attendmaster();
    	
    	attendmaster.setUniv_cd("BLANK");
    	attendmaster.setIs_team("N");
    }
    
    // 출결데이터가 없는 경우의 처리
    if(attenddethist == null) {
    	attenddethist = new Attenddethist();
    	
    	attenddethist.setUniv_cd("BLANK");
    	attenddethist.setStudent_no(student_no);
    }
    
    Claim claim = new Claim();
    
    attenddethist.setIpaddr(CommonUtil.getIpAddr());
    attenddethist.setAttend_auth_cd("G022C002");
    attenddethist.setAttend_auth_reason_cd(attend_auth_reason_cd);
    
    // 출결이의신청 강의확인
    // 대상 강의가 존재하는지 확인 
    // (휴강 보강 신청 및 취소 등으로 인해 존재하는지 확인)
    resClassFlag = profClaimService.getClassInfoFlag(map);
    
    if(resClassFlag.equals("N")) {
    	reply_claim_content = "[존재하지 않는 강의입니다.]";      
    	reply_claim_cd = "";
    }
    
    claim.setUniv_cd(univ_cd);
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
    claim.setYear(session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    claim.setClaim_no(claim_no);
    claim.setReply_claim_cd(reply_claim_cd);
    claim.setReply_claim_content(reply_claim_content);
    claim.setClaim_sts_cd("G028C002");
    
    //msg = reply_claim_content + " , " + resClassFlag;
    msg = profClaimService.claimConfirm(attendmaster, attenddethist, claim, resClassFlag);
    
    model.addAttribute("message", msg);
    
    return "msg";
  }
  
}
  