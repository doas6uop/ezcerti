package com.icerti.ezcerti.prof.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Claim;

public interface ProfClaimMapper {

  int getProfClaimListCount(Map<String, Object> map);
  
  int getProfImproveListCount(Map<String, Object> map);

  Collection<Claim> getProfClaimList(Map<String, Object> map);
  
  Collection<Claim> getProfImproveList(Map<String, Object> map);

  Claim getProfClaimView(Claim claim);
  
  Claim getProfImproveView(Claim claim);

  void updateProfClaim(Claim claim);

  String getClassInfoFlag(Map<String, Object> map);
}
