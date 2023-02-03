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

import com.icerti.ezcerti.student.service.StudentMyPageService;

@Controller
@RequestMapping({"student", "m/student"})
public class StudentMyPageController {
  
  @Autowired
  private StudentMyPageService studentMyPageService = null;

  @RequestMapping(value = "student_mypage", method = RequestMethod.GET)
  public String studentMyPage(
      @RequestParam(value = "" + "classday", defaultValue = "") String classday, Model model,
      HttpSession session) {
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    // 2015.01.07 //////////////////////////////
    // - 년도 조건 추가
    map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    map.put("classday", classday);
    
    System.out.println("univ_cd:["+session.getAttribute("UNIV_CD")+"],term_cd:["+session.getAttribute("TERM_CD")+"],student_no:["+session.getAttribute("STUDENT_NO")+"],classday:["+classday+"]");
    
    map.put("lectureDay", studentMyPageService.getLectureDay(map));
    
    model.addAttribute("lectureDay", map.get("lectureDay"));
    model.addAttribute("attendList", studentMyPageService.getTodayLectureList(map));
    model.addAttribute("lectureList", studentMyPageService.getLectureList(map));
    model.addAttribute("classday", classday);

    return "student/student_mypage";
  }

  @RequestMapping(value = "student_timetable", method = RequestMethod.GET)
  public String studentTimeTable(Model model, HttpSession session) {
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    // 2015.01.07 //////////////////////////////
    // - 년도 조건 추가
    map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));
    
    return "student/student_timetable";
  }
  
}
