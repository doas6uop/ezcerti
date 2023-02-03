package com.icerti.ezcerti.prof.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.service.AdminStatsService;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.prof.service.ProfStatsService;

@Controller
@RequestMapping("/prof/stats")
public class ProfStatsController {
	
	@Autowired
	private AdminStatsService adminStatsService = null;
	
	@Autowired
	private ProfStatsService profStatsService = null;
	
	@Autowired
	private CommonService commonService = null;
	
	@RequestMapping(value = "/stats_term", method = RequestMethod.GET)
	public String profStatsTerm(Model model, 
							@RequestParam(value = "curr_year", defaultValue = "") String year,
							@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
							HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		
		if (year.equals("")) {
			year = session.getAttribute("YEAR").toString();
	    }
	    
	    if (term_cd.equals("")) {
	    	term_cd = session.getAttribute("TERM_CD").toString();
	    }
		
		map.put("year", year);
		map.put("term_cd", term_cd);
		map.put("prof_no", session.getAttribute("PROF_NO"));
		
		model.addAttribute("year", year);
	    model.addAttribute("term_cd", term_cd);
		model.addAttribute("termList", commonService.getProfTermList(map));
		model.addAttribute("profStats", profStatsService.getProfStats(map));
		model.addAttribute("statsTermList", profStatsService.getProfStatsTerm(map));
		return "prof/stats/stats_term";
	}

	@RequestMapping(value = "/stats_term_end", method = RequestMethod.GET)
	public String profStatsTermEnd(Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.07 ///////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR"));
		/////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", session.getAttribute("PROF_NO"));
		Prof prof = new Prof();
		prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		prof.setTerm_cd(session.getAttribute("TERM_CD").toString());
		prof.setProf_no(session.getAttribute("PROF_NO").toString());
		
		model.addAttribute("statsTermEndList", profStatsService.getProfStatsTermEnd(map));
		model.addAttribute("chkRemainClass", profStatsService.getTermRemainClass(map));
		model.addAttribute("unconfirmedClaim", profStatsService.getProfStatsCheckClaim(map));
		model.addAttribute("univ", commonService.getUniv(map));
		model.addAttribute("prof", commonService.getProfInfo(prof));
		
		return "prof/stats/stats_term_end";
	}
	
	@RequestMapping(value = "/stats_term_end_confirm", method = RequestMethod.POST)
	public String profStatsTermEndConfirm(Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "";
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.07 ///////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR"));
		/////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", session.getAttribute("PROF_NO"));
		msg = profStatsService.updateProfStatsTermEnd(map);
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "/stats_daily", method = RequestMethod.GET)
	public String profStatsDaily(String subject_cd, String subject_div_cd, Model model, HttpSession session){
		Map<String, Object> map =  new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.07 ///////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR"));
		/////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", session.getAttribute("PROF_NO"));
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		
		model.addAttribute("profStatsDailyLecture", profStatsService.getProfStatsDailyLecture(map));
		model.addAttribute("profStatsDaily", profStatsService.getProfStatsDaily(map));
		
		return "prof/stats/stats_daily";
	}
	
	@RequestMapping(value = "/stats_attendee", method = RequestMethod.GET)
	public String profStatsAttendee(String subject_cd, String subject_div_cd, String classday, String classhour_start_time, Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.07 ///////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR"));
		/////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", session.getAttribute("PROF_NO"));
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		map.put("classday", classday);
		map.put("classhour_start_time", classhour_start_time);
		
		model.addAttribute("lecture", profStatsService.getAttendmaster(map));
		
		model.addAttribute("profStatsAttendee", profStatsService.getProfStatsDailyAttendee(map));
		
		return "prof/stats/stats_attendee";
	}
	
	@RequestMapping(value = "/stats_class_daily", method = RequestMethod.GET)
	public String profClassStatsDaily(String prof_no, String subject_cd, String subject_div_cd, 
										@RequestParam(value = "curr_year", defaultValue = "") String year,
										@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
										@RequestParam(value="type", defaultValue="") String type, 
										Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		
		if (year.equals("")) {
			year = session.getAttribute("YEAR").toString();
	    }
	    
	    if (term_cd.equals("")) {
	    	term_cd = session.getAttribute("TERM_CD").toString();
	    }
		
	    
	    // 현재 session 연도, 학기 정보와 선택된 연도 학기 정보 비교
	    String tmpYear = session.getAttribute("YEAR").toString();
	    String tmpTerm_CD = session.getAttribute("TERM_CD").toString();
	    String resFlag = "N";
	    
	    if(tmpYear.equals(year) && tmpTerm_CD.equals(term_cd)){
	    	resFlag = "Y";
	    }
	    
		map.put("year", year);
		map.put("term_cd", term_cd);
		map.put("prof_no", prof_no);
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);

		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "prof/stats/stats_academic_prof_class_excel";
		} else {
			
			retValue = "prof/stats/stats_academic_prof_class";
		}
		
		model.addAttribute("curr_year", year);
		model.addAttribute("curr_term_cd", term_cd);
		model.addAttribute("resFlag", resFlag);
		model.addAttribute("classDetail", adminStatsService.getLectureDetail(map));
		model.addAttribute("academicProfClassCount", adminStatsService.getLectureCount(map));
		model.addAttribute("academicProfClassStats", adminStatsService.getAdminAcademicProfClassStats(map));
		
		return retValue;
	}

	// 강의정보 새로고침 (학기마감시 사용, EndProc 교수 지정 사용)
	@RequestMapping(value = "/refresh_end_proc", method = RequestMethod.POST)
	public String refreshEndProc(String prof_no, Model model, HttpSession session){

		// IN, OUT 파라미터 설정 (ORACLE)
		// MSSQL, ALTIBASE
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("prof_no", prof_no); 	// IN
		paramMap.put("OV_ERROR_CD", "");	// OUT
		paramMap.put("OV_ERROR_MSG", "");	// OUT

		Map<String, Object> resMap = profStatsService.executeRefreshEndProc(paramMap);

		// 알티베이스의 경우는 OUT 파라미터가 존재하지 않는다
		String resMsg = resMap == null ? "정상처리 되었습니다." : resMap.get("OV_ERROR_MSG").toString();

		model.addAttribute("message", resMsg);

		return "msg";
	}
}
