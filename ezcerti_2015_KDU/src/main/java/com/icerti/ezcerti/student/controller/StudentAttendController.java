package com.icerti.ezcerti.student.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.student.service.StudentAttendService;
import com.icerti.ezcerti.student.service.StudentMyPageService;

@Controller
@RequestMapping({"/student/attend", "/m/student/attend"})
public class StudentAttendController {

  @Autowired
  private StudentAttendService studentAttendService = null;
  
  @Autowired
  private StudentMyPageService studentMyPageService = null;

  @Autowired
  private CommonService commonService = null;

  @RequestMapping(value = "/attend_list", method = RequestMethod.GET)
  public String studentAttendList(@RequestParam(value = "curr_year", defaultValue = "") String year,
							      @RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
							      Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();

    if (year.equals("")) {
    	year = session.getAttribute("YEAR").toString();
    }
    
    if (term_cd.equals("")) {
    	term_cd = session.getAttribute("TERM_CD").toString();
    }
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", year);
    map.put("term_cd", term_cd);
    map.put("student_no", session.getAttribute("STUDENT_NO"));

    map.put("termList", commonService.getStudentTermList(map));
    map.put("lectureList", studentMyPageService.getLectureList(map));

    model.addAttribute("year", year);
    model.addAttribute("term_cd", term_cd);
    model.addAttribute("termList", map.get("termList"));
    model.addAttribute("lectureList", map.get("lectureList"));

    return "student/attend/attend_list";
  }

  @RequestMapping(value = "/attend_view", method = RequestMethod.GET)
  public String studentAttendView(@RequestParam(value = "term_cd", defaultValue="") String term_cd,
                                    String class_cd, String prof_no, Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	map.put("year", session.getAttribute("YEAR"));
	
	// - 교수번호 추가 (2015.02.09)
    if(prof_no != null && prof_no.length() > 0){
        map.put("prof_no", prof_no);
    } else {
        map.put("prof_no", "");
    }
    map.put("term_cd", term_cd);
    
    if(term_cd.equals("")){
      map.put("term_cd", session.getAttribute("TERM_CD"));
    }
    
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);
    
    String[] classCd = class_cd.split("\\|");
    map.put("subject_cd", classCd[3]);
    map.put("subject_div_cd", classCd[4]);
    
    map.put("lectureDetail", commonService.getLectureDetail(map));
    map.put("studentAttendCnt", studentAttendService.getStudentAttendCnt(map));
    map.put("attendDetailHistoryList", studentAttendService.getStudentAttendDetailHistoryList(map));
    
    
    model.addAttribute("lectureDetail", map.get("lectureDetail"));
    model.addAttribute("studentAttendCnt", map.get("studentAttendCnt"));
    model.addAttribute("attendDetailHistoryList", map.get("attendDetailHistoryList"));
    
    
    return "student/attend/attend_view";
  }

  @RequestMapping(value = "/attend_cert", method = RequestMethod.POST)
  public String studentAttendCert(@RequestParam(value = "class_cd") String class_cd, 
                                  @RequestParam(value = "classday") String classday,
                                  @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                  Model model, HttpSession session) {
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    
    msg = studentAttendService.checkStudentCert(map);
    
    model.addAttribute("message", msg);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("classhour_start_time", classhour_start_time);
    
    
    return "student/attend/attend_cert";
  }
  @RequestMapping(value = "/attend_cert_confirm", method = RequestMethod.POST)
  public ModelAndView studentAttendCertView(@RequestParam(value = "class_cd") String class_cd, 
                                      @RequestParam(value = "classday") String classday,
                                      @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                      @RequestParam(value = "cert_code") String class_cert_no,
                                      HttpSession session) {
    ModelAndView mav = new ModelAndView();
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    map.put("class_cert_no", class_cert_no);
    map.put("cert_sts_cd", "G031C004");
    
    if(!class_cert_no.equals("")){
      msg = studentAttendService.checkStudentCert(map);
    }    
    
    mav.setViewName("student/attend/attend_cert_confirm");
    
    if(msg.equals("incorrect_cert_no")){
      msg = "인증번호가 일치하지 않습니다.";
      mav.setViewName("student/attend/attend_cert");
    }else if(msg.equals("incorrect_cert_no")){
      msg = "강의시간이 아닙니다.";
      mav.setViewName("student/attend/attend_cert");      
    }else if(msg.equals("attend_present")){
      msg = "출석 처리되었습니다.";
    }else if(msg.equals("attend_late")){
      //msg = "지각 처리되었습니다.";
      msg = "출결유효시간 지났습니다.";
    }
    
    mav.addObject("message", msg);
    mav.addObject("class_cd", class_cd);
    mav.addObject("classday", classday);
    mav.addObject("classhour_start_time", classhour_start_time);
    
    return mav;
  }
  
  @RequestMapping(value = "/attend_improve", method = RequestMethod.POST)
  public String studentAttendImprove(@RequestParam(value = "class_cd") String class_cd, 
                                      @RequestParam(value = "classday") String classday,
                                      @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                      Model model, HttpSession session) {
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    
    model.addAttribute("attendDetailHistory", studentAttendService.getStudentAttendDetailHistory(map));
    model.addAttribute("attendMaster", commonService.getAttendmaster(map));
    model.addAttribute("message", msg);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("classhour_start_time", classhour_start_time);
    
    
    return "student/attend/attend_improve";
  }
  
  @RequestMapping(value = "/attend_claim", method = RequestMethod.POST)
  public String studentAttendClaim(@RequestParam(value = "class_cd") String class_cd, 
                                      @RequestParam(value = "classday") String classday,
                                      @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                      Model model, HttpSession session) {
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    
    model.addAttribute("attendDetailHistory", studentAttendService.getStudentAttendDetailHistory(map));
    model.addAttribute("attendMaster", commonService.getAttendmaster(map));
    model.addAttribute("message", msg);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("classhour_start_time", classhour_start_time);
    
    
    return "student/attend/attend_claim";
  }
  
  @RequestMapping(value = "/attend_improve_confirm", method = RequestMethod.POST)
  public String studentAttendImproveConfirm(@RequestParam(value = "class_cd") String class_cd, 
                                              @RequestParam(value = "classday") String classday,
                                              @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                              @RequestParam(value = "ask_claim_content") String ask_claim_content,
                                              Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    map.put("ask_claim_content", ask_claim_content);

    msg = studentAttendService.studentAttendImprove(map);
    
    if(msg.equals("ok")){
      msg = "정상 처리되었습니다.";
    }else if(msg.equals("null")){
      msg = "오류 : 데이터가 존재하지 않습니다.";
    }
    
    model.addAttribute("message", msg);
    
    return "msg";
  }
  
  @RequestMapping(value = "/attend_improve_delete", method = RequestMethod.POST)
  public String studentAttendImproveDelete(@RequestParam(value = "improve_no") String improve_no,
                                              Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("improve_no", improve_no);

    msg = studentAttendService.studentAttendImproveDelete(map);
    
    if(msg.equals("ok")){
      msg = "정상 처리되었습니다.";
    }else if(msg.equals("null")){
      msg = "오류 : 데이터가 존재하지 않습니다.";
    }
    
    model.addAttribute("message", msg);
    
    return "msg";
  }  
  
  @RequestMapping(value = "/attend_claim_confirm", method = RequestMethod.POST)
  public String studentAttendClaimConfirm(@RequestParam(value = "class_cd") String class_cd, 
                                              @RequestParam(value = "classday") String classday,
                                              @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                              @RequestParam(value = "ask_claim_cd") String ask_claim_cd,
                                              @RequestParam(value = "ask_claim_content") String ask_claim_content,
                                              Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("class_cd", class_cd);   
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    map.put("ask_claim_cd", ask_claim_cd);
    map.put("ask_claim_content", ask_claim_content);

    msg = studentAttendService.studentAttendClaim(map);
    
    if(msg.equals("ok")){
      msg = "정상 처리되었습니다.";
    }else if(msg.equals("null")){
      msg = "오류 : 데이터가 존재하지 않습니다.";
    }
    
    model.addAttribute("message", msg);
    
    return "msg";
  }

}