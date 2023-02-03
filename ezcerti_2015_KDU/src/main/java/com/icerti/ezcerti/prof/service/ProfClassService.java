package com.icerti.ezcerti.prof.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.AttendAppInfo;
import com.icerti.ezcerti.domain.AttendBatch;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.ClassOffRequest;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Classroom;
import com.icerti.ezcerti.util.PageBean;

public interface ProfClassService {

  PageBean<Attendmaster> getAttendmasterList(Map<String, Object> map);

  void updateClassCert(Map<String, Object> map);

  Collection<Classhour> getClasshourList(Map<String, Object> map);
  Collection<Classroom> getClassroomList(Map<String, Object> map);
  Collection<Classroom> getClassroomList2(Map<String, Object> map);

  String classOff(Map<String, Object> map);
  String classOffRequest(Map<String, Object> map);
  String classOffConfirm(ClassOffRequest classOffRequest, Map<String, Object> map);
  String classOffCancel(Map<String, Object> map);
  
  void updateProfAttendAuthoiry(ArrayList<Attenddethist> attendUpdateList);

  Map<String, Object> getClassAttendDetailList(Map<String, Object> map);

  String addClass(Map<String, Object> map);

  Attendmaster checkClass(Map<String, Object> map);

  Collection<Attendmaster> getCopyAttendList(Map<String, Object> map);

  String copyClass(Map<String, Object> map);

  ArrayList<AttendBatch> getBatchList(Map<String, Object> map);

  String profAttendBatch(Map<String, Object> map);

  Attendmaster getCurrentRestoreClass(Map<String, Object> map);

  Attendmaster getBeforeRestoreClass(Map<String, Object> map);

  String restoreClass(Map<String, Object> map);
  String restoreClassRequest(Map<String, Object> map);
  String restoreClassConfirm(ClassOffRequest classOffRequest, Map<String, Object> map);

  // - 출결방식 저장
  void updateClassCertType(Map<String, Object> map);
  // - 출결 앱 상태이상 수강생 조회
  Collection<AttendAppInfo> getAttendAppErrorList(Map<String, Object> map);
  // - 출결 앱 상태별 수 조회
  AttendAppInfo getAttendAppStatusCnt(Map<String, Object> map);  
  
  // 시설물 관리연동 - 빈 신간 강의실 가져오기
  List<Attendmaster> hsu_getSmsInfo(Map<String, Object> map);
  
  // 휴.보강 
  PageBean<Attendmaster> getClassOffApproveList(Map<String, Object> map);
  PageBean<ClassOffRequest> getClassOffRequestList(Map<String, Object> map);
  ClassOffRequest getClassOffRequestView(Map<String, Object> map);

  List<Attendmaster> getAttendeeClassdayList(Map<String, Object> map);
  List<Classhour> getClasshour(Map<String, Object> map);
  List<Classhour> getClasshour2(Map<String, Object> map);
  
  /* 00000강의실 관련 campus_time 조회 */
  String getCampusTime(Map<String, Object> map);
}
