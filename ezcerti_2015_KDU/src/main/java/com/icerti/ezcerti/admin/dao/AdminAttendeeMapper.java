package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;

public interface AdminAttendeeMapper {

	int getAttendeeListCount(Map<String, Object> map);
	int getLectureListCount(Map<String, Object> map);
	Collection<Student> getAttendeeList(Map<String, Object> map);
	Collection<Lecture> getLectureList(Map<String, Object> map);
	Lecture getLecture(Map<String, Object> map);
	Attendmaster getAttendMaster(Map<String, Object> map);
	Map<String, Object> getAttendeeListStatus(Map<String, Object> map);
}
