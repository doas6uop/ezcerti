package com.icerti.ezcerti.admin.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.dao.AdminAttendMapper;
import com.icerti.ezcerti.admin.service.AdminAttendService;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.prof.service.ProfClassService;
import com.icerti.ezcerti.util.PageBean;


@Controller
public class AdminAttendController {
	
	@Autowired
	private CommonService commonService = null;
	
	@Autowired
	private AdminAttendService adminAttendService = null;

	@Autowired
	private AdminAttendMapper adminAttendMapper = null;

	@Autowired
	private ProfClassService profClassService = null;
	
	@Value("#{config['makeup_lesson']}") 
	String globalMakLesson;

	@Value("#{config['makeup_lesson_limit']}") 
	String globalMakLessonLimit;
	
	@RequestMapping(value = "muniv/attend/class_attend_list", method = RequestMethod.GET)
	public String adminClassAttendList(@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
										@RequestParam(value = "coll_cd", defaultValue = "") String coll_cd,
										@RequestParam(value = "dept_cd", defaultValue = "") String dept_cd,
										@RequestParam(value = "class_cd", defaultValue = "") String class_cd,
										@RequestParam(value = "prof_no", defaultValue = "") String prof_no,
										@RequestParam(value = "sdate", defaultValue = "") String classday_start, 
										@RequestParam(value = "edate", defaultValue = "") String classday_end, 
										@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
										@RequestParam(value = "class_type", defaultValue = "") String class_type_cd,
										@RequestParam(value="value", defaultValue="") String searchValue, 
										String item,
										Model model, HttpSession session){
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		String univ_cd = session.getAttribute("UNIV_CD").toString();

        if (term_cd.equals("")) {
          term_cd = session.getAttribute("TERM_CD").toString();
        }else if (currentPage == null){
          currentPage = 1;
        }
        
		map.put("univ_cd", univ_cd);
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", term_cd);
		map.put("coll_cd", coll_cd);
		map.put("dept_cd", dept_cd);
		map.put("class_cd", class_cd);
		map.put("prof_no", prof_no);
	    map.put("classday_start", classday_start);
	    map.put("classday_end", classday_end);
		map.put("currentPage", currentPage);
		map.put("class_type_cd", class_type_cd);
		
	    map.put("item", item);
	    map.put("searchValue", searchValue);
		
		map.put("termList", commonService.getTermList(univ_cd));
		PageBean<Attendmaster> pageBean = null;
		if(coll_cd.equals("") && dept_cd.equals("") && prof_no.equals("") && classday_start.equals("") && classday_end.equals("")){
		  pageBean = adminAttendService.getAdminAttendListAll(map);
		}else{
		  pageBean = adminAttendService.getAdminAttendList(map);
		}
		
		model.addAttribute("classTypeList", commonService.getCode("G019"));		//강의형태코드
		model.addAttribute("termList", map.get("termList"));
		model.addAttribute("term_cd", term_cd);
		model.addAttribute("coll_cd", coll_cd);
		model.addAttribute("dept_cd", dept_cd);
		model.addAttribute("class_cd", class_cd);
		model.addAttribute("prof_no", prof_no);
	    model.addAttribute("sdate", classday_start);
	    model.addAttribute("edate", classday_end);
	    model.addAttribute("cPage", currentPage);
	    model.addAttribute("class_type", class_type_cd);
	    model.addAttribute(pageBean);
        
		return "admin/attend/class_attend_list";
	}
	
	@RequestMapping(value = "muniv/attend/class_attend_view", method = RequestMethod.GET)
	public String adminClassAttendView(String class_cd, String classday, String classhour_start_time, Model model, HttpSession session) {
	    Map<String, Object> map = new HashMap<String, Object>();
        
	    // 공결값 조회를 위해서 추가 20160907
	    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	    map.put("year", session.getAttribute("YEAR"));
	    map.put("term_cd", session.getAttribute("TERM_CD"));
	    
	    map.put("classday", classday);
	    map.put("class_cd", class_cd);
	    map.put("classhour_start_time", classhour_start_time);
	    
	    String[] classCd = class_cd.split("\\|");
	    map.put("subject_cd", classCd[3]);
	    map.put("subject_div_cd", classCd[4]);
	    
	    map.put("prof_no", "");

		// 휴, 보강 처리 ////////////////////////
		map.put("globalMakLesson", globalMakLesson);
		map.put("globalMakLessonLimit", globalMakLessonLimit);
		///////////////////////////////////
	    
	    // Prof_no를 map에 넣기 위해 강의정보 먼저 조회 (2015.04.14) ////
	    Attendmaster attendMaster = commonService.getAttendmaster(map);
	    map.put("attendMaster", attendMaster);
	    
	    if(attendMaster != null && attendMaster.getProf_no() != null) {
	    	map.put("prof_no", attendMaster.getProf_no());
	    }
	    /////////////////////////////////////////////////////////////////
	    
	    map = profClassService.getClassAttendDetailList(map);
	    
	    model.addAttribute("attendMaster", map.get("attendMaster"));
	    model.addAttribute("attendDetailList", map.get("attendDetailList"));
	    model.addAttribute("attendAuthorityDetailList", map.get("attendAuthorityDetailList"));
	    model.addAttribute("codeListG024", commonService.getCode("G024"));	//직권처리사유코드
	    model.addAttribute("class_cd", class_cd);
	    model.addAttribute("classday", classday);
	    model.addAttribute("classhour_start_time", classhour_start_time);
	    
		return "admin/attend/class_attend_view";
	}
	
	  @RequestMapping(value = "muniv/attendee/class_clear_attend", method = RequestMethod.POST)
	  public String classClearAttend(String class_cd, String classday, String classhour_start_time,
	                                 Model model, HttpSession session){
	    Map<String, Object> map = new HashMap<String, Object>();
	    String msg = "";

	    try{
		    map.put("class_cd", class_cd);
		    map.put("classday", classday);
		    map.put("classhour_start_time", classhour_start_time);
		    
	    	adminAttendMapper.setClearAttend(map);
		    msg = "정상처리 되었습니다.";
		    
	    }catch (Exception e){
	    	e.printStackTrace();
	    	msg = "오류가 발생했습니다.";
	    }
	    model.addAttribute("message", msg);
	    
	    return "msg";
	  }
}
