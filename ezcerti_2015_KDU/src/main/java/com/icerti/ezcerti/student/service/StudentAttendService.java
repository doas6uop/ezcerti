package com.icerti.ezcerti.student.service;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;



public interface StudentAttendService {

  Collection<Attenddethist> getStudentAttendDetailHistoryList(Map<String, Object> map);
  
  Attenddethist getStudentAttendDetailHistory(Map<String, Object> map);

  Map<String, Object> getStudentAttendCnt(Map<String, Object> map);

  String checkStudentCert(Map<String, Object> map);
 
  String studentAttendClaim(Map<String, Object> map);
  
  String studentAttendImprove(Map<String, Object> map);

  String studentAttendImproveDelete(Map<String, Object> map);

}
