package com.icerti.ezcerti.admin.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.util.PageBean;

public interface AdminAttendService {
  
   PageBean<Attendmaster> getAdminAttendList(Map<String,Object> map);
   PageBean<Attendmaster> getAdminAttendListAll(Map<String,Object> map);
}
