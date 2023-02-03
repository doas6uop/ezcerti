package com.icerti.ezcerti.student.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;



public interface StudentMyPageMapper {

  Collection<Attendmaster> getTodayLectureList(Map<String, Object> map);
  Map<String, Object> getLectureDay(Map<String, Object> map);
  Collection<Lecture> getLectureList(Map<String, Object> map);

  // 결석 수가 특성 수를 초과하는 수강정보 조회 (2015.04.16)
  Collection<Lecture> getAbsenceLectureList(Map<String, Object> map);
}
