package com.icerti.ezcerti.admin.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;

public interface AdminAttendeeService {

	PageBean<Student> getAttendeeList(Map<String, Object> map);
	PageBean<Lecture> getLectureList(Map<String, Object> map);
	Lecture getLecture(Map<String, Object> map);
	Attendmaster getAttendMaster(Map<String, Object> map);
	Map<String, Object> getAttendeeListStatus(Map<String, Object> map);
}
