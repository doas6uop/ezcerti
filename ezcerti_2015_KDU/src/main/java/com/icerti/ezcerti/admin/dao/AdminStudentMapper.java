package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Student;

public interface AdminStudentMapper {

  int getStudentListCount(Map<String, Object> map);

  Collection<Student> getStudentList(Map<String, Object> map);

  Collection<Attenddethist> getStudentAttendList(Map<String, Object> map);

  void updateStudentOffAttendmaster(Attenddethist attenddethist2);

  void updateStudentOffAttenddethist(Map<String, Object> map);

  void updateStudentOffStatus(Map<String, Object> map);

  void updateStudentQuitAttendmaster(Attenddethist attenddethist2);

  void updateStudentQuitStatus(Map<String, Object> map);

  void updateStudentQuitAttenddethist(Map<String, Object> map);
  
  // 2015.01.07 ///////////////////////////
  // - 출결상태별 수를 COUNT후 처리하도록 처리
  void updateStudentOffAttendmasterAddInfo(Attenddethist attenddethist);  

  // 2015.08.27 ///////////////////////////
  // - 학생의 인증횟수 초기화
  void initStudentCertCount(String student_no);

}
