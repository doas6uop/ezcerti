package com.icerti.ezcerti.prof.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;

public interface ProfAttendeeMapper {

  int getProfAttendeeListCount(Map<String, Object> map);

  Collection<Student> getAttendeeList(Map<String, Object> map);

  Collection<Attenddethist> getAttendDetailList(Map<String, Object> map);

  Lecture getLectureDetail(Map<String, Object> map);


}
