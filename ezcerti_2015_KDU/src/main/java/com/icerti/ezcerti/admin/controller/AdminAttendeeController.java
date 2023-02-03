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

import com.icerti.ezcerti.admin.service.AdminAttendeeService;
import com.icerti.ezcerti.common.service.CommonService;

@Controller
public class AdminAttendeeController {
	
	@Autowired
	private AdminAttendeeService adminAttendeeService = null;
	
	@Autowired
	private CommonService commonService = null;
	
	
	@RequestMapping(value = "muniv/attendee/attendee_list", method = RequestMethod.GET)
	public String adminAttendeeList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								    String item,
								    @RequestParam(value="value", defaultValue="") String searchValue, 
								    @RequestParam(value="term_cd", defaultValue="") String term_cd,
								    Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String univ_cd = session.getAttribute("UNIV_CD").toString();
		
		if(term_cd.equals("")){
			term_cd = session.getAttribute("TERM_CD").toString();
		}
		
		if(currentPage == null) currentPage = 1;
		
		// 2015.01.07 //////////////////////////////
		// - �⵵ ���� �߰�
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////

		map.put("univ_cd", univ_cd);
		map.put("term_cd", term_cd);
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		
		map.put("termList", commonService.getTermList(univ_cd));
		
		model.addAttribute("termList", map.get("termList"));
		model.addAttribute("term_cd", term_cd);
		model.addAttribute(adminAttendeeService.getLectureList(map));
		
		return "admin/attendee/attendee_list";
	}
	
	@RequestMapping(value = "muniv/attendee/attendee_view", method = RequestMethod.GET)
	public String adminAttendeeView(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								    String item,
								    @RequestParam(value="value", defaultValue="") String searchValue, 
								    @RequestParam(value="term_cd") String term_cd,
								    @RequestParam(value="subject_cd") String subject_cd,
								    @RequestParam(value="subject_div_cd") String subject_div_cd,
								    @RequestParam(value="class_cd") String class_cd,
								    Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", term_cd);
		map.put("subject_cd", subject_cd);
		map.put("subject_div_cd", subject_div_cd);
		map.put("class_cd", class_cd);
		map.put("currentPage", currentPage);
		map.put("item", item);
		map.put("searchValue", searchValue);
		
		map.put("attend", adminAttendeeService.getAttendeeListStatus(map));
		
		model.addAttribute("attendee", map);
		model.addAttribute("lecture", adminAttendeeService.getLecture(map));
		model.addAttribute(adminAttendeeService.getAttendeeList(map));
		
		
		return "admin/attendee/attendee_view";
	}
}
