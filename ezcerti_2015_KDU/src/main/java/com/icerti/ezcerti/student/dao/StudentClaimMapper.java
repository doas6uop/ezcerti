package com.icerti.ezcerti.student.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Claim;

public interface StudentClaimMapper {

  void insertStudentAttendClaim(Claim claim);
  
  void insertStudentAttendImprove(Claim claim);

  void deleteStudentAttendImprove(Claim claim);
  
  Collection<Claim> getStudentClaimList(Map<String, Object> map);

  int getStudentClaimListCount(Map<String, Object> map);

  Claim getStudentClaimView(Claim claim);
  
  int getStudentImproveListCount(Map<String, Object> map);
  
  Collection<Claim> getStudentImproveList(Map<String, Object> map);

  Claim getStudentImproveView(Claim claim);

}
