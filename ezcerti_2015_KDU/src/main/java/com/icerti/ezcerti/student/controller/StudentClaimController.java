package com.icerti.ezcerti.student.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.student.service.StudentClaimService;
import com.icerti.ezcerti.student.service.StudentMyPageService;

@Controller
@RequestMapping({"/student/claim", "/m/student/claim"})
public class StudentClaimController {

  
	@Autowired
	private StudentClaimService studentClaimService = null;
  
	@Autowired
	private StudentMyPageService studentMyPageService = null;
  
	@Autowired
	private CommonService commonService = null;
  
  
	@RequestMapping(value = "/claim_list", method = RequestMethod.GET)
	public String studentClaimList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
									@RequestParam(value = "curr_year", defaultValue = "") String year,
									@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
                                    @RequestParam(value = "claim_sts_cd", defaultValue = "") String claim_sts_cd,
                                    @RequestParam(value = "class_cd", defaultValue = "") String class_cd,
                                    Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String univ_cd = session.getAttribute("UNIV_CD").toString();
		map.put("student_no", session.getAttribute("STUDENT_NO"));

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
		model.addAttribute("termList", commonService.getStudentTermList(map));
		model.addAttribute("pageBean", studentClaimService.getStudentClaimList(map));
		
		model.addAttribute("year", year);
		model.addAttribute("term_cd", term_cd);
		model.addAttribute("cPage", currentPage);
		model.addAttribute("class_cd", class_cd);
		
		return "student/claim/claim_list";
	}
  
	@RequestMapping(value = "/claim_view", method = RequestMethod.POST)
	public String studentClaimView(String claim_no, Model model, HttpSession session){
		Claim claim = new Claim();
		claim.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		// 2015.01.21 //////////////////////////////
		// - 년도 조건 추가
		claim.setYear(session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		claim.setClaim_no(claim_no);
		claim = studentClaimService.getStudentClaimView(claim);
		model.addAttribute("claim", claim);
		
		return "student/claim/claim_view";
	}
  
	@RequestMapping(value = "/improve_list", method = RequestMethod.GET)
	public String profImproveList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                @RequestParam(value = "curr_year", defaultValue = "") String year,
								@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
                                @RequestParam(value = "class_cd", defaultValue = "") String class_cd,
                                Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String univ_cd = session.getAttribute("UNIV_CD").toString();
		map.put("student_no", session.getAttribute("STUDENT_NO"));
		
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
		
		//System.out.println("univ_cd:["+map.get("univ_cd").toString()+"],year:["+map.get("year").toString()+"],term_cd:["+map.get("term_cd").toString()+"],student_no:["+map.get("student_no").toString()+"],class_cd:["+map.get("class_cd").toString()+"]");
		
		model.addAttribute("termList", commonService.getTermList(univ_cd));
		model.addAttribute("pageBean", studentClaimService.getStudentImproveList(map));
		
		model.addAttribute("year", year);
	    model.addAttribute("term_cd", term_cd);
		model.addAttribute("class_cd", class_cd);
		
		return "student/claim/improve_list";
	}
  
	@RequestMapping(value = "/improve_view", method = RequestMethod.POST)
	public String profImproveView(String improve_no, String class_cd, Model model, HttpSession session){
	  
		String procType = "";
		
		Map<String, Object> map = new HashMap<String, Object>();
		Claim claim = new Claim();
		claim.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		claim.setYear(session.getAttribute("YEAR").toString());
		
		System.out.println("[improve_view]univ_cd:["+claim.getUniv_cd()+"],year:["+claim.getYear()+"],improve_no:["+improve_no+"],class_cd:["+class_cd+"]");
		
		if(improve_no != null && improve_no.length() > 0) {
		    claim.setClaim_no(improve_no);
		    claim = studentClaimService.getStudentImproveView(claim);
		
		    procType = "VIEW";
		} else {
			claim.setClass_name("");
			claim.setClasshour_start_time("");
			claim.setAsk_claim_content("");
		      
		    procType = "NEW";
		}
		   
		// 강의정보 조회 ////////////////////
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());		
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("student_no", session.getAttribute("STUDENT_NO"));

		Collection<Lecture> lecture = studentMyPageService.getLectureList(map);
		model.addAttribute("lectureList", lecture);
		///////////////////////////////
		
		model.addAttribute("procType", procType);
		model.addAttribute("claim", claim);
		
		return "student/claim/improve_view";
	}
  
  @RequestMapping(value = "/getclass", method = RequestMethod.GET)
  public @ResponseBody Collection<Lecture> getProfLecture(@RequestParam(value = "year", defaultValue = "") String year,
		  								String term_cd, Model model, HttpSession session){
    
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(year == null || year.equals("")){
			year = (String) session.getAttribute("YEAR");
		}
		  
		if(term_cd == null || term_cd.equals("")){
			term_cd = (String) session.getAttribute("TERM_CD");
		}
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", year);
	    map.put("term_cd", term_cd);
		map.put("student_no", session.getAttribute("STUDENT_NO"));

		Collection<Lecture> lecture = studentMyPageService.getLectureList(map);
		model.addAttribute("lectureList", lecture);

		return lecture;
  }
}
