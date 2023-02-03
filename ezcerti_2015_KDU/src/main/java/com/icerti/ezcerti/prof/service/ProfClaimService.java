package com.icerti.ezcerti.prof.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.util.PageBean;

public interface ProfClaimService {


 PageBean<Claim> getProfClaimList(Map<String, Object> map);
 
 PageBean<Claim> getProfImproveList(Map<String, Object> map);

 Claim getProfClaimView(Claim claim);
 
 Claim getProfImproveView(Claim claim);

 String getClassInfoFlag(Map<String, Object> map);
 
 String claimConfirm(Attendmaster attendmaster, Attenddethist attenddethist, Claim claim, String resClassFlag);

}
