package com.icerti.ezcerti.student.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.student.service.StudentInfoService;

@Controller
@RequestMapping({"/student/info", "/m/student/info"})
public class StudentInfoController {
  
  @Autowired
  private StudentInfoService studentInfoService = null;
  
  @Autowired
  private CommonService commonService = null;
  
  @Autowired
  private CommonMapper commonMapper = null;
  

  @RequestMapping(value = "/student_view_edit", method = RequestMethod.GET)
  public String studentInfoView(Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();

    Student student = new Student();

    
    student.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    student.setTerm_cd(session.getAttribute("TERM_CD").toString());
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("student_no", session.getAttribute("STUDENT_NO"));

    // 2014.12.26 /////////////
    /*
    UserInfo userInfo = new UserInfo();
    userInfo = commonService.getUserInfo(map);
    
    model.addAttribute("student", userInfo);
    */
    ///////////////////////////
    
    student = commonService.getStudentInfo(map);    
    model.addAttribute("student", student);
    
    return "student/info/student_view_edit";
  }
  
  @RequestMapping(value = "/student_modify", method = RequestMethod.POST)
  public String studentInfoEdit(Student student, Model model, HttpSession session) {
  //public String studentInfoEdit(UserInfo userInfo, Model model, HttpSession session) {
    String msg = "";
    
    student.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    
    if(session.getAttribute("STUDENT_NO") != null && session.getAttribute("STUDENT_NO").toString().length() > 0) {
    	student.setStudent_no(session.getAttribute("STUDENT_NO").toString());
    }

    msg = studentInfoService.updateStudentInfo(student);
    session.removeAttribute("STUDENT_INFO");
    student.setTerm_cd(session.getAttribute("TERM_CD").toString());
    session.setAttribute("STUDENT_INFO", commonMapper.loginStudentInfo(student));

    // 2014.12.26 /////////////
    /*
    userInfo.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    userInfo.setUser_no(session.getAttribute("USER_NO").toString());

    msg = studentInfoService.updateStudentInfo(userInfo);
    session.removeAttribute("USER_INFO");
    //userInfo.setTerm_cd(session.getAttribute("TERM_CD").toString());
    session.setAttribute("USER_INFO", commonMapper.loginUserInfo(userInfo));
    */
    ///////////////////////////

    model.addAttribute("message", msg);
    return "msg";
  }


}
