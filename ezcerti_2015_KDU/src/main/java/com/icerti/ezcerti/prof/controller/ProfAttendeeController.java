package com.icerti.ezcerti.prof.controller;

import java.util.ArrayList;
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

import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.prof.service.ProfAttendeeService;
import com.icerti.ezcerti.prof.service.ProfMypageService;
//import com.icerti.ezcerti.security.Value;

@Controller
@RequestMapping({"/prof/attendee", "/m/prof/attendee"})
public class ProfAttendeeController {

  @Autowired
  private ProfAttendeeService profAttendeeService = null;

  @Autowired
  private ProfMypageService profMypageService = null;

  @Autowired
  private CommonService commonService = null;

  @RequestMapping(value = "/attendee_list", method = RequestMethod.GET)
  public String profAttendeeList(
      @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage, 
      @RequestParam(value = "value", defaultValue = "") String searchValue, 
      @RequestParam(value = "curr_year", defaultValue = "") String year,
      @RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
      @RequestParam(value = "class_cd", defaultValue = "") String class_cd, 
      String item, Model model, HttpSession session) {
    
	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  
	  String univ_cd = session.getAttribute("UNIV_CD").toString();
	  String subject_cd = "";
	  String subject_div_cd = "";
	  
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
	  
	  if(!class_cd.equals("")){
		  // 2015.01.06 /////////////////////////
		  // - class_cd 구조변경에 따은 split index 변경
		  //subject_cd = class_cd.split("\\|")[2];
		  //subject_div_cd = class_cd.split("\\|")[3];
		  subject_cd = class_cd.split("\\|")[3];
		  subject_div_cd = class_cd.split("\\|")[4];
		  ///////////////////////////////////////
	  }
			
	  map.put("univ_cd", univ_cd);
	  map.put("year", year);
	  map.put("term_cd", term_cd);

	  Collection<Lecture> lectureList = profMypageService.getLectureList(map);
		
	  if(subject_cd.equals("")||subject_div_cd.equals("")){
		  if(lectureList.size()>=1){
			  Lecture lecture = ((ArrayList<Lecture>) lectureList).get(0);
			  subject_cd = lecture.getSubject_cd();
			  subject_div_cd = lecture.getSubject_div_cd();
		  }
	  }
		
	  map.put("currentPage", currentPage);
	  map.put("subject_cd", subject_cd);
	  map.put("subject_div_cd", subject_div_cd);
		
	  map.put("item", item);
	  map.put("searchValue", searchValue);
		
	  map.put("termList", commonService.getProfTermList(map));
		
	  model.addAttribute("termList", map.get("termList"));
	  model.addAttribute("lectureList", lectureList);
	  
	  model.addAttribute("year", year);
	  model.addAttribute("term_cd", term_cd);
	  model.addAttribute("class_cd", class_cd);
	  model.addAttribute("subject_cd", subject_cd);
	  model.addAttribute("subject_div_cd", subject_div_cd);
	  model.addAttribute("cPage", currentPage);
	  model.addAttribute(profAttendeeService.getProfAttendeeList(map));
		
	  return "prof/attendee/attendee_list";
  }

  @RequestMapping(value = "/attendee_view", method = RequestMethod.GET)
  public String profAttendeeView(String student_no, String class_cd, Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", class_cd.split("\\|")[1]);
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("student_no", student_no);
    map.put("class_cd", class_cd);
    
    Student student = commonService.getStudentInfo(map);
    map.put("attendDetail", profAttendeeService.getAttendDetailList(map));
    map.put("lecture", profAttendeeService.getLectureDetail(map));
    
    model.addAttribute("student", student);
    model.addAttribute("attendDetail", map.get("attendDetail"));
    model.addAttribute("lecture", map.get("lecture"));
    
    return "prof/attendee/attendee_view";
  }



}
