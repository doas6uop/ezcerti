package com.icerti.ezcerti.common.service;

import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.admin.dao.AdminStatsMapper;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Codemaster;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.prof.dao.ProfStatsMapper;
import com.icerti.ezcerti.prof.service.ProfStatsService;
import com.icerti.ezcerti.util.CommonUtil;

@Service
public class CommonServiceImpl implements CommonService {

  @Value("#{config['univ_code']}") 
  String globalUnivCode;

  @Value("#{config['univ_url']}") 
  String globalUnivURL;

  @Value("#{config['makeup_lesson_sms']}") 
  String globalMakeupLessonSMS;
  
  @Autowired
  private CommonMapper commonMapper = null;
  
  @Autowired
  private MailService mailService = null;
  
  @Autowired
  private AdminStatsMapper adminStatsMapper = null;
  
  @Autowired
  private ProfStatsMapper profStatsMapper = null;
  
  @Autowired
  private ProfStatsService profStatsService = null;

  @Override
  public String getCurrentTime_HH24() {
	  return commonMapper.getCurrentTime_HH24();
  }
  // 2014.12.30
  //	- 현재의 학기 조회
  @Override
  public Univ getCurrentTerm(Univ univ) {
    return commonMapper.getCurrentTerm(univ);
  }

  @Override
  public Univ getLastTerm(Univ univ) {
    return commonMapper.getLastTerm(univ);
  }
  
  @Override
  public Collection<Univ> getTermList(String univ_cd) {
    return commonMapper.getTermList(univ_cd);
  }

  @Override
  public Collection<Coll> getColl(Map<String, Object> map) {
    return commonMapper.getCollList(map);
  }

  @Override
  public Collection<Dept> getDept(Map<String, Object> map) {
    return commonMapper.getDeptList(map);
  }

  @Override
  public Collection<Univ> getProfTermList(Map<String, Object> map) {
    return commonMapper.getProfTermList(map);
  }

  @Override
  public UserInfo getUserInfo(Map<String, Object> map) {
    return commonMapper.getUserInfo(map);
  }  

  @Override
  public UserInfo getUserInfo(UserInfo user) {
    return commonMapper.getUserInfo(user);
  }  

  @Override
  public List<UserInfo> getLoginUserInfo(Map<String, Object> map) {
    return commonMapper.getLoginUserInfo(map);
  }  

  //2014.12.26
  // - UserInfo getUserInfo(UserInfo user)로 대체
  @Override
  public Prof getProfInfo(Prof prof) {
    return commonMapper.getProfInfo(prof);
  }

  //2014.12.26
  // - UserInfo getUserInfo(UserInfo user)로 대체
  @Override
  public Student getStudentInfo(Map<String, Object> map) {
    return commonMapper.getStudentInfo(map);
  }

  @Override
  public Attendmaster getAttendmaster(Map<String, Object> map) {
    return commonMapper.getAttendmaster(map);
  }
  
  @Override
  public Integer isUninterruptLecture(Map<String, Object> map) {
    return commonMapper.isUninterruptLecture(map);
  }

  @Override
  public Collection<Attenddethist> getAttendDetailList(Map<String, Object> map) {
    return commonMapper.getAttendDetailList(map);
  }

  @Override
  public Collection<Codemaster> getCode(String code_grp_cd) {
    return commonMapper.getCode(code_grp_cd);
  }

  @Override
  public Collection<Univ> getStudentTermList(Map<String, Object> map) {
    return commonMapper.getStudentTermList(map);
  }

  @Override
  public Lecture getLectureDetail(Map<String, Object> map) {
    return commonMapper.getLectureDetail(map);
  }

  @Override
  public int getRemainDay(Map<String, Object> map) {
    Univ univ = commonMapper.getUniv(map);
    
    int remainDay = (int) ((univ.getTerm_end_date().getTime() / (24*60*60*1000)) - (commonMapper.getCurrentTime().getTime()/ (24*60*60*1000)));
    //System.out.println(remainDay);
    return remainDay;
  }
  
  @Override
  public int getStartDay(Map<String, Object> map) {
	  Univ univ = commonMapper.getUniv(map);
	  
	  int remainDay = (int) ((univ.getTerm_start_date().getTime() / (24*60*60*1000)) - (commonMapper.getCurrentTime().getTime()/ (24*60*60*1000)));
	  //System.out.println(remainDay);
	  return remainDay;
  }

  @Override
  public Classday getClassday(Map<String, Object> map) {
    return commonMapper.getClassday(map);
  }

  @Override
  public Collection<Prof> getProf(Map<String, Object> map) {
    return commonMapper.getProf(map);
  }

  @Transactional
  @Override
  public String passwordLost(Map<String, Object> map) {
    String msg = "";
    String lost_type = map.get("lost_type").toString();
    String lost_id = map.get("lost_id").toString();
    String lost_name = map.get("lost_name").toString();
    String lost_email = map.get("lost_email").toString();
    String password = "";
    if(lost_type.equals("student")){
      Student student = new Student();
      student.setStudent_no(lost_id);
      student.setStudent_name(lost_name);
      student.setEmail_addr(lost_email);
      student = commonMapper.findStudentPassword(student);
      if(student==null){
        msg = "일치하는 회원이 존재하지 않습니다.";
        return msg;
      }else{
        PasswordEncoder encoder = new ShaPasswordEncoder(256);
        password = CommonUtil.randomPassword(8);
        student.setStudent_passwd(encoder.encodePassword(password, null));
        commonMapper.updateStudentPassword(student);
        msg = "changepw";
      }
    }else if(lost_type.equals("prof")){
      Prof prof = new Prof();
      prof.setProf_no(lost_id);
      prof.setProf_name(lost_name);
      prof.setEmail_addr(lost_email);
      prof = commonMapper.findProfPassword(prof);
      if(prof==null){
        msg = "일치하는 회원이 존재하지 않습니다.";
        return msg;
      }else{
        PasswordEncoder encoder = new ShaPasswordEncoder(256);
        password = CommonUtil.randomPassword(8);
        prof.setProf_passwd(encoder.encodePassword(password, null));
        commonMapper.updateProfPassword(prof);
        msg = "changepw";
      }
    }
    if(msg.equals("changepw")){
      String subject = "[EZCERTI] "+lost_name+"님의 임시비밀번호 입니다.";
      String text = "";
      text +="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">                                                                                                                                                             ";
      text +="<html xmlns=\"http://www.w3.org/1999/xhtml\">                                                                                                                                                                                                                                             ";
      text +="<head>                                                                                                                                                                                                                                                                                    ";
      text +="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />                                                                                                                                                                                                                 ";
      text +="<title>임시 비밀번호 메일 전송</title>                                                                                                                                                                                                                                                    ";
      text +="</head>                                                                                                                                                                                                                                                                                   ";
      text +="<body>                                                                                                                                                                                                                                                                                    ";
      text +="<div class=\"borderbox\" style=\"max-width:750px; font-family: '돋움', '돋움체'; line-height: 26px; color: #000; border: 1px solid #a2a2a2; font-size: 12px;\">                                                                                                                           ";
      text +="<div class=\"topgray\" style=\"display:table-cell; vertical-align:middle; font-family: '돋움', '돋움체'; font-size: 12px; font-weight: bold; color: #FFF; background-color: #A2A2A2; text-align: left; height: 30px; width: 743px; padding-left: 7px;\"> 전자출결관리 시스템 EZCERTI</div>";
      text +="<table width=\"695\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">                                                                                                                                                                                                   ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"105\" colspan=\"2\" align=\"center\" valign=\"middle\"><img src=\"https://www.ezcerti.com/dju/resources/images/common/pwtitle.png\" width=\"455\" height=\"33\" alt=\"요청임시비번타이틀\" /></td>                                                                      ";
      text +="    </tr>                                                                                                                                                                                                                                                                                 ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"105\" colspan=\"2\" align=\"center\" valign=\"middle\" bgcolor=\"#e7e7e7\"><strong>"+lost_name+"("+lost_id+"***)"+"님, EZCERTI를 이용해 주셔서 감사합니다.</strong><br />                                                                                                ";
      text +="      개인정보보호를 위해 반드시 <span class=\"bluefont\" style=\"font-weight: bold; color: #0271bf;\">‘개인정보관리’</span>에서 비밀번호를 변경하여 주세요.</td>                                                                                                                       ";
      text +="    </tr>                                                                                                                                                                                                                                                                                 ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"48\" colspan=\"2\">&nbsp;</td>                                                                                                                                                                                                                                           ";
      text +="    </tr>                                                                                                                                                                                                                                                                                 ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td width=\"137\" height=\"45\" align=\"center\" valign=\"middle\" class=\"rightnone\" style=\"font-family: '돋움', '돋움체'; font-size: 12px; font-weight: bold; background-color: #E7E7E7; border: 1px solid #a2a2a2; border-right:none;\">임시비밀번호</td>                        ";
      text +="    <td width=\"558\" class=\"borderbox\" style=\"padding-left:10px; font-family: '돋움', '돋움체'; line-height: 26px; color: #000; border: 1px solid #a2a2a2; font-size: 12px;\"><span style='margin-right:20px; font-weight:bold;'>"+password+"</span>※대,소문자를 정확히 구별하여 입력해주시기 바랍니다.</td>";
      text +="  </tr>                                                                                                                                                                                                                                                                                   ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"130\" colspan=\"2\" align=\"center\"><a href=\""+globalUnivURL+"\"><img src=\""+globalUnivURL+"/resources/images/common/ezcerti_button.png\" width=\"146\" height=\"45\" alt=\"이지서티바로가기버튼\" border=\"0\"/></a></td>                                ";
      text +="    </tr>                                                                                                                                                                                                                                                                                 ";
      text +="</table>                                                                                                                                                                                                                                                                                  ";
      text +="<table width=\"750\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">                                                                                                                                                                                                                    ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"55\" bgcolor=\"#E7E7E7\" style=\"border-top:solid; border-color:#a2a2a2; border-width:1px; padding-left:10px;\" >ㆍ 본메일은 발신전용으로 회신처리되지 않습니다. 궁금한 점이나 불편한사항은 고객센터(1544-5105)를 통해 문의하여 주시기 바랍니다.                         ";
      text +="  </td>                                                                                                                                                                                                                                                                                   ";
      text +="  </tr>                                                                                                                                                                                                                                                                                   ";
      text +="  <tr>                                                                                                                                                                                                                                                                                    ";
      text +="    <td height=\"87\" class=\"footer\" style=\"padding-left:20px; font-family: '돋움', '돋움체'; font-size: 11px; line-height: 18px; color: #FFF; background-color: #A2A2A2;\">(주)아이서티 | (04997) 서울시 광진구 능동로 283 진성빌딩 4층 ㈜아이서티 | 대표 : 김영후 <br />            ";
      text +="      TEL : 02-446-8802 | FAX : 02-458-8085 | EMAIL : admin@icerti.com<br />                                                                                                                                                                                                              ";
      text +="      <strong>COPYRIGHT (C) 2013 icerti. ALL RIGHT RESERVED.</strong></td>                                                                                                                                                                                                                ";
      text +="  </tr>                                                                                                                                                                                                                                                                                   ";
      text +="</table>                                                                                                                                                                                                                                                                                  ";
      text +="</div>                                                                                                                                                                                                                                                                                    ";
      text +="</body>                                                                                                                                                                                                                                                                                   ";
      text +="</html>                                                                                                                                                                                                                                                                                   ";
      try{
        mailService.sendMail(subject, text, "donotreply@icerti.com", lost_email, null);
        msg = "임시비밀번호가 메일로 발송되었습니다.";
      }catch (Exception e){
        msg = "오류가 발생했습니다.";
        e.printStackTrace();
      }
    }else{
      msg = "오류가 발생했습니다.";
    }
    
    return msg;
  }
  
  @Override
  public String getURL(HttpServletRequest request)
  {
      Enumeration<?> param = request.getParameterNames();
  
      StringBuffer strParam = new StringBuffer();
      StringBuffer strURL = new StringBuffer();
  
      if (param.hasMoreElements())
      {
        strParam.append("?");
      }
  
      while (param.hasMoreElements())
      {
        String name = (String) param.nextElement();
        String value = request.getParameter(name);
  
        strParam.append(name + "=" + value);
  
        if (param.hasMoreElements())
        {
          strParam.append("&");
        }
    }
  
    strURL.append(request.getRequestURL());
    strURL.append(strParam);
  
    return strURL.toString();
  }

  @Override
  public Admin loginAdminInfo(Admin admin) {
    return commonMapper.loginAdminInfo(admin);
  }

  @Override
  public Prof loginProfInfo(Prof prof) {
    return commonMapper.loginProfInfo(prof);
  }

  @Override
  public Student loginStudentInfo(Student student) {
    return commonMapper.loginStudentInfo(student);
  }

  public int getClasstime(Map<String, Object> map) {
  	return commonMapper.getClasstime(map);
  }
	
  @Override
  public Classhour checkClasstime(Classhour classhour) {
	return commonMapper.checkClasstime(classhour);
  }

  @Override
  public List<Object> getExcelObjects(Map<String, Object> map) {
	String target = map.get("target").toString();
	if(target.equals("attendStatus")) return adminStatsMapper.getAdminStatsAttendStatusExcel(map);
	if(target.equals("studentStatus")) return adminStatsMapper.getAdminStatsStudentStatusExcel(map);
	if(target.equals("adminStatsProf")) return adminStatsMapper.getAdminStatsProfExcel(map);
	if(target.equals("statsProfTerm")) return profStatsMapper.getProfStatsTermExcel(map);
	if(target.equals("statsProfDaily")) return profStatsMapper.getProfStatsDailyExcel(map);
	if(target.equals("statsAttendee")){
		map.put("classdayList", profStatsMapper.getLectureClassday(map));
		return profStatsMapper.getStatsAttendeeExcel(map);
	}
	return null;
  }	
  
  @Override
  public Univ getUniv(Map<String, Object> map){
	  return commonMapper.getUniv(map);
  }

	@Override
	public Attenddethist getAttenddethist(Map<String, Object> map) {
		return commonMapper.getAttenddethist(map);
	}
	
	@Override
	public String getPersonNum(String user_id) {
		return commonMapper.getPersonNum(user_id);
	}
	
	@Override
	public String getPersonNumOfLogin(String user_id, String password, String password1) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id); map.put("password", password); map.put("password1", password1);
		return commonMapper.getPersonNumOfLogin(map);
	}

	@Override
	public String getUserIdFromPersonNum(String person_num) {
		return commonMapper.getUserIdFromPersonNum(person_num);
	}
	
	@Override
	public UserInfo getUserLoinInfo(Map<String, Object> map) {
		return commonMapper.getUserLoinInfo(map);
	}
	
	@Override
	public void accountChange(String person_num, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    String reg_type_cd = "";
	    if (person_num.length() == 5) {
	    	reg_type_cd = "[ROLE_PROF]";
	    } else {
	    	reg_type_cd = "[ROLE_STUDENT]";
	    }
	    String user_type = reg_type_cd;
	    
	    session.setAttribute("ROLE_ANONYMOUS", "ROLE_ANONYMOUS");
	    session.setAttribute("UNIV_CD", globalUnivCode);	

	    Univ univ = new Univ();
	    String strCurrTerm = "";
	    
	    univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	    univ.setUniv_sts_cd("G004C001");
	    
	    univ = commonMapper.getCurrentTerm(univ);
	    
	    if(univ != null) {
	    	strCurrTerm = univ.getTerm_cd();
	    	session.setAttribute("TERM_CD", strCurrTerm);
	    	session.setAttribute("YEAR", univ.getYear());	
	    } else {
	    	univ = new Univ();
	        univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());

	        univ = commonMapper.getLastTerm(univ);    	
	    	strCurrTerm = univ.getTerm_cd();
	    	session.setAttribute("TERM_CD", strCurrTerm);	
	    	session.setAttribute("YEAR", univ.getYear());	
	    }
	
	    
	    if(reg_type_cd.equals("[ROLE_PROF]")){
	      session.setAttribute("PROF_NO", person_num);
	      Prof prof = new Prof();
	      prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	      prof.setTerm_cd(session.getAttribute("TERM_CD").toString());
	      prof.setProf_no(person_num);
	      session.setAttribute("PROF_INFO", commonMapper.loginProfInfo(prof));
	      session.setAttribute("USER_INFO", commonMapper.loginProfInfo(prof));
	      //List<String> hsuInfoList = commonMapper.loginHsuInfo(prof.getProf_no());
	      //session.setAttribute("HSU_INFO", hsuInfoList);
	      //session.setAttribute("HSU_INFO_SIZE", hsuInfoList.size());
	    }else if(reg_type_cd.equals("[ROLE_STUDENT]")){
	      session.setAttribute("STUDENT_NO", person_num);
	      Student student = new Student();
	      student.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	      student.setTerm_cd(session.getAttribute("TERM_CD").toString());
	      student.setStudent_no(person_num);
	      session.setAttribute("STUDENT_INFO", commonMapper.loginStudentInfo(student));
	      session.setAttribute("USER_INFO", commonMapper.loginStudentInfo(student));
	      //List<String> hsuInfoList = commonMapper.loginHsuInfo(student.getStudent_no());
	      //session.setAttribute("HSU_INFO", hsuInfoList);
	      //session.setAttribute("HSU_INFO_SIZE", hsuInfoList.size());
	    }

	    session.setAttribute("REG_TYPE_CD", reg_type_cd);
	    session.setAttribute("USER_TYPE", user_type);
	}
	
	@Override
	public void insertLogInfo(String type, String class_cd, String classday, String prof_no, String student_no, String msg) {
		Map<String, Object> logMap = new HashMap<String, Object>();
	
		logMap.put("type", type);
		logMap.put("class_cd", class_cd);			
		logMap.put("classday", classday);			
		logMap.put("prof_no", prof_no);			
		logMap.put("student_no", student_no);
		logMap.put("msg", msg);
		
		commonMapper.insertLogInfo(logMap);
	}
	
	@Override
	public void sendSMS(Map<String, Object> map) {
		
		String smsType = map.get("sms_type").toString();  
		
		// 휴강승인 시
		if(smsType != null && (smsType.equalsIgnoreCase("CLASSOFF") || 
								smsType.equalsIgnoreCase("CLASSOFFCANCEL") || 
								smsType.equalsIgnoreCase("CLASSADDCANCEL"))) {
			// SMS 전송 설정이 되어 있는 경우 
			if(globalMakeupLessonSMS != null && globalMakeupLessonSMS.equalsIgnoreCase("Y")) {
				String[] classCd	= map.get("class_cd").toString().split("\\|");
				
				map.put("subject_cd", classCd[3]);
				map.put("subject_div_cd", classCd[4]);
				
				commonMapper.sendSMS(map);
			}		
		}
	}

	@Override
	public Collection<Classhour> getClasshourInfo(Map<String, Object> map) {
		return commonMapper.getClasshourInfo(map);
	}
}
