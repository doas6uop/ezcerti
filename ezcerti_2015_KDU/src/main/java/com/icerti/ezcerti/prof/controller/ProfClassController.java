package com.icerti.ezcerti.prof.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.AttendAppInfo;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.prof.service.ProfClassService;
import com.icerti.ezcerti.prof.service.ProfMypageService;

@Controller
@RequestMapping({"/prof/class", "/m/prof/class"})
public class ProfClassController {

  private static final Logger logger = LoggerFactory.getLogger(ProfClassController.class);
	
  @Autowired
  private ProfMypageService profMyPageService = null;

  @Autowired
  private ProfClassService profClassService = null;
  
  @Autowired
  private CommonService commonService = null;
  
  @Autowired
  private CommonMapper commonMapper = null;

  @Value("#{config['makeup_lesson']}") 
  String globalMakLesson;

  @Value("#{config['makeup_lesson_limit']}") 
  String globalMakLessonLimit;

  @RequestMapping(value = "/class_list", method = RequestMethod.GET)
  public String profClassList(
      @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage, 
      @RequestParam(value = "value", defaultValue = "") String searchValue, 
      @RequestParam(value = "curr_year", defaultValue = "") String year,
      @RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
      @RequestParam(value = "sdate", defaultValue = "") String classday_start, 
      @RequestParam(value = "edate", defaultValue = "") String classday_end, 
      @RequestParam(value = "class_cd", defaultValue = "") String class_cd, 
      @RequestParam(value = "class_type", defaultValue = "") String class_type_cd,
      String item, Model model, HttpSession session) {

    Map<String, Object> map = new HashMap<String, Object>();

    String univ_cd = session.getAttribute("UNIV_CD").toString();
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

    map.put("univ_cd", univ_cd);
	map.put("year", year);
    map.put("term_cd", term_cd);
    map.put("currentPage", currentPage);
    map.put("class_cd", class_cd);
    map.put("classday_start", classday_start);
    map.put("classday_end", classday_end);
    map.put("class_type_cd", class_type_cd);

    map.put("item", item);
    map.put("searchValue", searchValue);

	// 휴, 보강 처리 /////////////////////////////
	// - globalMakLesson : 휴,보강 사용여부
	// - globalMakLessonLimit : 휴,보강 신청 제한일
	map.put("globalMakLesson", globalMakLesson);
	map.put("globalMakLessonLimit", globalMakLessonLimit);
	////////////////////////////////////////
    
    map.put("termList", commonService.getProfTermList(map));

    model.addAttribute("classTypeList", commonService.getCode("G019"));
    model.addAttribute("termList", map.get("termList"));
    
    model.addAttribute("year", year);
    model.addAttribute("term_cd", term_cd);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("sdate", classday_start);
    model.addAttribute("edate", classday_end);
    model.addAttribute("cPage", currentPage);
    model.addAttribute("class_type", class_type_cd);
    model.addAttribute(profClassService.getAttendmasterList(map));
    
    return "prof/class/class_list";
  }

  @RequestMapping(value = "/class_view_cert_type_update", method = RequestMethod.POST)
  public void classViewCertTypeUpdate(String class_cd,
		  						String classday, 
								String classhour_start_time, 
								String cert_type,
								Model model, 
								HttpServletResponse response,
								HttpSession session) {
	  
	  String[] arrClassInfo = class_cd.split("\\|");
	  Map<String, Object> map = new HashMap<String, Object>();
		
	  map.put("univ_cd", arrClassInfo[0]);
	  map.put("year", arrClassInfo[1]);
	  map.put("term_cd", arrClassInfo[2]);			
		
	  // map.put("subject_cd", arrClassInfo[3]);
	  // map.put("subject_div_cd", arrClassInfo[4]);
		
	  map.put("classday", classday);
	  map.put("class_cd", class_cd);
	  map.put("classhour_start_time", classhour_start_time);		
		
	  // map.put("prof_no", session.getAttribute("PROF_NO"));
		
	  // - 출결방식 저장
	  if(cert_type != null && cert_type.length() > 0 && !cert_type.equals("null")) {
		  map.put("cert_type", cert_type);
		  profClassService.updateClassCertType(map);
	  }
	  
	  try {
		  
		  response.setCharacterEncoding("UTF-8");
		  response.getWriter().write("");
		  
	  } catch (Exception e) {
		  // TODO: handle exception
		  e.printStackTrace();
	  }
  }

  @RequestMapping(value = "/class_view", method = RequestMethod.GET)
  public String profClassView(String class_cd, String classday, String classhour_start_time, String cert_type, Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    
    // 공결값 조회를 위해서 추가 20160907
    // if(objAttendmaster != null && obj.. 기존에는 아래 if 문에서만 사용되었음
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", session.getAttribute("YEAR"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    map.put("prof_no", session.getAttribute("PROF_NO"));
    
	// 휴, 보강 처리 ////////////////////////
	map.put("globalMakLesson", globalMakLesson);
	map.put("globalMakLessonLimit", globalMakLessonLimit);
	///////////////////////////////////
    
    // 2015.02.02 /////////////////////
    // - 출결방식 저장
    //System.out.println("cert_type:["+cert_type+"]");
    
    if(cert_type != null && cert_type.length() > 0 && !cert_type.equals("null")) {
        map.put("cert_type", cert_type);
        profClassService.updateClassCertType(map);        
    }    
    ///////////////////////////////////    
    
    Attendmaster objAttendmaster = commonService.getAttendmaster(map);
    
    // 2015.02.03 /////////////////////
    // - 출결 앱 상태별 수 조회
    if(objAttendmaster != null && objAttendmaster.getCert_type() != null && objAttendmaster.getCert_type().equals("CERT_NUM")) {
        map.put("prof_no", session.getAttribute("PROF_NO"));
    	
    	AttendAppInfo objAttendAppInfo = profClassService.getAttendAppStatusCnt(map);
    	ArrayList<AttendAppInfo> lstAttendAppInfo = (ArrayList<AttendAppInfo>) profClassService.getAttendAppErrorList(map);
    	
    	model.addAttribute("attendAppInfo", objAttendAppInfo);
    	model.addAttribute("attendAppErrorList", lstAttendAppInfo);
    }
    ///////////////////////////////////    
    
    String[] classCd = class_cd.split("\\|");
    map.put("subject_cd", classCd[3]);
    map.put("subject_div_cd", classCd[4]);
    
    map = profClassService.getClassAttendDetailList(map);
    map.put("attendMaster", objAttendmaster);
    
    model.addAttribute("attendMaster", map.get("attendMaster"));
    model.addAttribute("attendDetailList", map.get("attendDetailList"));
    model.addAttribute("attendAuthorityDetailList", map.get("attendAuthorityDetailList"));
    model.addAttribute("codeListG024", commonService.getCode("G024"));
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("classhour_start_time", classhour_start_time);
    model.addAttribute("currentDate", commonMapper.getCurrentDate());
    
    map.put("prof_no", classCd[6]);
    Integer isUninterruptLecture = commonService.isUninterruptLecture(map);
    model.addAttribute("isUninterruptLecture", isUninterruptLecture.intValue() > 0 ? "true" : "false");
       
    return "prof/class/class_view";
  }
  
  @RequestMapping(value = "/class_view_update", method = RequestMethod.POST)
  public String profClassViewUpdate(@RequestParam(value = "statusList[]") String[] statusList,
                                       String class_cd, Date classday, String classhour_start_time,
                                       String prof_no,
                                       Model model, HttpSession session){
    ArrayList<Attenddethist> attendUpdateList = new ArrayList<Attenddethist>();
    String msg = "";
    Attenddethist attenddethist = null;
    String[] str = null;
    try{
    	/* 출결 직권 처리 절차
    	 * 1. 교수화면이면 세션에서, 관리자화면이면 파라미터의 prof_no 정보 사용
    	 * 2. 화면에서 변경처리된 항목 수 만큼 attenddethist Object 생성 (List1)
    	 * 3. 휴학이나 퇴학상태가 아닌 수강생 목록 조회 (List2)
    	 * 4. List1과 List2를 비교하면서 동일한 수강생의 경우에 화면에서 처리된 출결 상태에 따라
    	 *    출결 수 +/- 처리
    	 * 5. TB_ATTENDDETHIST에 수강생의 출결정보 Update
    	 * 6. TB_ATTENDMASTER_ADDINFO에 출결상태별 수강생 수 Update 
    	 */    	
    	
    	if(session.getAttribute("USER_TYPE").toString().equalsIgnoreCase("[ROLE_PROF]")) {
    		prof_no = session.getAttribute("PROF_NO").toString();
    	}
    	
	    for (int i = 0; i < statusList.length; i++) {
	      attenddethist = new Attenddethist();
	      str = statusList[i].split("\\|");
	      attenddethist.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	      attenddethist.setTerm_cd(session.getAttribute("TERM_CD").toString());
	      attenddethist.setProf_no(prof_no);
	      attenddethist.setClass_cd(class_cd);
	      attenddethist.setClassday(classday);
	      attenddethist.setClasshour_start_time(classhour_start_time);
	      attenddethist.setStudent_no(str[0]);
	      attenddethist.setReg_etc(str[1]);         //이전 출결상태코드 임시로 reg_etc 사용
	      attenddethist.setAttend_sts_cd(str[2]);
	      attenddethist.setAttend_auth_reason_cd(str[3]);
	      attenddethist.setAttend_auth_cd("G022C002");
	      
	      attendUpdateList.add(i, attenddethist);
	    }
	    
		// Log Proc ///////////////
	    commonService.insertLogInfo("APP", class_cd, classday.toString(), prof_no, "", "[profClassViewUpdate][student:"+statusList.length+"]");
		///////////////////////////
	    
	    profClassService.updateProfAttendAuthoiry(attendUpdateList);
	    msg = attendUpdateList.size()+"건 변경완료 되었습니다.";
	    
    }catch (Exception e){
    	e.printStackTrace();
    	logger.error("\r\n prof_no : " + session.getAttribute("SPRING_SECURITY_LAST_USERNAME")+" class : " + class_cd + " " + classday + classhour_start_time);
    	for (int i = 0; i < statusList.length; i++) {
    		logger.error(statusList[i]);
    	}
    	msg = "오류가 발생했습니다.";
    }
    model.addAttribute("message", msg);
    
	//  System.out.println("*** profClassViewUpdate End ***");
    
    return "msg";
  }
  
  @RequestMapping(value = "/class_off", method = RequestMethod.POST)
  public String profClassOff(@RequestParam(value = "class_cd") String class_cd,
                              @RequestParam(value = "classday") String classday,
                              @RequestParam(value = "classhour_start_time") String classhour_start_time,
                              @RequestParam(value = "classroom_no") String classroom_no,
                              Model model, HttpSession session) {

    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	map.put("year", session.getAttribute("YEAR").toString());
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    
	String campus_time = classroom_no.substring(0, 1);

	// classroom_no이 '00000' 일 경우
	// classhousr_start_time을 통해 
	// 1:고성,3:원주,4:양주 등의 캠퍼스 구분을 한다
	// 그 외는 1, 3으로 구분 classroom_no 인자가 1이 아니면
	// 모두 3으로 간주 20160524
	if(campus_time.equals("0")) {
		campus_time = profClassService.getCampusTime(map);
	} else if (campus_time.equals("1")) {
		campus_time = "1";
	} else {
		campus_time = "3";
	}
	
 	map.put("campus_time", campus_time);
    
    map.put("attendMaster", commonService.getAttendmaster(map));
    /*map.put("classroomList", profClassService.getClassroomList(map));*/
    
    String[] classCd = class_cd.split("\\|");
    map.put("subject_cd", classCd[3]);
    map.put("subject_div_cd", classCd[4]);
    map.put("prof_no", classCd[6]);
    
    // 연강 수 조회
    Integer isUninterruptLecture = commonService.isUninterruptLecture(map);
    
    // 보강일 선택 시 해당 강의의 수강생들의 강의일이 잡히지 않은 날만 선택 가능하도록 처리 /////////
    // 강의시간 목록 수 조회
    int intClasshourCnt = profClassService.getClasshourList(map).size();
    
    map.put("classhour_cnt", intClasshourCnt);
    // 수강생들의 수강 정보에서 강의시간이 비어있지 않은 일자만 조회
    List<Attendmaster> lstAttendmaster = profClassService.getAttendeeClassdayList(map);
    
    String attendDay = "";
        
    if(lstAttendmaster != null && lstAttendmaster.size() > 0) {
    	for(int i = 0; i < lstAttendmaster.size(); i++) {
    		attendDay = attendDay + "'" + lstAttendmaster.get(i).getClassday() + "',";
    	}
    	
    	attendDay = attendDay.substring(0, attendDay.length() - 1);
    }
    model.addAttribute("attendDay", attendDay);
    //////////////////////////////////////////////////////////////////////
    
    model.addAttribute("attendMaster", map.get("attendMaster"));
    model.addAttribute("classhourList", map.get("classhourList"));
    model.addAttribute("classroomList", map.get("classroomList"));
    model.addAttribute("campus_time", campus_time);
    //model.addAttribute("remainDay", commonService.getRemainDay(map));
    //model.addAttribute("startDay", commonService.getStartDay(map));
    model.addAttribute("isUninterruptLecture", isUninterruptLecture.intValue() > 0 ? "true" : "false");
    
    return "prof/class/class_off";
  }  
  
  @RequestMapping(value = "/class_off_hour", method = RequestMethod.POST)
  public String profClassOffHour(@RequestParam(value = "year") String year,
		  						@RequestParam(value = "term_cd") String term_cd,
		  						@RequestParam(value = "subject_cd") String subject_cd,
		  						@RequestParam(value = "subject_div_cd") String subject_div_cd,
		  						@RequestParam(value = "classday") String classday,
		  						@RequestParam(value = "classroom_no") String classroom_no,
          Model model, HttpSession session) {	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  map.put("year", year);
	  map.put("term_cd", term_cd);
	  map.put("subject_cd", subject_cd);
	  map.put("subject_div_cd", subject_div_cd);
	  map.put("classday", classday);
	  map.put("classroom_no", classroom_no);
	  
	  // 1:고성,3:원주,4:양주 구분을 위해 사용
	  // 1, 3으로 구분 classroom_no 인자가 1이 아니면
	  // 모두 3으로 간주 20160524
	  String campus_time = classroom_no.substring(0, 1);
	  if(!campus_time.equals("1")) {
		  campus_time = "3";
	  }
	  map.put("campus_time", campus_time);
	  
	  // 지정된 보강일과 강의실로 예약이 잡혀있지 않은 강의시간을 조회
	  List<Classhour> list = profClassService.getClasshour(map);
	  model.addAttribute("list", list);
	  return "prof/class/class_off_hour";
  }  
  
  /* 보강신청 관련 시간 계산 */
  @RequestMapping(value = "/class_off_hour2", method = RequestMethod.POST)
  public String profClassOffHour2(@RequestParam(value = "year") String year,
		  						@RequestParam(value = "term_cd") String term_cd,
		  						@RequestParam(value = "subject_cd") String subject_cd,
		  						@RequestParam(value = "subject_div_cd") String subject_div_cd,
		  						@RequestParam(value = "classday") String classday,
		  						@RequestParam(value = "classroom_no") String classroom_no,
		  						@RequestParam(value = "classhour_start_time", defaultValue = "noData") String classhour_start_time,
		  						@RequestParam(value = "classhour_end_time", defaultValue = "") String classhour_end_time,
		  						@RequestParam(value = "campus_time") String campus_time,
          Model model, HttpSession session) {
	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  map.put("year", year);
	  map.put("term_cd", term_cd);
	  map.put("subject_cd", subject_cd);
	  map.put("subject_div_cd", subject_div_cd);
	  map.put("classday", classday);
	  map.put("classroom_no", classroom_no);
	  map.put("classhour_start_time", classhour_start_time);
	  map.put("classhour_end_time", classhour_end_time);
	  map.put("prof_no", session.getAttribute("PROF_NO"));
	  
	  map.put("campus_time", campus_time);
	  
	  if(!classhour_start_time.equals("noData")) {
		  //map.put("classroomList", profClassService.getClassroomList2(map));
		  model.addAttribute("classroomList", profClassService.getClassroomList2(map));
	  }
	  
	  // 지정된 보강일과 강의실로 예약이 잡혀있지 않은 강의시간을 조회
	  List<Classhour> list = profClassService.getClasshour2(map);
	  model.addAttribute("list", list);
	  return "prof/class/class_off_hour";
  }  
  
  /* 보강신청 관련 강의실 조회 */
  @RequestMapping(value = "/class_off_hour3", method = RequestMethod.POST)
  public String profClassOffHour3(@RequestParam(value = "year") String year,
		  						@RequestParam(value = "term_cd") String term_cd,
		  						@RequestParam(value = "subject_cd") String subject_cd,
		  						@RequestParam(value = "subject_div_cd") String subject_div_cd,
		  						@RequestParam(value = "classday") String classday,
		  						@RequestParam(value = "classroom_no") String classroom_no,
		  						@RequestParam(value = "classhour_start_time", defaultValue = "noData") String classhour_start_time,
		  						@RequestParam(value = "classhour_end_time", defaultValue = "") String classhour_end_time,
		  						@RequestParam(value = "campus_time") String campus_time,
          Model model, HttpSession session) {
	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("year", year);
	  map.put("term_cd", term_cd);
	  map.put("subject_cd", subject_cd);
	  map.put("subject_div_cd", subject_div_cd);
	  map.put("classday", classday);
	  map.put("classroom_no", classroom_no);
	  map.put("classhour_start_time", classhour_start_time);
	  map.put("classhour_end_time", classhour_end_time);
	  
	  map.put("campus_time", campus_time);
	  
	  model.addAttribute("classroom_no", classroom_no);
	  model.addAttribute("classroomList", profClassService.getClassroomList2(map));
	  
	  return "prof/class/class_off_room";
  }  
  
  /* 휴강 처리시 휴강 요청정보 생성 */
  @RequestMapping(value = "/class_off_confirm_request", method = RequestMethod.POST)
  public String profClassOffConfirmRequest(@RequestParam(value = "class_cd") String class_cd,
                                       @RequestParam(value = "classday") String classday,
                                       @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                       @RequestParam(value = "rdo_alter") String rdo_alter,
                                       @RequestParam(value = "alter_classday") String alterClassday,
                                       @RequestParam(value = "alter_classhour") String alterClasshour,
                                       @RequestParam(value = "alter_classroom") String alterClassroom,
                                       @RequestParam(value = "alter_classoff_reason") String alter_classoff_reason,
                                       Model model, HttpSession session) throws Exception {
	String msg = "";
	String alter_classhour_start_time = "";
	String alter_classhour_end_time = "";
	String alter_classhour_name = "";    
	Map<String, Object> map = new HashMap<String, Object>();

	map.put("univ_cd", session.getAttribute("UNIV_CD"));
	map.put("year", session.getAttribute("YEAR").toString());
	map.put("term_cd", session.getAttribute("TERM_CD"));
	map.put("prof_no", session.getAttribute("PROF_NO"));
	map.put("classday", classday);
	map.put("class_cd", class_cd);
	map.put("classhour_start_time", classhour_start_time);
	map.put("rdo_alter", rdo_alter);
    
	// 강의정보 조회
	Attendmaster attendmaster = profClassService.checkClass(map);
	
	System.out.println("cert_sts_cd:["+attendmaster.getCert_sts_cd()+"]["+attendmaster.getCert_sts_cd().equals("G021C002")+"]");
	
	// 츨결인증 처리한 강의인지 확인
	if(!attendmaster.getCert_sts_cd().equals("G021C002")) {
		// 보강정보가 있는 경우
		if(rdo_alter.equals("ok")) {
			alter_classhour_start_time = alterClasshour.split("\\|")[0];
			alter_classhour_end_time = alterClasshour.split("\\|")[1];
			alter_classhour_name = alterClasshour.split("\\|")[2];
        
			int classtime = 0;
			// 강의시간 체크
			//int classtime = commonService.getClasstime(class_cd);

			if(classtime!=0){
				Classhour classhour = new Classhour();
				classhour.setClasshour_end_time(alter_classhour_end_time);
				classhour.setClasshour(String.valueOf(classtime));
				
				classhour.setUniv_cd(session.getAttribute("UNIV_CD").toString());
				classhour.setYear(session.getAttribute("YEAR").toString());
				classhour.setTerm_cd(session.getAttribute("TERM_CD").toString());
        	
				try {
					classhour = commonService.checkClasstime(classhour);
					alter_classhour_end_time = classhour.getClasshour_end_time();
				} catch(Exception e) {
					e.printStackTrace();
					logger.error("prof_no : " + session.getAttribute("SPRING_SECURITY_LAST_USERNAME"));
					msg = classtime+"시간 강의입니다. 올바른 강의시작시간을 지정해주십시오.";
					model.addAttribute("message", msg);

					return "prof/class/class_off_confirm";
				}
			}        
        
			// 보강정보 지정
			map.put("alterClassday", alterClassday);
			map.put("alter_classhour_start_time", alter_classhour_start_time);
			map.put("alter_classhour_end_time", alter_classhour_end_time);
			map.put("alter_classhour_name", alter_classhour_name);
			map.put("alter_classroom_no", alterClassroom);
			map.put("alter_classoff_reason", alter_classoff_reason);
			
			// 2015.01.05 /////////////
			// - 학사정보 처리를 위해 실 강의코드 정보 지정
			// - 보강데이터 생성시 real_class_cd 대신 class_cd를 사용하도록 변경 (2015.12.24)
			int classCdLength = class_cd.length();
			map.put("real_class_cd", class_cd.substring(0, classCdLength-5) + alter_classhour_start_time);
			///////////////////////////
		}
  
		msg = profClassService.classOffRequest(map);
      
		if(msg.equalsIgnoreCase("already exist")) {
			msg = "같은 시간에 강의가 존재합니다.";
		} else if(msg.equalsIgnoreCase("already request")) {
			msg = "이미 휴강신청되었습니다.";
		} else if(msg.equalsIgnoreCase("success")) {
			msg = "정상 처리되었습니다.";
		} else if(msg.equalsIgnoreCase("success request")) {
			msg = "신청 처리되었습니다.";
		} else if(msg.equalsIgnoreCase("earlier than today")) {
			msg = "현재보다 이전 시간을 선택할 수 없습니다.";
		} else if(msg.equalsIgnoreCase("classday not exist")) {
			msg = "선택하신 날은 강의일이 아닙니다.";
		}
	} else {
		msg="이미 종료된 강의입니다.";
	}
    
	model.addAttribute("message", msg);
	
	return "prof/class/class_off_confirm";
  }
  
  @RequestMapping(value = "/class_off_confirm", method = RequestMethod.POST)
  public String profClassOffConfirm(@RequestParam(value = "class_cd") String class_cd,
                                       @RequestParam(value = "classday") String classday,
                                       @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                       @RequestParam(value = "rdo_alter") String rdo_alter,
                                       @RequestParam(value = "alter_classday") String alterClassday,
                                       @RequestParam(value = "alter_classhour") String alterClasshour,
                                       @RequestParam(value = "alter_classoff_reason") String alter_classoff_reason,
                                       Model model, HttpSession session) throws Exception {
    String msg = "";
    String alter_classhour_start_time = "";
    String alter_classhour_end_time = "";
    String alter_classhour_name = "";    
    String profPortalId = "";
    Map<String, Object> map = new HashMap<String, Object>();

    // 세션에서 교수정보 조회 (2015.09.04)
    Prof objProf = (Prof)session.getAttribute("PROF_INFO");

    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    map.put("rdo_alter", rdo_alter);
    
    Attendmaster attendmaster = profClassService.checkClass(map);
    if(!attendmaster.getCert_sts_cd().equals("G021C002")){
      
      if(rdo_alter.equals("ok")){
        alter_classhour_start_time = alterClasshour.split("\\|")[0];
        alter_classhour_end_time = alterClasshour.split("\\|")[1];
        alter_classhour_name = alterClasshour.split("\\|")[2];
        
        //int classtime = 0;
        int classtime = commonService.getClasstime(map);
        //System.out.println(classtime);
        if(classtime!=0){
        	Classhour classhour = new Classhour();
        	classhour.setClasshour_end_time(alter_classhour_end_time);
        	classhour.setClasshour(String.valueOf(classtime));

            // 2015.01.13 /////////////
            // - classhour에 조회조건 추가
        	classhour.setUniv_cd(session.getAttribute("UNIV_CD").toString());
        	classhour.setYear(session.getAttribute("YEAR").toString());
        	classhour.setTerm_cd(session.getAttribute("TERM_CD").toString());
            ///////////////////////////
        	
        	try{
        		classhour = commonService.checkClasstime(classhour);
        		alter_classhour_end_time = classhour.getClasshour_end_time();
        	}catch(Exception e){
        		e.printStackTrace();
        		logger.error("prof_no : " + session.getAttribute("SPRING_SECURITY_LAST_USERNAME"));
        		msg = classtime+"시간 강의입니다. 올바른 강의시작시간을 지정해주십시오.";
        		model.addAttribute("message", msg);
        		return "prof/class/class_off_confirm";
        	}
        }        
        
        map.put("alterClassday", alterClassday);
        map.put("alter_classhour_start_time", alter_classhour_start_time);
        map.put("alter_classhour_end_time", alter_classhour_end_time);
        map.put("alter_classhour_name", alter_classhour_name);
        map.put("alter_classoff_reason", alter_classoff_reason);
        
        // 2015.01.05 /////////////
        // - 학사정보 처리를 위해 실 강의코드 정보 지정
        int classCdLength = class_cd.length();
        map.put("real_class_cd", class_cd.substring(0, classCdLength-5) + alter_classhour_start_time);
        ///////////////////////////
      }
  
      msg = profClassService.classOff(map);
      
      if(msg.equals("already exist")){
        msg = "같은 시간에 강의가 존재합니다.";
      }else if(msg.equals("success")){
        msg = "정상 처리되었습니다.";
      }else if(msg.equals("earlier than today")){
        msg = "현재보다 이전 시간을 선택할 수 없습니다.";
      }
    }else{
      msg="이미 종료된 강의입니다.";
    }
    model.addAttribute("message", msg);
    return "prof/class/class_off_confirm";
  }

  @RequestMapping(value = "/class_off_cancel", method = RequestMethod.POST)
  public String profClassOffCancel(String class_cd, String classday, String classhour_start_time, Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    
	String[] arrClassInfo = null;
	
	if(class_cd != null) {
		arrClassInfo = class_cd.split("\\|");
		
		map.put("prog_cd",				"G018C001");
		map.put("univ_cd",				arrClassInfo[0]);
		map.put("year",					arrClassInfo[1]);
		map.put("term_cd",				arrClassInfo[2]);
		map.put("class_cd",				class_cd);
		map.put("classday",				classday);
		map.put("classhour_start_time",	classhour_start_time);
		map.put("prof_no",				arrClassInfo[6]);
		
		msg = profClassService.classOffCancel(map);
	}

	model.addAttribute("message", msg);

    return "msg";
  }  
    
  @RequestMapping(value = "/class_add", method = RequestMethod.GET)
  public String profClassAdd(Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    // 2015.01.06 ///////////////////////
    // - 년도 조건 추가
    map.put("year", session.getAttribute("YEAR"));
    /////////////////////////////////////
    map.put("prof_no", session.getAttribute("PROF_NO"));
    
    map.put("classhourList", profClassService.getClasshourList(map));
    map.put("remainDay", commonService.getRemainDay(map));
    map.put("startDay", commonService.getStartDay(map));
    
    model.addAttribute("classhourList", map.get("classhourList"));
    model.addAttribute("remainDay", map.get("remainDay"));
    model.addAttribute("startDay", map.get("startDay"));
    model.addAttribute("lectureList", profMyPageService.getLectureList(map));
    return "prof/class/class_add";
  }
  
  @RequestMapping(value = "/class_add_confirm", method = RequestMethod.POST)
  public String profClassAddConfirm(String class_cd, String addClassday, String addClasshour, Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    String[] arrClassInfo = null;
    
    if(class_cd != null) {
    	arrClassInfo = class_cd.split("\\|");

    	map.put("univ_cd", arrClassInfo[0]);
        map.put("year", arrClassInfo[1]);
        map.put("term_cd", arrClassInfo[2]);
        map.put("subject_cd", arrClassInfo[3]);
        map.put("subject_div_cd", arrClassInfo[4]);
        map.put("prof_no", arrClassInfo[6]);
    } else {
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
        map.put("subject_cd", "");
        map.put("subject_div_cd", "");
		map.put("prof_no", session.getAttribute("PROF_NO").toString());
    }
    
    int classtime = commonService.getClasstime(map);
    //System.out.println(classtime);
    
    String add_classhour_start_time = addClasshour.split("\\|")[0];
    String add_classhour_end_time = addClasshour.split("\\|")[1];
    if(classtime!=0){
    	Classhour classhour = new Classhour();
    	classhour.setClasshour_end_time(add_classhour_end_time);
    	classhour.setClasshour(String.valueOf(classtime));
    	
        // 2015.01.13 /////////////
        // - classhour에 조회조건 추가
    	classhour.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    	classhour.setYear(session.getAttribute("YEAR").toString());
    	classhour.setTerm_cd(session.getAttribute("TERM_CD").toString());
        ///////////////////////////
    	
    	try{
    		classhour = commonService.checkClasstime(classhour);
    		add_classhour_end_time = classhour.getClasshour_end_time();
    	}catch(Exception e){
    		e.printStackTrace();
    		logger.error("prof_no : " + session.getAttribute("SPRING_SECURITY_LAST_USERNAME"));
    		msg = classtime+"시간 강의입니다. 올바른 강의시작시간을 지정해주십시오.";
    		model.addAttribute("message", msg);
    		return "msg";
    	}
    }
    
    String add_classhour_name = addClasshour.split("\\|")[2];
    String add_classhour_no = addClasshour.split("\\|")[3];
    
    // 2015.01.06 /////////////////////
    // - class_cd의 구조변경으로 인해 index 변경
    //String subject_cd = class_cd.split("\\|")[2];
    //String subject_div_cd = class_cd.split("\\|")[3];
    String subject_cd = class_cd.split("\\|")[3];
    String subject_div_cd = class_cd.split("\\|")[4];
    ///////////////////////////////////
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    // 2015.01.06 /////////////////////
    // - 년도 조건 추가
    map.put("year", session.getAttribute("YEAR"));
    // - 학사정보 처리를 위해 실 강의코드 정보 지정
    map.put("real_class_cd", class_cd.substring(0, 9) + class_cd.substring(14));
    ///////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("classday", addClassday);
    map.put("alterClassday", addClassday);
    map.put("classhour_start_time", add_classhour_start_time);
    map.put("classhour_end_time", add_classhour_end_time);
    map.put("classhour_name", add_classhour_name);
    map.put("classhour_no", add_classhour_no);
    map.put("class_cd", class_cd);
    map.put("subject_cd", subject_cd);
    map.put("subject_div_cd", subject_div_cd);
    
    msg = profClassService.addClass(map);
    
    if(msg.equals("already exist")){
      msg = "같은 시간에 강의가 존재합니다.";
    }else if(msg.equals("success")){
      msg = "정상 처리되었습니다.";
    }else if(msg.equals("earlier than today")){
      msg = "현재보다 이전 시간을 선택할 수 없습니다.";
    }
    
    model.addAttribute("message", msg);

    //return "prof/class/class_view?class_cd="+class_cd+"&classday="+classday+"&classhour_start_time="+classhour_start_time;
    return "msg";
  }

  @RequestMapping(value = "/class_cert_type", method = RequestMethod.POST)
  public String profClassCertType(@RequestParam(value = "class_cd") String class_cd,
                              @RequestParam(value = "classday") String classday,
                              @RequestParam(value = "classhour_start_time") String classhour_start_time,
                              @RequestParam(value = "cert_sts_cd") String cert_sts_cd,
                              Model model, HttpSession session) {
    	 
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    
    //System.out.println("cert_sts_cd:["+cert_sts_cd+"]");
    
    model.addAttribute("cert_sts_cd", cert_sts_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("classhour_start_time", classhour_start_time);
    
    return "prof/class/class_cert_type";
  }
  
  @RequestMapping(value = "/class_cert", method = RequestMethod.POST)
  public String profClassCert(@RequestParam(value = "class_cd") String class_cd,
                              @RequestParam(value = "classday") String classday,
                              @RequestParam(value = "classhour_start_time") String classhour_start_time,
                              @RequestParam(value = "cert_type") String cert_type,
                              Model model, HttpSession session) {
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    map.put("attendMaster", commonService.getAttendmaster(map));
    
    //System.out.println("cert_type:["+cert_type+"]");
    
    model.addAttribute("cert_type", cert_type);
    model.addAttribute("attendMaster", map.get("attendMaster"));
    
    if (cert_type != null && cert_type.equals("BEACON_AUTH"))
    	return "prof/class/class_cert_beacon";
    else return "prof/class/class_cert";
  }

  @RequestMapping(value = "/class_cert_confirm", method = RequestMethod.POST)
  public String profClassCertConfirm(@RequestParam(value = "class_cd") String class_cd,
                                    @RequestParam(value = "cert_sts_cd") String cert_sts_cd,
                                    @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                    @RequestParam(value = "classday") String classday,
                                    @RequestParam(value = "cert_time") String class_cert_time,
                                    @RequestParam(value = "cert_type") String cert_type,
                                    Model model, HttpSession session) {
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    map.put("attendMaster", commonService.getAttendmaster(map));
    
    model.addAttribute("attendMaster", map.get("attendMaster"));
    model.addAttribute("cert_sts_cd", cert_sts_cd);
    model.addAttribute("cert_time", class_cert_time);
    model.addAttribute("cert_type", cert_type);
    
    if (cert_type != null && cert_type.equals("BEACON_AUTH"))
    	return "prof/class/class_cert_confirm_beacon";
    else return "prof/class/class_cert_confirm";
  }
  
  @RequestMapping(value = "/class_cert_view", method = RequestMethod.POST)
  public String profClassCertView(@RequestParam(value = "class_cd") String class_cd,
                                  @RequestParam(value = "cert_sts_cd", defaultValue="") String cert_sts_cd,
                                  @RequestParam(value = "classday") String classday,
                                  @RequestParam(value = "classhour_start_time") String classhour_start_time,
                                  @RequestParam(value = "cert_time", defaultValue="") String class_cert_time,
                                  @RequestParam(value = "cert_type", defaultValue="") String cert_type,
                                  Model model, HttpSession session) {
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("classday", classday);
    map.put("class_cd", class_cd);
    map.put("classhour_start_time", classhour_start_time);
    // 2015.01.06 /////////////////////////
    // - 인증번호를 상태변경시 발생하도록 checkClass의 SQL문 변경
    ///////////////////////////////////////
    Attendmaster attendmaster = profClassService.checkClass(map);
    if(attendmaster.getCert_sts_cd().equals("G021C001")&&attendmaster.getClass_sts_cd().equals("G020C002")){
      map.put("cert_sts_cd", cert_sts_cd);
      map.put("class_cert_time", class_cert_time);
      // 2015.01.06 /////////////////////////
      // - 생성된 인증번호로 변경하도록 updateClassCert의 SQL문 변경 
      map.put("class_cert_no", attendmaster.getClass_cert_no());
      ///////////////////////////////////////
      profClassService.updateClassCert(map);
      
      // 2015.02.02 /////////////////////
      // - 출결방식 저장
      if(cert_type != null && cert_type.length() > 0 && !cert_type.equalsIgnoreCase("null")) {
          map.put("cert_type", cert_type);
      } else {
          map.put("cert_type", "PROF_AUTH");
      }
      
      //System.out.println("cert_type:["+cert_type+"]");
      
      profClassService.updateClassCertType(map);
      ///////////////////////////////////
    }
    map.put("attendMaster", commonService.getAttendmaster(map));
    
    model.addAttribute("attendMaster", map.get("attendMaster"));
    
    if (cert_type != null && cert_type.equals("BEACON_AUTH"))
    	return "prof/class/class_cert_view_beacon";
    else return "prof/class/class_cert_view";
  }
  
  @RequestMapping(value = "/getclass", method = RequestMethod.GET)
  public @ResponseBody Collection<Lecture> getProfLecture(String year, String term_cd, 
		  Model model, HttpSession session){
      Map<String, Object> map = new HashMap<String, Object>();

      if(year == null || year.equals("")){
    	  year = (String) session.getAttribute("YEAR");
      }
      
      if(term_cd == null || term_cd.equals("")){
    	 term_cd = (String) session.getAttribute("TERM_CD");
      }
      
      map.put("univ_cd", session.getAttribute("UNIV_CD"));
      map.put("year", year);
      map.put("term_cd", term_cd);
      map.put("prof_no", session.getAttribute("PROF_NO"));
      
      Collection<Lecture> lecture = profMyPageService.getLectureList(map);
      model.addAttribute("lectureList", lecture);
      
      return lecture;
  }
  
  @RequestMapping(value = "/attend_copy", method = RequestMethod.POST)
  public String profAttendCopy(String class_cd, String subject_cd, String subject_div_cd, String classday, String classhour_start_time, Model model, HttpSession session){
    Map<String, Object> map = new HashMap<String, Object>();
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", session.getAttribute("YEAR"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("subject_cd", subject_cd);
    map.put("subject_div_cd", subject_div_cd);
    map.put("classday", classday);
    map.put("classhour_start_time", classhour_start_time);
    
    model.addAttribute("attendList", profClassService.getCopyAttendList(map));
    model.addAttribute("class_cd", class_cd);
    model.addAttribute("subject_cd", subject_cd);
    model.addAttribute("subject_div_cd", subject_div_cd);
    model.addAttribute("classday", classday);
    model.addAttribute("classhour_start_time", classhour_start_time);
    return "prof/class/attend_copy";
  }
  
  @RequestMapping(value = "/attend_copy_confirm", method = RequestMethod.POST)
  public String profAttendCopyConfirm(String class_cd, Date classday, String classhour_start_time, String[] classList, Model model, HttpSession session){
    String msg = "";
    Map<String, Object> map = new HashMap<String, Object>();
    
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", session.getAttribute("YEAR"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("class_cd", class_cd);
    map.put("classday", classday.toString());
    map.put("classhour_start_time", classhour_start_time);
    map.put("classList", classList); // 선택된 연강의 정보 {class_cd, classday, classhour_start_time}
    map.put("prof_no", session.getAttribute("PROF_NO"));
    
    String[] classCd = class_cd.split("\\|");
    map.put("subject_cd", classCd[3]);
    map.put("subject_div_cd", classCd[4]);
    
    msg = profClassService.copyClass(map);
    
    model.addAttribute("message", msg);
    return "msg";
  }
  
  @RequestMapping(value = "/attend_batch_list", method = RequestMethod.GET)
  public String profAttendBatchList(Model model, HttpSession session){
	Map<String, Object> map = new HashMap<String, Object>();
	
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    // 2015.01.06 /////////////////////
    // - 년도 조건 추가
    map.put("year", session.getAttribute("YEAR"));
    ///////////////////////////////////
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    
    model.addAttribute("lectureList", profMyPageService.getLectureList(map));
    
    return "prof/class/attend_batch_list";
  }
  
  @RequestMapping("/attend_batch_loading")
  public String attendBatchLoading(Model model, String class_cd){
	  model.addAttribute("class_cd", class_cd);
	  return "prof/class/attend_batch_loading";
  }
  
  @RequestMapping(value = "/attend_batch", method = RequestMethod.GET)
  public String profAttendBatch(HttpServletResponse response, String class_cd, Model model, 
		  @RequestParam(value="type", defaultValue="") String type, HttpSession session){
	
	Map<String, Object> map = new HashMap<String, Object>();
	  
	map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", session.getAttribute("YEAR"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("class_cd", class_cd);
	
	// 로딩 전 캐쉬 삭제
	response.setHeader("pragma", "No-cache");
	response.setHeader("Cache-Control", "No-cache");
	response.addHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 1L); 
    
    String[] classCd = class_cd.split("\\|");
    map.put("subject_cd", classCd[3]);
    map.put("subject_div_cd", classCd[4]);
    
	String retValue = "";
	
	if(type != null && type.equals("EXCEL")) {
		retValue = "prof/class/attend_batch_excel";
	} else {
		
		retValue = "prof/class/attend_batch";
	}
	
    model.addAttribute("lectureDetail", commonService.getLectureDetail(map));
    model.addAttribute("batchList", profClassService.getBatchList(map));
    model.addAttribute("codeListG024", commonService.getCode("G024"));
    model.addAttribute("currentDate", commonMapper.getCurrentDate());
	
    return retValue;
  }
  
  @RequestMapping(value = "/attend_batch", method = RequestMethod.POST)
  public String profAttendBatchSubmit(@RequestParam(value = "attendStatus[]") String[] attendStatus, 
		  								 String class_cd, Model model, HttpSession session){
	  String msg = "";
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  // 2015.01.06 /////////////////////
	  // - 년도 조건 추가
	  map.put("year", session.getAttribute("YEAR"));
	  ///////////////////////////////////
	  map.put("term_cd", session.getAttribute("TERM_CD"));
	  map.put("prof_no", session.getAttribute("PROF_NO"));
	  map.put("class_cd", class_cd);
	  map.put("attendStatus", attendStatus);
	  msg = profClassService.profAttendBatch(map);
	  model.addAttribute("message", msg);
	  return "msg";
  }
  /*
  @RequestMapping(value = "/attend_batch", method = RequestMethod.POST)
  public String profAttendBatchSubmit(@RequestParam(value = "attendStatus[]") String[] attendStatus, 
		  								 String class_cd, Model model, HttpSession session){
	  String msg = "";
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  map.put("term_cd", session.getAttribute("TERM_CD"));
	  map.put("prof_no", session.getAttribute("PROF_NO"));
	  map.put("class_cd", class_cd);
	  map.put("attendStatus", attendStatus);
	  msg = profClassService.profAttendBatch(map);
	  model.addAttribute("message", msg);
	  return "msg";
  }
  */

@RequestMapping(value = "/restore_class", method = RequestMethod.POST)
  public String profRestoreClass(String class_cd, String classday, String classhour_start_time, String class_type_cd, 
		  						   String before_classday,
		  						   Model model, HttpSession session){
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  // 2015.01.13 //////////////////////////////
	  // - 년도 조건 추가
	  map.put("year", session.getAttribute("YEAR").toString());
	  ////////////////////////////////////////////
	  map.put("term_cd", session.getAttribute("TERM_CD"));
	  map.put("prof_no", session.getAttribute("PROF_NO"));
	  map.put("class_cd", class_cd);
	  map.put("classday", classday);
	  map.put("classhour_start_time", classhour_start_time);
	  map.put("class_type_cd", class_type_cd);
	  
	  //System.out.println("before_classday:["+before_classday+"]["+before_classday.length()+"]");
	  
	  if(before_classday.length() > 0){
		String cDay = before_classday.split(" ")[0];
		String cStart = before_classday.split(" ")[1];
		cStart = cStart.substring(0, 5);
		if(class_type_cd!=null && class_type_cd.equals("G019C003")){
			map.put("cType", "G019C002");
		}else if(class_type_cd!=null && class_type_cd.equals("G019C002")){
			map.put("cType", "G019C003");
		}
		map.put("cDay", cDay);
		map.put("cStart", cStart);
		//map.put("before_class_cd", class_cd.substring(0, class_cd.length()-5) + cStart);
		map.put("before_class_cd", class_cd);
		model.addAttribute("beforeClass", profClassService.getBeforeRestoreClass(map));
	  }
	  model.addAttribute("currentClass", profClassService.getCurrentRestoreClass(map));
	  
	  return "prof/class/restore_class";
  }
  
  @RequestMapping(value ="/restore_class_request", method = RequestMethod.POST)
  public String profRestoreClassRequest(String class_cd,
	  								   String current_classday, String current_classhour_start_time, String current_class_type_cd, 
	  								   String before_classday, String before_classhour_start_time, String before_class_type_cd,
	  								   Model model, HttpSession session){
	  String msg = "";
	  String[] arrClassInfo = null;
	  Map<String, Object> map = new HashMap<String, Object>();
	  
	  if(class_cd != null) {
		  arrClassInfo = class_cd.split("\\|");
		  
		  map.put("univ_cd", arrClassInfo[0]);
		  map.put("year", arrClassInfo[1]);
		  map.put("term_cd", arrClassInfo[2]);
		  map.put("prof_no", arrClassInfo[6]);
	  } else {
		  map.put("univ_cd", session.getAttribute("UNIV_CD"));
		  map.put("year", session.getAttribute("YEAR"));
		  map.put("term_cd", session.getAttribute("TERM_CD"));
		  map.put("prof_no", session.getAttribute("PROF_NO"));
	  }

	  map.put("class_cd", class_cd);
	  map.put("current_classday", current_classday);
	  map.put("current_classhour_start_time", current_classhour_start_time);
	  map.put("current_class_type_cd", current_class_type_cd);
	  
	  if(before_classday != null && before_classday.length()>0){
		  map.put("before_classday", before_classday);
		  map.put("before_classhour_start_time", before_classhour_start_time);
		  map.put("before_class_type_cd", before_class_type_cd);
		  //map.put("before_class_cd", class_cd.substring(0, class_cd.length()-5) + before_classhour_start_time);
		  map.put("before_class_cd", class_cd);
	  }

	  msg = profClassService.restoreClassRequest(map);
	  
	  if(msg.equalsIgnoreCase("already request")) {
		  msg = "이미 취소신청되었습니다.";
	  } else if(msg.equalsIgnoreCase("success")) {
		  msg = "정상 처리되었습니다.";
	  } else if(msg.equalsIgnoreCase("success request")) {
		  msg = "취소신청 처리되었습니다.";
	  }	  
	  
	  model.addAttribute("message", msg);
	  
	  return "msg";
  }  

  @RequestMapping(value ="/restore_class_confirm", method = RequestMethod.POST)
  public String profRestoreClassConfirm(String class_cd,
		  								   String current_classday, String current_classhour_start_time, String current_class_type_cd, 
		  								   String before_classday, String before_classhour_start_time, String before_class_type_cd, Model model, HttpSession session){
	  String msg = "";
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
	  // 2015.01.13 //////////////////////////////
	  // - 년도 조건 추가
	  map.put("year", session.getAttribute("YEAR").toString());
	  ////////////////////////////////////////////
	  map.put("term_cd", session.getAttribute("TERM_CD"));
	  map.put("prof_no", session.getAttribute("PROF_NO"));
	  map.put("class_cd", class_cd);
	  map.put("current_classday", current_classday);
	  map.put("current_classhour_start_time", current_classhour_start_time);
	  map.put("current_class_type_cd", current_class_type_cd);
	  
	  //System.out.println("class_cd:["+class_cd+"]");
	  //System.out.println("current_classday:["+current_classday+"]");
	  //System.out.println("current_classhour_start_time:["+current_classhour_start_time+"]");
	  //System.out.println("current_class_type_cd:["+current_class_type_cd+"]");
	  	  
	  if(before_classday != null && before_classday.length()>0){
		map.put("before_classday", before_classday);
		map.put("before_classhour_start_time", before_classhour_start_time);
		map.put("before_class_type_cd", before_class_type_cd);
		map.put("before_class_cd", class_cd.substring(0, class_cd.length()-5) + before_classhour_start_time);
	  }

	  // 2015.01.05 /////////////
	  // - 학사정보 처리를 위해 실 강의코드 정보 지정
	  map.put("real_class_cd", class_cd.substring(0, 9) + class_cd.substring(14));
	  ///////////////////////////
		  
	  msg = profClassService.restoreClass(map);
	  model.addAttribute("message", msg);
	  
	  return "msg";
  }
  

 }
