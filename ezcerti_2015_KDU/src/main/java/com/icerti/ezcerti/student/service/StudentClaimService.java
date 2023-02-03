package com.icerti.ezcerti.student.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.util.PageBean;

public interface StudentClaimService {

  PageBean<Claim> getStudentClaimList(Map<String, Object> map);

  Claim getStudentClaimView(Claim claim);
  
  PageBean<Claim> getStudentImproveList(Map<String, Object> map);
  
  Claim getStudentImproveView(Claim claim);
}
