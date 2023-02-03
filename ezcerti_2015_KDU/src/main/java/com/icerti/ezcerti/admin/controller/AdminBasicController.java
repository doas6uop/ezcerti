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

import com.icerti.ezcerti.admin.service.AdminBasicService;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Univ;

@Controller
public class AdminBasicController {
	
	@Autowired
	private AdminBasicService adminBasicService = null;
	
	@RequestMapping(value = "muniv/basic/univ_info", method = RequestMethod.GET)
	public String adminUnivInfo(Model model, HttpSession session){
		Univ univ = new Univ();
		univ.setTerm_cd(session.getAttribute("TERM_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		univ.setYear(session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		
		univ = adminBasicService.getUnivInfo(univ);
		model.addAttribute("univ", univ);
		return "admin/basic/univ_info";
	}
	
	@RequestMapping(value = "muniv/basic/college_list", method = RequestMethod.GET)
	public String adminCollegeList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage, Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("currentPage", currentPage);
		
		model.addAttribute(adminBasicService.getCollInfo(map));
		 
		return "admin/basic/college_list";
	}
	
	@RequestMapping(value = "muniv/basic/department_list", method = RequestMethod.GET)
	public String adminDepartmentList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									   String item,
									   @RequestParam(value="value", defaultValue="") String searchValue, 
									   Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		if(!searchValue.equals("")){
			model.addAttribute(item);
			model.addAttribute(searchValue);
		}
		
		model.addAttribute(adminBasicService.getDeptInfo(map));
		
		
		return "admin/basic/department_list";
	}
	
	@RequestMapping(value = "muniv/basic/subject_list", method = RequestMethod.GET)
	public String adminSubjectList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								   String item,
								   @RequestParam(value="value", defaultValue="") String searchValue, 
								   Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		
		if(!searchValue.equals("")){
			model.addAttribute(item);
			model.addAttribute(searchValue);
		}
		model.addAttribute(adminBasicService.getSubjectInfo(map));
		
		return "admin/basic/subject_list";
	}
	
	@RequestMapping(value = "muniv/basic/classday_list", method = RequestMethod.GET)
	public String adminClassdayList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								   String item,
								   @RequestParam(value="value", defaultValue="") String searchValue, 
								   Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		
		model.addAttribute(adminBasicService.getClassdayInfo(map));
		
		return "admin/basic/classday_list";
	}
	
	@RequestMapping(value = "muniv/basic/classhour_list", method = RequestMethod.GET)
	public String adminClasshourList(Model model, HttpSession session){
		
		Classhour classhour = new Classhour();
		classhour.setTerm_cd(session.getAttribute("TERM_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		classhour.setYear(session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		classhour.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		
		model.addAttribute("classhour", adminBasicService.getClasshourInfo(classhour));
		
		return "admin/basic/classhour_list";
	}

	@RequestMapping(value = "muniv/basic/end_term", method = RequestMethod.POST)
	public String adminEndTerm(Model model, HttpSession session){
		String msg = "";
		Univ univ = new Univ();
		univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		univ.setYear(session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		univ.setTerm_cd(session.getAttribute("TERM_CD").toString());
		if(adminBasicService.getTermEnd(univ) == true){
			msg = "ok";
		}else{
			msg = "no";
		}
		model.addAttribute("message", msg);
		
		
		return "msg";
	}
	
	@RequestMapping(value = "muniv/basic/end_term_confirm", method = RequestMethod.POST)
	public String adminEndTermConfirm(String univ_sts_cd,Model model, HttpSession session){
		String msg = "";
		
		Univ univ = new Univ();
		univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		univ.setYear(session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		univ.setTerm_cd(session.getAttribute("TERM_CD").toString());
		if(univ_sts_cd.equals("end")){
			univ.setUniv_sts_cd("G004C002");
		}else if(univ_sts_cd.equals("start")){
			univ.setUniv_sts_cd("G004C001");
		}
		if(adminBasicService.updateUnivTerm(univ) == true){
			msg = "정상처리되었습니다.";
		}
		model.addAttribute("message", msg);
		
		return "msg";
	}
	
	
}
