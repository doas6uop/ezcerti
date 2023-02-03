package com.icerti.ezcerti.admin.controller;

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
import com.icerti.ezcerti.prof.service.ProfStatsService;

@Controller
public class AdminStatsController {
	
	@Autowired
	private AdminStatsService adminStatsService = null;
	
	@Autowired
	private ProfStatsService profStatsService = null;
	
	@Autowired
	private CommonService commonService = null;
	
	@RequestMapping(value = "muniv/stats/stats_attendstatus", method = RequestMethod.GET)
	public String adminStatsAttendStatus(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
											Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("currentPage", currentPage);
		
		model.addAttribute(adminStatsService.getAdminStatsAttendStatus(map));
		return "admin/stats/stats_attendstatus";
	}
	
	@RequestMapping(value = "muniv/stats/stats_term", method = RequestMethod.GET)
	public String adminStatsTerm(Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		model.addAttribute("statsTerm", adminStatsService.getAdminStatsTerm(map));
		
		return "admin/stats/stats_term";
	}


	@RequestMapping(value = "muniv/stats/stats_studentstatus", method = RequestMethod.GET)
	public String adminStatsStudentStatus(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
											Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("currentPage", currentPage);
		
		model.addAttribute(adminStatsService.getAdminStatsStudentStatus(map));
		
		return "admin/stats/stats_studentstatus";
	}
	
	@RequestMapping(value = "muniv/stats/stats_prof", method = RequestMethod.GET)
	public String adminStatsProf(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
		    						String item,
		    						@RequestParam(value="value", defaultValue="") String searchValue, 			
		    						Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("item", item);
		map.put("searchValue", searchValue);		
		map.put("currentPage", currentPage);
		
		model.addAttribute(adminStatsService.getAdminStatsProf(map));
		
		return "admin/stats/stats_prof";
	}
	
	@RequestMapping(value = "muniv/stats/stats_prof_term", method = RequestMethod.GET)
	public String adminStatsProfTerm(String prof_no,Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", prof_no);
		
		model.addAttribute("profStats", profStatsService.getProfStats(map));
		model.addAttribute("statsTermList", profStatsService.getProfStatsTerm(map));
		 
		return "admin/stats/stats_prof_term";
	}
	
	@RequestMapping(value = "muniv/stats/stats_prof_daily", method = RequestMethod.GET)
	public String adminStatsProfDaily(String prof_no, String subject_cd, String subject_div_cd, Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", prof_no);
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		
		model.addAttribute("statsProfDaily", profStatsService.getProfStatsDaily(map));
		
		return "admin/stats/stats_prof_daily";
	}
	
	@RequestMapping(value = "muniv/stats/stats_prof_dailyattendee", method = RequestMethod.GET)
	public String adminStatsProfDailyAttendee(String prof_no, String subject_cd, String subject_div_cd, String classday, String classhour_start_time, Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("prof_no", prof_no);
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		map.put("classday", classday);
		map.put("classhour_start_time", classhour_start_time);
		
		model.addAttribute("lecture", profStatsService.getAttendmaster(map));
		model.addAttribute("statsProfDailyAttendee", profStatsService.getProfStatsDailyAttendee(map));
		
		return "admin/stats/stats_prof_dailyattendee";
	}
	
	/* 
	 * 학사팀 통계(2015.04.07)
	 */
	@RequestMapping(value = "muniv/stats/stats_academic")
	public String adminAcademicStats(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									@RequestParam(value = "curr_year", defaultValue = "") String year,
									@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
		    						String item,
		    						@RequestParam(value="value", defaultValue="") String searchValue,
									@RequestParam(value="sortField", defaultValue="") String sortField, 
                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
                                    @RequestParam(value="type", defaultValue="") String type,
		    						Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;

		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		
		if (year.equals("")) {
			year = session.getAttribute("YEAR").toString();
	    }
	    
	    if (term_cd.equals("")) {
	    	term_cd = session.getAttribute("TERM_CD").toString();
	    }
	    
	    map.put("year", year);
		map.put("term_cd", term_cd);
		map.put("item", item);
		map.put("searchValue", searchValue);		
		map.put("currentPage", currentPage);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/stats/stats_academic_excel";
		} else {
			
			retValue = "admin/stats/stats_academic";
		}
		
		model.addAttribute("year", year);
	    model.addAttribute("term_cd", term_cd);
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("termList", commonService.getProfTermList(map));
		model.addAttribute(adminStatsService.getAdminAcademicStats(map));

		return retValue;
	}
	
	/* 
	 * 학사팀 교수 통계(2015.04.07)
	 */
	@RequestMapping(value = "muniv/stats/stats_academic_prof_class", method = RequestMethod.GET)
	public String adminAcademicProfClassStats(String prof_no, String subject_cd, String subject_div_cd,String classhour_start_time,
											@RequestParam(value="type", defaultValue="") String type, 
											@RequestParam(value = "curr_year", defaultValue = "") String year,
											@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
											Model model, HttpSession session){
		
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
		map.put("prof_no", prof_no);
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		map.put("classhour_start_time", classhour_start_time);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/stats/stats_academic_prof_class_excel";
		} else {
			
			retValue = "admin/stats/stats_academic_prof_class";
		}
		
		model.addAttribute("curr_year", year);
		model.addAttribute("curr_term_cd", term_cd);
		model.addAttribute("classDetail", adminStatsService.getLectureDetail(map));
		model.addAttribute("academicProfClassCount", adminStatsService.getLectureCount(map));
		model.addAttribute("academicProfClassStats", adminStatsService.getAdminAcademicProfClassStats(map));
		
		return retValue;
	}
	
	/* 
	 * 결강현황(2015.04.16)
	 */
	@RequestMapping(value = "muniv/stats/stats_cancel_class")
	public String getAdminCancelClassList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
											String item,
											@RequestParam(value="value", defaultValue="") String searchValue,
											@RequestParam(value="current_date", defaultValue="") String current_date,
											@RequestParam(value="sortField", defaultValue="") String sortField, 
		                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
											@RequestParam(value="type", defaultValue="") String type, 
											Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;

		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		map.put("current_date", current_date);
		map.put("currentPage", currentPage);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/stats/stats_cancel_class_excel";
		} else {
			
			retValue = "admin/stats/stats_cancel_class";
		}
		
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute(adminStatsService.getAdminCancelClassList(map));
		
		return retValue;
	}
		
	/* 
	 * 결석현황(2015.04.16)
	 */
	@RequestMapping(value = "muniv/stats/stats_absence")
	public String getAdminAbsenceList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
											@RequestParam(value="dept_name", defaultValue="") String dept_name,
											@RequestParam(value="student_grade", defaultValue="all") String student_grade,
											@RequestParam(value="student_no", defaultValue="") String student_no,
											@RequestParam(value="current_date", defaultValue="") String current_date,
											@RequestParam(value="sortField", defaultValue="") String sortField, 
		                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
		                                    @RequestParam(value="type", defaultValue="") String type,
		                                    @RequestParam(value="sdate", defaultValue="") String startDate, 
		                                    @RequestParam(value="edate", defaultValue="") String endDate,
											Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;

		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		map.put("dept_name", dept_name);
		map.put("student_grade", student_grade);
		map.put("student_no", student_no);
		map.put("current_date", current_date);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		map.put("currentPage", currentPage);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/stats/stats_absence_excel";
		} else {
			
			retValue = "admin/stats/stats_absence";
		}
		
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute(adminStatsService.getAdminAbsenceList(map));
		
		return retValue;
	}	
	
	/* 
	 * 결석현황 엑셀다운로드(20160929)
	 */
	@RequestMapping(value = "muniv/stats/stats_absence_excel")
	public String statsAbsenceExcel(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
											@RequestParam(value="dept_name", defaultValue="") String dept_name,
											@RequestParam(value="student_grade", defaultValue="all") String student_grade,
											@RequestParam(value="student_no", defaultValue="") String student_no,
											@RequestParam(value="current_date", defaultValue="") String current_date,
											@RequestParam(value="sortField", defaultValue="") String sortField, 
		                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
		                                    @RequestParam(value="type", defaultValue="") String type,
		                                    @RequestParam(value="sdate", defaultValue="") String startDate, 
		                                    @RequestParam(value="edate", defaultValue="") String endDate,
											Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		if(currentPage == null) currentPage = 1;
	
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		map.put("dept_name", dept_name);
		map.put("student_grade", student_grade);
		map.put("student_no", student_no);
		map.put("current_date", current_date);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		map.put("currentPage", currentPage);
		
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute(adminStatsService.getAdminAbsenceListExcel(map));
		
		return "admin/stats/stats_absence_excel2";
	}	
	
	/* 
	 * 교수별 출결 통계(2015.10.29)
	 */
	@RequestMapping(value = "muniv/stats/stats_prof_usage", method = RequestMethod.GET)
	public String adminProfUsageStats(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
		    						String item,
		    						@RequestParam(value="value", defaultValue="") String searchValue, 			
		    						@RequestParam(value="type", defaultValue="") String type, 
									@RequestParam(value="sortField", defaultValue="") String sortField, 
                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
		    						Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;

		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("item", item);
		map.put("searchValue", searchValue);		
		map.put("currentPage", currentPage);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/stats/stats_prof_usage_excel";
		} else {
			
			retValue = "admin/stats/stats_prof_usage";
		}

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute(adminStatsService.getAdminProfUsageStats(map));

		return retValue;
	}
}
