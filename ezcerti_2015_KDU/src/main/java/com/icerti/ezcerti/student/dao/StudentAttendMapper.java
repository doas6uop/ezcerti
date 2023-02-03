package com.icerti.ezcerti.student.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;



public interface StudentAttendMapper {

  Collection<Attenddethist> getStudentAttendDetailHistoryList(Map<String, Object> map);

  Map<String, Object> getStudentAttendCnt(Map<String, Object> map);

  Attenddethist getStudentAttendDetailHistory(Map<String, Object> map);

  Attendmaster getStudentAttendmaster(Map<String, Object> map);
  
  int getAttendCert(Map<String, Object> map);

  void updateStudentAttendStatus(Map<String, Object> map);

  void updateMasterAttendStatus(Map<String, Object> map);

  // 2015.01.02
  // - TB_ATTENDDETHIST 테이블에 출결정보 등록 처리
  void insertStudentAttendStatus(Map<String, Object> map);

}
