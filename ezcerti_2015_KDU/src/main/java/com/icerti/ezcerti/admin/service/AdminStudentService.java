package com.icerti.ezcerti.admin.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;

public interface AdminStudentService {

  PageBean<Student> getStudentList(Map<String, Object> map);

  String updateStudentOff(Map<String, Object> map);

  String updateStudentQuit(Map<String, Object> map);

  void initStudentCertCount(String student_no);
  
}
