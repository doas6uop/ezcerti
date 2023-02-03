package com.icerti.ezcerti.admin.service;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.util.PageBean;

public interface AdminStatsService {
	
	PageBean<String> getAdminStatsAttendStatus(Map<String, Object> map);

	Collection<String> getAdminStatsTerm(Map<String, Object> map);

	PageBean<String> getAdminStatsStudentStatus(Map<String, Object> map);

	PageBean<String> getAdminStatsProf(Map<String, Object> map);
	
	// 학사팀 통계(대전대 - 2015.03.18)
	PageBean<String> getAdminAcademicStats(Map<String, Object> map);
	
	// 학사팀 교수 통계(대전대 - 2015.03.19)
	Map<String, Object> getLectureDetail(Map<String, Object> map);
	int getLectureCount(Map<String, Object> map);
	Collection<String> getAdminAcademicProfClassStats(Map<String, Object> map);
	
	// 결강현황(2015.04.16)
	PageBean<Attendmaster> getAdminCancelClassList(Map<String, Object> map);

	// 결석현황(2015.04.16)
	PageBean<Student> getAdminAbsenceList(Map<String, Object> map);
	PageBean<Student> getAdminAbsenceListExcel(Map<String, Object> map);
	
	// 교수별 출결 통계(2015.10.29)
	PageBean<String> getAdminProfUsageStats(Map<String, Object> map);		
}
