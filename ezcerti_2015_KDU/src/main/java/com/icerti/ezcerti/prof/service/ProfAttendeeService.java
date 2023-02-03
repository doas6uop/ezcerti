package com.icerti.ezcerti.prof.service;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;

public interface ProfAttendeeService {

  PageBean<Student> getProfAttendeeList(Map<String, Object> map);

  Collection<Attenddethist> getAttendDetailList(Map<String, Object> map);

  Lecture getLectureDetail(Map<String, Object> map);

}
