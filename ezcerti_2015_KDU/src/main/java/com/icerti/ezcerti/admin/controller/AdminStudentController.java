package com.icerti.ezcerti.admin.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.service.AdminStudentService;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.student.service.StudentAttendService;
import com.icerti.ezcerti.student.service.StudentInfoService;
import com.icerti.ezcerti.student.service.StudentMyPageService;

@Controller
public class AdminStudentController {

	@Autowired
	private CommonMapper commonMapper = null;
	
	@Autowired
	private AdminStudentService adminStudentService = null;
	
	@Autowired
	private StudentMyPageService studentMyPageService = null;
	
	@Autowired
	private StudentAttendService studentAttendService = null;
	
	@Autowired
	private StudentInfoService studentInfoService = null;
	
	@Autowired
	private CommonService commonService = null;
	
	@RequestMapping(value = "muniv/student/student_list", method = RequestMethod.GET)
	public String adminStudentList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
                                    String item,
                                    @RequestParam(value="value", defaultValue="") String searchValue, 
                                    @RequestParam(value="coll_cd", defaultValue="") String coll_cd,
                                    @RequestParam(value="dept_cd", defaultValue="") String dept_cd,
                                    Model model, HttpSession session){
	  
      Map<String, Object> map = new HashMap<String, Object>();
      
      if(currentPage == null) currentPage = 1;
      
      map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
      // 2015.01.07 /////////////////////////
      // - 년도 조건  추가
      map.put("year", session.getAttribute("YEAR").toString());
      ///////////////////////////////////////
      map.put("term_cd", session.getAttribute("TERM_CD").toString());
      map.put("coll_cd", coll_cd);
      map.put("dept_cd", dept_cd);
      map.put("currentPage", currentPage);
      
      map.put("item", item);
      map.put("searchValue", searchValue);
      map.put("collList", commonService.getColl(map));
      
      
      model.addAttribute("coll_cd", coll_cd);
      model.addAttribute("dept_cd", dept_cd);
      model.addAttribute(adminStudentService.getStudentList(map));
      model.addAttribute(map.get("collList"));
	  
		return "admin/student/student_list";
	}
	
	@RequestMapping(value = "muniv/student/student_view", method = RequestMethod.GET)
	public String adminStudentView(@RequestParam(value="student_no") String student_no,
									@RequestParam(value="class_type", defaultValue="") String class_type, 
                                     Model model, HttpSession session){
      Map<String, Object> map = new HashMap<String, Object>();
  
      map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
      // 2015.01.07 /////////////////////////
      // - 년도 조건  추가
      map.put("year", session.getAttribute("YEAR").toString());
      ///////////////////////////////////////
      map.put("term_cd", session.getAttribute("TERM_CD").toString());
      map.put("student_no", student_no);
      
      Student student = commonService.getStudentInfo(map);
      model.addAttribute("studentInfo", student);
      
      // 수강정보 조회 조건 추가 (2015.04.16) ///////////
      // - 전체 수강정보 조회 (class_type = '')
      // - 결석 수가 특정 수를 넘은 수강정보 조회 (class_type = 'ABSENCE') 
      Collection<Lecture> lectureList = null;
      
      if(class_type != null && class_type.equals("ABSENCE")) {
    	  lectureList = studentMyPageService.getAbsenceLectureList(map);
      } else {
    	  lectureList = studentMyPageService.getLectureList(map);
      }

      //model.addAttribute("lectureList", studentMyPageService.getLectureList(map));
      model.addAttribute("lectureList", lectureList);
      ///////////////////////////////////////////////////
      
      return "admin/student/student_view";
	}

	@RequestMapping(value = "muniv/student/student_attend_view", method = RequestMethod.POST)
	public String adminStudentAttendView(String class_cd, String classhour_start_time, 
	                                        String student_no, Model model, HttpSession session){
	  Map<String, Object> map = new HashMap<String, Object>();
	  
	  map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
      // 2015.01.07 /////////////////////////
      // - 년도 조건  추가
      map.put("year", session.getAttribute("YEAR").toString());
      ///////////////////////////////////////
      map.put("term_cd", session.getAttribute("TERM_CD").toString());
      map.put("student_no", student_no);
      map.put("class_cd", class_cd);
      map.put("classhour_start_time", classhour_start_time);
      map.put("prof_no", "");

      String[] arrClasscd = class_cd.split("\\|");
      map.put("subject_cd", arrClasscd[3]);
      map.put("subject_div_cd", arrClasscd[4]);
      
      // Prof_no를 map에 넣기 위해 강의정보 먼저 조회 (2015.04.14) ////
      Lecture lecture = commonService.getLectureDetail(map);      
      model.addAttribute("lecture", lecture);
      
      if(lecture != null && lecture.getProf_no() != null) {
    	  map.put("prof_no", lecture.getProf_no());
      }      
      /////////////////////////////////////////////////////////////////
      
      model.addAttribute("attendDetailHistoryList", studentAttendService.getStudentAttendDetailHistoryList(map));
      
	  return "admin/student/student_attend_view";
	}
	
	@RequestMapping(value = "muniv/student/student_edit", method = RequestMethod.GET)
	public String adminStudentEdit(String student_no,Model model, HttpSession session){
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
      // 2015.01.07 /////////////////////////
      // - 년도 조건  추가
      map.put("year", session.getAttribute("YEAR").toString());
      ///////////////////////////////////////
      map.put("term_cd", session.getAttribute("TERM_CD").toString());
      map.put("student_no", student_no);
      model.addAttribute("student", commonService.getStudentInfo(map));
      model.addAttribute("codeListG010", commonService.getCode("G010"));    //학년
      model.addAttribute("codeListG011", commonService.getCode("G011"));    //국적
      model.addAttribute("codeListG012", commonService.getCode("G012"));    //학생상태
	  
	  return "admin/student/student_edit";
	}
	
	@RequestMapping(value = "muniv/student/student_edit_confirm", method = RequestMethod.POST)
	public String adminStudentEditConfirm(Student student, Model model, HttpSession session){
	  String msg = "";
	  student.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	  msg = studentInfoService.updateStudentInfo(student);
	  model.addAttribute("message", msg);
	  return "msg";
	}
	
	@RequestMapping(value = "muniv/student/student_resetpassword", method = RequestMethod.POST)
	public String adminStudentResetPassword(Student student, Model model, HttpSession session){
	  String msg = "";
	  String lost_id = student.getStudent_no();
	  String lost_name = student.getStudent_name();
	  String lost_email = student.getEmail_addr();
	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("lost_type", "student");
	  map.put("lost_id", lost_id);
	  map.put("lost_name", lost_name);
	  map.put("lost_email", lost_email);
	  
	  msg = commonService.passwordLost(map);
	  model.addAttribute("message", msg);
	  
	  return "msg";
	}
	
	@RequestMapping(value = "muniv/student/student_off", method = RequestMethod.POST)
	public String adminStudentOff(String student_no, Model model, HttpSession session){
		String msg = "";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
	    // 2015.01.07 /////////////////////////
	    // - 년도 조건  추가
	    map.put("year", session.getAttribute("YEAR").toString());
	    ///////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("student_no", student_no);
		msg = adminStudentService.updateStudentOff(map);
		
		model.addAttribute("message", msg);
		return "msg";
	}
	@RequestMapping(value = "muniv/student/student_quit", method = RequestMethod.POST)
	public String adminStudentQuit(String student_no, Model model, HttpSession session){
		String msg = "";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
	    // 2015.01.07 /////////////////////////
	    // - 년도 조건  추가
	    map.put("year", session.getAttribute("YEAR").toString());
	    ///////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("student_no", student_no);
		msg = adminStudentService.updateStudentQuit(map);
		
		model.addAttribute("message", msg);
		return "msg";
	}

	@RequestMapping(value = "muniv/student/student_initpassword", method = RequestMethod.POST)
	public String adminStudentInitPassword(Student student, Model model, HttpSession session){
		
		String userId = "";
		String userPwd = "";
		String msg = "";
    	UserInfo user = new UserInfo();
	  
	    if(student != null && student.getStudent_no() != null && student.getStudent_no().length() > 0) {
	    	
	    	userId = student.getStudent_no();
	    	
    		PasswordEncoder encoder = new ShaPasswordEncoder(256);
   			userPwd = encoder.encodePassword(userId, null);
    		
    		user.setUser_no(userId);
    		user.setUser_passwd(userPwd);
    		
    		commonMapper.updateUserPassword(user);
    		
    		msg = "비밀번호가 초기화되었습니다.";
	    } else {
	    	msg = "오류가 발생했습니다.";
	    }
	    
	    model.addAttribute("message", msg);
	    
	    return "msg";
	}
	
	@RequestMapping(value = "muniv/student/student_initCertCount", method = RequestMethod.POST)
	public String adminStudentInitCertCount(String student_no, Model model, HttpSession session){
		
		String msg = "";
	  
	    if(student_no != null && student_no.length() > 0) {
	    	
	    	adminStudentService.initStudentCertCount(student_no);
    		
    		msg = "학번 인증횟수가 초기화되었습니다.";
	    } else {
	    	msg = "오류가 발생했습니다.";
	    }
	    
	    model.addAttribute("message", msg);
	    
	    return "msg";
	}	
}
