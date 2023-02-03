package com.icerti.ezcerti.student.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.student.dao.StudentMyPageMapper;


@Transactional
@Service
public class StudentMyPageServiceImpl implements StudentMyPageService {

  @Autowired
  private StudentMyPageMapper studentMyPageMapper = null;

  @Override
  public Collection<Attendmaster> getTodayLectureList(Map<String, Object> map) {
    return studentMyPageMapper.getTodayLectureList(map);
  }

  @Override
  public Map<String, Object> getLectureDay(Map<String, Object> map) {
    return studentMyPageMapper.getLectureDay(map);
  }

  @Override
  public Collection<Lecture> getLectureList(Map<String, Object> map) {
    return studentMyPageMapper.getLectureList(map);
  }

  // 결석 수가 특성 수를 초과하는 수강정보 조회 (2015.04.16)
  @Override
  public Collection<Lecture> getAbsenceLectureList(Map<String, Object> map) {
    return studentMyPageMapper.getAbsenceLectureList(map);
  }

}
