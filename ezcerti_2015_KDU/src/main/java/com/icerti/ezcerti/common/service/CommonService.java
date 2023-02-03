package com.icerti.ezcerti.common.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.domain.UserInfo;

public interface CommonService {
	
  String getCurrentTime_HH24();
	
  // 2014.12.30 
  // - 현재의 학기 조회  
  Univ getCurrentTerm(Univ univ);
	
  Collection<Univ> getTermList(String univ_cd);

  Collection<Univ> getProfTermList(Map<String, Object> map);
  
  Collection<Univ> getStudentTermList(Map<String, Object> map);

  Collection<Coll> getColl(Map<String, Object> map);

  Collection<Dept> getDept(Map<String, Object> map);

  Univ getLastTerm(Univ univ);

  UserInfo getUserInfo(UserInfo user);
  UserInfo getUserInfo(Map<String, Object> map);
  
  List<UserInfo> getLoginUserInfo(Map<String, Object> map);
  
  // 2014.12.26
  // - UserInfo getUserInfo(UserInfo user)로 대체
  Prof getProfInfo(Prof prof);

  // 2014.12.26
  // - UserInfo getUserInfo(UserInfo user)로 대체
  Student getStudentInfo(Map<String, Object> map);

  Attendmaster getAttendmaster(Map<String, Object> map);
  
  Integer isUninterruptLecture(Map<String, Object> map);

  Collection<Attenddethist> getAttendDetailList(Map<String, Object> map);
  
  Collection<Codemaster> getCode(String code_grp_cd);
  
  Lecture getLectureDetail(Map<String, Object> map);

  int getRemainDay(Map<String, Object> map);
  
  int getStartDay(Map<String, Object> map);
  
  Classday getClassday(Map<String, Object> map);

  Collection<Prof> getProf(Map<String, Object> map);

  String passwordLost(Map<String, Object> map);

  String getURL(HttpServletRequest request);

  Admin loginAdminInfo(Admin admin);
  Prof loginProfInfo(Prof prof);
  Student loginStudentInfo(Student student);
  
  int getClasstime(Map<String, Object> map);
  
  Classhour checkClasstime(Classhour classhour);

  List<Object> getExcelObjects(Map<String, Object> map);

  Univ getUniv(Map<String, Object> map);

  Attenddethist getAttenddethist(Map<String, Object> map);
  
  String getPersonNum(String user_id);
  String getPersonNumOfLogin(String user_id, String password, String password1);
  String getUserIdFromPersonNum(String person_num);
  UserInfo getUserLoinInfo(Map<String, Object> map);
  
  void accountChange(String person_num, HttpServletRequest request);
  
  void insertLogInfo(String type, String class_cd, String classday, String prof_no, String student_no, String msg);
  void sendSMS(Map<String, Object> map);
  
  Collection<Classhour> getClasshourInfo(Map<String, Object> map);
}
