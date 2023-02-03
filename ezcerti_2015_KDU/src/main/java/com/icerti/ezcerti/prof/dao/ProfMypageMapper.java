package com.icerti.ezcerti.prof.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;

public interface ProfMypageMapper {

	Collection<Attendmaster> getTodayLectureList(Map<String, Object> map);

	Map<String, Object> getLectureDay(Map<String, Object> map);

	Collection<Lecture> getLectureList(Map<String, Object> map);

}
