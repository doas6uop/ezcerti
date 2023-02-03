package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Student;

public interface AdminStatsMapper {

	Collection<String> getAdminStatsAttendStatus(Map<String, Object> map);

	int getAdminStatsAttendStatusCount(Map<String, Object> map);

	List<Object> getAdminStatsAttendStatusExcel(Map<String, Object> map);

	Collection<String> getAdminStatsTerm(Map<String, Object> map);

	int getAdminStatsStudentStatusCount(Map<String, Object> map);

	List<Student> selectClassNumFromAttendAbsentHigher(Map<String, Object> map);
	
	Collection<String> getAdminStatsStudentStatus(Map<String, Object> map);

	List<Object> getAdminStatsStudentStatusExcel(Map<String, Object> map);

	Collection<String> getAdminStatsProf(Map<String, Object> map);

	int getAdminStatsProfCount(Map<String, Object> map);

	List<Object> getAdminStatsProfExcel(Map<String, Object> map);

	// 학사팀 통계(2015.04.07)
	int getAdminAcademicStatsCount(Map<String, Object> map);
	Collection<String> getAdminAcademicStats(Map<String, Object> map);

	// 학사팀 교수 통계(2015.04.07)
	Map<String, Object> getLectureDetail(Map<String, Object> map);
	int getLectureCount(Map<String, Object> map);
	Collection<String> getAdminAcademicProfClassStats(Map<String, Object> map);

	// 결강현황(2015.04.16)
	int getAdminCancelClassListCount(Map<String, Object> map);
	Collection<Attendmaster> getAdminCancelClassList(Map<String, Object> map);

	// 결석현황(2015.04.16)
	int getAdminAbsenceListCount(Map<String, Object> map);
	Collection<Student> getAdminAbsenceList(Map<String, Object> map);
	int getAdminAbsenceListExcelCount(Map<String, Object> map);
	Collection<Student> getAdminAbsenceListExcel(Map<String, Object> map);
	
	// 교수별 사용 통계(2015.10.29)
	int getAdminProfUsageStatsCount(Map<String, Object> map);
	Collection<String> getAdminProfUsageStats(Map<String, Object> map);			
	
}
