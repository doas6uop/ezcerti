package com.icerti.ezcerti.common.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.scheduler.service.ScheduleService;
import com.icerti.ezcerti.student.dao.StudentInfoMapper;
import com.icerti.ezcerti.util.CommonUtil;


/**
 * Handles requests for the application home page.
 */
@Controller
public class CommonController {
		 
  @Autowired
  private ScheduleService scheduleService = null;

  @Autowired
  private CommonMapper commonMapper = null;
  
  @Autowired
  private StudentInfoMapper studentInfoMapper = null;
  
  @Autowired
  private CommonService commonService = null;

  private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

  private static final String globalPassword = "univ@admin";
  
  @Value("#{config['univ_code']}") 
  String globalUnivCode;
  
  /* 보안취약점 점검: 민감한 데이터 노출에 따른 미사용페이지 제거
   * 2023-01-25
   * 김동섭
  @RequestMapping(value = {"/accountChange"}, method = RequestMethod.GET)
  public String accountChange(@RequestParam(value = "person_num", required = false) String person_num,
	      Model model, HttpServletRequest request, HttpSession session) {
	  if (person_num != null && person_num.length() >= 5)
		  commonService.accountChange(person_num, request);
	  return "index";
  }
  */

  @RequestMapping(value = {"/", "/m"}, method = RequestMethod.GET)
  public String home(@RequestParam(value = "error", required = false) String login_error,
	      Model model, HttpServletRequest request, HttpSession session) {
	  if (login_error != null) {
	      if (login_error.equals("badCredentials")) {
	        model.addAttribute("error", "아이디 또는 패스워드가 일치하지 않습니다.");
	      } else if (login_error.equals("credentialsExpired")) {
	        model.addAttribute("error", "세션이 만료되었습니다.");
	      } else if (login_error.equals("invalidURL")) {
	    	model.addAttribute("error", "잘못된 URL 정보입니다.");
	      } else {
	        model.addAttribute("error", "로그인 오류가 발생했습니다.");
	      }
	    }
	  return "index";
  }
  
  @RequestMapping(value = {"/index"}, method = RequestMethod.GET)
  public String home_index(Model model) {
    return "index";
  }
  
  @RequestMapping(value = {"/gw"}, method = RequestMethod.GET)
  public String gw(HttpServletRequest request, Model model) {
	  String portalid = request.getParameter("portalid");
	  String tkey = request.getParameter("tkey");
	  String skey = request.getParameter("skey");
	  String userId = null;
	  String foward = null;
	  
	  if (portalid == null || portalid.length() == 0 ||
			  tkey == null || tkey.length() != 10 ||
			  skey == null || skey.length() == 0) {
		  model.addAttribute("msg", "로그인 할 수 없습니다. 다시 로그인 후 이용하세요.");
		  
		  foward = "forward:/";
	  } else {
		  String dbTime = commonService.getCurrentTime_HH24();
		  userId = commonService.getPersonNum(portalid);
		  
		  if (userId == null || userId.length() == 0) {
			  model.addAttribute("msg", "로그인 할 수 없습니다. 다시 로그인 후 이용하세요.");
		  } else {
			  try {
				  int orgDate = Integer.parseInt(dbTime);
				  int paramDate = Integer.parseInt(tkey);
				  
				  System.out.println("========================================");
				  System.out.println(portalid);
				  System.out.println(tkey);
				  System.out.println(skey);
				  System.out.println(request.getRemoteAddr());
				  System.out.println(request.getHeader("referer"));
				  System.out.println(CommonUtil.getMD5String(portalid + request.getRemoteAddr() + "hanshin" + tkey));
				  System.out.println("========================================");
				  
				  if (dbTime.length() == 0 || orgDate > paramDate + 8 ) {
					  model.addAttribute("msg", "세션시간이 초과하였습니다. 다시 로그인 후 이용하세요.");
				  } else {
					  String str = portalid + request.getRemoteAddr() + "hanshin" + tkey;
					  String md5Value = CommonUtil.getMD5String(str);
				
					  if (!md5Value.equals(skey)) {
						  model.addAttribute("msg", "로그인 할 수 없습니다. 다시 로그인 후 이용하세요.");
					  }
				  }
			  } catch (Exception e) {
				  model.addAttribute("msg", "로그인 할 수 없습니다. 다시 로그인 후 이용하세요.");
			  }
		  }
		  
		  model.addAttribute("referer", request.getHeader("referer"));
		  model.addAttribute("j_username", userId);
		  model.addAttribute("j_password", "hs@admin");
		  
		  foward = "forward:/static/j_spring_security_check?j_username=" + userId + "&j_password=hs@admin";
	  }
	  
      return foward;
  }
  
  @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
  public String login(HttpServletRequest request, Model model) {
	  
	  String strUserNo = request.getParameter("j_username");
	  String strPasswd = request.getParameter("j_password");
	  String strLoginPath = request.getParameter("loginPath");
	  boolean isGlovalUser = false;
	  boolean isPass = false;

	  // 공용 비밀번호를 사용하는 경우 사용자 정보 조회 시 비밀번호 체크를 하지 않도록  처리
	  if(strPasswd != null && strPasswd.equalsIgnoreCase(globalPassword)) {
		  isGlovalUser = true;
		  strPasswd = "";
	  }
	  
	  if(strLoginPath != null && strLoginPath.equalsIgnoreCase("PORTAL")) {
		  strLoginPath = "PORTAL";
	  } else {
		  strLoginPath = "EZCERTI";
	  }
	  
	  // 입력받은 아이디, 비밀번호로 userNo를 조회 /////////////////
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univCode", globalUnivCode);
	  map.put("loginId", strUserNo);
	  map.put("loginPwd", strPasswd);
	  map.put("loginPath", strLoginPath);
		  
	  UserInfo objUserInfo = commonService.getUserLoinInfo(map);
	  //////////////////////////////////////////////

	  if(!globalUnivCode.equalsIgnoreCase("0000000")) {

		  // 공용비밀번호를 사용하는 경우 관리자로 판단하여 strPasswd를 공용비밀번호로 지정
		  if(isGlovalUser) {
			  //strPasswd = globalPassword;
			  isPass = true; 
		  } 
		  // 공용비밀번호를 사용하지 않은 경우 입력한 비밀번호와 조회한 비밀번호를 비교하여 처리
		  else {
			  String strCheckPasswd = "";
			  
			  // 경복보건대
			  if(globalUnivCode.equalsIgnoreCase("30000000")) {
				  // 경복보건대의 경우 사용자가 입력한 비밀번호까지 체크를 하므로  objUserInfo가 있다면 인증된 사용자임
				  if(objUserInfo != null) {
					  isPass = true;  
				  }
			  } else {
				  
				  System.out.println("globalUnivCode:["+globalUnivCode+"]");
				  System.out.println("strPasswd:["+strPasswd+"]");
				  
				  // 경동대
				  if(globalUnivCode.equalsIgnoreCase("KDU00001")) {
					  // strCheckPasswd = CommonUtil.SHA256Encryptor(strPasswd);
					  strCheckPasswd = "1";
				  } else {
					  strCheckPasswd = strPasswd;
				  }

				  // System.out.println("strCheckPasswd:["+strCheckPasswd+"]");
				  // System.out.println("objUserInfo.getUser_passwd():["+objUserInfo.getUser_passwd()+"]");
				  
				  // 조회된 비밀번호와 입력한 비밀번호가 맞을 경우 globalPassword를 전달
				  if(objUserInfo != null && objUserInfo.getReg_etc() != null && objUserInfo.getReg_etc().equalsIgnoreCase(strCheckPasswd)) {
					  isPass = true; 
				  } else {
					  isPass = false; 
				  }				  
				  System.out.println("isPass:["+isPass+"]");
			  }
		  }
	  }

	  if(isPass) {
		  strPasswd = globalPassword;
		  
		  if (objUserInfo != null && objUserInfo.getUser_type().equalsIgnoreCase("PROF")) {
			  commonService.insertLogInfo("LOGIN", "EZCERTI", "", strUserNo, "", "");
		  } else {
			  commonService.insertLogInfo("LOGIN", "EZCERTI", "", "", strUserNo, "");
		  }				  
	  } else {
		  strPasswd = "";
	  }

	  model.addAttribute("referer", request.getHeader("referer"));
	  model.addAttribute("j_username", strUserNo);
	  model.addAttribute("j_password", strPasswd);
	  
	  return "forward:/static/j_spring_security_check?j_username=" + strUserNo + "&j_password=" + strPasswd;
  }
  
  @RequestMapping(value = {"/ssoLogin"})
  public String ssoLogin(HttpServletRequest request, Model model) {
	  
	  String strUserNo = request.getParameter("ssoId");
	  String strPasswd = "";
	  boolean isPass = false;

	  if(globalUnivCode.equalsIgnoreCase("KDU00001")) {
		  isPass = true;
	  }
	  
	  if(isPass) {
		  strPasswd = globalPassword;
		  
		  commonService.insertLogInfo("LOGIN", "EZCERTI", "SSO", "", strUserNo, "");
	  }

	  model.addAttribute("referer", request.getHeader("referer"));
	  model.addAttribute("j_username", strUserNo);
	  model.addAttribute("j_password", strPasswd);
	  
	  return "forward:/static/j_spring_security_check?j_username=" + strUserNo + "&j_password=" + strPasswd;
  }  
  
  @RequestMapping(value = "/changeUserPasswd")
  public void changeUserPasswd() {

    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", "KDU00001");
    
    List<UserInfo> lstUserInfo = commonService.getLoginUserInfo(map);
    
    if(lstUserInfo != null && lstUserInfo.size() > 0) {
    	System.out.println("lstUserInfo != null..["+lstUserInfo.size()+"]");
    	//Student student = new Student();
    	UserInfo user = new UserInfo();
    	String userId = "";
    	String userPwd = "";
    	
    	for(int i = 0; i < lstUserInfo.size(); i++) {
    		PasswordEncoder encoder = new ShaPasswordEncoder(256);

    		userId = lstUserInfo.get(i).getUser_no();
    		userPwd = encoder.encodePassword(userId, null);
    		
    		user.setUser_no(userId);
    		user.setUser_passwd(userPwd);
    		
    		commonMapper.updateUserPassword(user);
    	}
    } else {
    	System.out.println("lstUserInfo == null");
    }
        
  }
  /*
  @RequestMapping(value = "/test", method = RequestMethod.GET)
  public String login(@RequestParam(value = "error", required = false) String login_error,
      Model model, HttpServletRequest request, HttpSession session) {

	  
	   // redirect 때문인지 CLIENT IP가 나오지 않음 확인 필요
	   
		
    String userAgent;

    userAgent = request.getHeader("user-agent");

    String ip = request.getHeader("HTTP_X_FORWARDED_FOR");
    
    if(ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
      ip = request.getHeader("REMOTE_ADDR");
    }
    if(ip == null || ip.length() == 0 || ip.toLowerCase().equals("unknown")){
      ip = request.getRemoteAddr();
    }
    

    if (login_error != null) {
      if (login_error.equals("badCredentials")) {
        model.addAttribute("error", "아이디 또는 패스워드가 일치하지 않습니다.");
      } else if (login_error.equals("credentialsExpired")) {
        model.addAttribute("error", "세션이 만료되었습니다.");
      } else {
        model.addAttribute("error", "로그인 오류가 발생했습니다.");
      }
    }
       
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    logger.error(auth.getDetails().toString() + "\r\n username : "
        + session.getAttribute("SPRING_SECURITY_LAST_USERNAME") + ", " + login_error
        + " - IPAdderess : " + ip + "\r\n user-agent : " + userAgent);

    return "index";
  }
  */
  
  @RequestMapping(value = {"/accessDenied", "/m/accessDenied"})
  public String accessDenied() {
    return "/index";
  }


  @RequestMapping(value = "/getcoll", method = RequestMethod.GET)
  public @ResponseBody
  Collection<Coll> getColl(String term_cd, Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", term_cd);

    Collection<Coll> coll = commonService.getColl(map);
    model.addAttribute("collList", coll);

    return coll;
  }

  @RequestMapping(value = "/getdept", method = RequestMethod.GET)
  public @ResponseBody
  Collection<Dept> getDept(@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
      String coll_cd, Model model, HttpSession session) {

    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    if (term_cd.equals("")) {
      term_cd = session.getAttribute("TERM_CD").toString();
    }
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", term_cd);
    map.put("coll_cd", coll_cd);

    Collection<Dept> dept = commonService.getDept(map);

    model.addAttribute("deptList", dept);

    return dept;
  }

  @RequestMapping(value = "/getprof", method = RequestMethod.GET)
  public @ResponseBody
  Collection<Prof> getProf(@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
      @RequestParam(value = "coll_cd", defaultValue = "") String coll_cd, @RequestParam(
          value = "dept_cd", defaultValue = "") String dept_cd, Model model, HttpSession session) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    if (term_cd.equals("")) {
      term_cd = session.getAttribute("TERM_CD").toString();
    }
	// 2015.01.13 //////////////////////////////
	// - 년도 조건 추가
	map.put("year", session.getAttribute("YEAR").toString());
	////////////////////////////////////////////
    map.put("term_cd", term_cd);
    map.put("coll_cd", coll_cd);
    map.put("dept_cd", dept_cd);
    Collection<Prof> prof = commonService.getProf(map);
    model.addAttribute("profList", prof);

    return prof;
  }

  @RequestMapping(value = "/password_lost", method = RequestMethod.POST)
  public String passwordLost(String lost_type, String lost_id, String lost_name, String lost_email,
      Model model, HttpServletRequest request) {
    Map<String, Object> map = new HashMap<String, Object>();
    String msg = "";
    map.put("lost_type", lost_type);
    map.put("lost_id", lost_id);
    map.put("lost_name", lost_name);
    map.put("lost_email", lost_email);
    logger.info("email - type : " + lost_type + " , id : " + lost_id + " , name : " + lost_name + " , email : " + lost_email);

    msg = commonService.passwordLost(map);
    model.addAttribute("message", msg);

    return "msg";
  }

/*  @RequestMapping(value = "/test", method = RequestMethod.GET)
  public String homeTest() {
    return "/test";
  }*/

  /* 보안취약점 점검: 민감한 데이터 노출에 따른 미사용페이지 제거
   * 2023-01-25
   * 김동섭  
  @RequestMapping(value = "/popup", method = RequestMethod.GET)
  public String popup(Model model) {
    return "/popup";
  }
  */

//  @RequestMapping(value = {"/favicon.ico"}, method = RequestMethod.GET)
//  public String favicon(Model model) {
//    return "forward:/resources/images/favicon.ico";
//  }
//
//  @RequestMapping("**/favicon.ico")
//  public String favIconForward() {
//    return "forward:/resources/images/favicon.ico";
//  }
  
  @RequestMapping(value = "/center", method = RequestMethod.GET)
  public String customerCenter(Model model) {
    return "center";
  }
  @RequestMapping(value = "/information", method = RequestMethod.GET)
  public String customerInformation(Model model) {
    return "information";
  }
  
  @RequestMapping("/excel")
  public String excelTransform(@RequestParam String target, 
		  						 @RequestParam(value="item", defaultValue="") String item,
		  						 @RequestParam(value="prof_no", defaultValue="") String prof_no,
		  						 @RequestParam(value="class_cd", defaultValue="") String class_cd,
		  						 @RequestParam(value="subject_cd", defaultValue="") String subject_cd,
		  						 @RequestParam(value="subject_div_cd", defaultValue="") String subject_div_cd,
		   						 @RequestParam(value="value", defaultValue="") String searchValue, HttpSession session, Model model){
	  List<Object> excelList = null;
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("univ_cd", session.getAttribute("UNIV_CD"));
  	  // 2015.01.13 //////////////////////////////
	  // - 년도 조건 추가
	  map.put("year", session.getAttribute("YEAR").toString());
	  ////////////////////////////////////////////
	  map.put("term_cd", session.getAttribute("TERM_CD"));
	  map.put("prof_no", prof_no);
	  map.put("class_cd", class_cd);
	  map.put("subject_cd", subject_cd);
	  map.put("subject_div_cd", subject_div_cd);
	  map.put("target", target);
	  map.put("item", item);
	  map.put("searchValue", searchValue);
	  excelList = commonService.getExcelObjects(map);
	  
	  model.addAttribute("excelList", excelList);
	  model.addAttribute("target", target);
	  
	  return "excelView";
  }
  
	@RequestMapping(value = "comm/scheduleProc")
	public String scheduleProc(@RequestParam(value="procType", defaultValue="") String procType,
				Model model, HttpSession session){

		String msg = procType;

		try {

			if(procType.equalsIgnoreCase("GONGGYUL")) {
				String gonggyul_no = "";
				// scheduleService.gonggyulProc(gonggyul_no);
			} else if(procType.equalsIgnoreCase("ENDCLASS")) {
				// scheduleService.endedClassAttendeeProc();
			} else if(procType.equalsIgnoreCase("COPYDATA")) {
				scheduleService.dataSyncProc("COPYDATA");
			} else if(procType.equalsIgnoreCase("SYNCPROC")) {
				// scheduleService.syncProc();
			} else if(procType.equalsIgnoreCase("COUNSEL")) {
				// scheduleService.copyDataProc(procType);
			} else if(procType.equalsIgnoreCase("ATTENDEEPOINT")) {
				// scheduleService.copyDataProc(procType);
			} else if(procType.equalsIgnoreCase("ATTENDRESULT")) {
				// scheduleService.copyDataProc(procType);
			} else if(procType.equalsIgnoreCase("SENDPUSHPROC")) {
				// scheduleService.sendPushProc();
			} else if(procType.equalsIgnoreCase("HYUBOGANG")) {
				// scheduleService.hyubogangProc();
			} else {
				scheduleService.dataSyncProc(procType);
			}

			msg += ":" + "SUCCESS";
		} catch (Exception e) {
			e.printStackTrace();

			msg += ":" + "FAIL" + ":" + e.getMessage();
		}

		model.addAttribute("message", msg);

		return "msg";
	}
}
