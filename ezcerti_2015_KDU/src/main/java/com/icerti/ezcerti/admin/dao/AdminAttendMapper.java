package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;

public interface AdminAttendMapper {
  Collection<Attendmaster> getAdminAttendList(Map<String, Object> map);
  int getAdminAttendListCount(Map<String, Object> map);
  Collection<Attendmaster> getAdminAttendListAll(Map<String, Object> map);
  int getAdminAttendListAllCount(Map<String, Object> map);
  
  void setClearAttend(Map<String,Object> map);
}
