package com.icerti.ezcerti.admin.service;

import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Log;
import com.icerti.ezcerti.util.PageBean;

public interface AdminStandService {

	int getAdminStandCodeCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandCode(Map<String, Object> map);

	List<Map<String, Object>> getAdminStandDetailCode(Map<String, Object> map);

	int getAdminStandProfCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandProf(Map<String, Object> map);

	int getAdminStandStudentCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandStudent(Map<String, Object> map);

	int getAdminStandYearCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandYear(Map<String, Object> map);

	int getAdminStandClassdayCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandClassday(Map<String, Object> map);

	int getAdminStandOrganizationCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandOrganization(Map<String, Object> map);

	int getAdminStandDetailOrganizationCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandDetailOrganization(Map<String, Object> map);

	int getAdminStandClasshourCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandClasshour(Map<String, Object> map);

	int getAdminStandClassroomCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandClassroom(Map<String, Object> map);

	int getAdminStandDetailClassroomCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandDetailClassroom(Map<String, Object> map);

	int getAdminStandSubjectCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandSubject(Map<String, Object> map);

	int getAdminStandClassCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandClass(Map<String, Object> map);

	int getAdminStandAddinfoCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandAddinfo(Map<String, Object> map);

	int getAdminStandDetailAddinfoCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandDetailAddinfo(Map<String, Object> map);

	int getAdminStandAttendeeCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandAttendee(Map<String, Object> map);

	int getAdminStandDetailAttendeeCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandDetailAttendee(Map<String, Object> map);

	int getAdminStandTargetViewChkCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandTargetViewChk(Map<String, Object> map);

	int getAdminStandTargetViewSelectCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandTargetViewSelect(Map<String, Object> map);

	int getAdminStandTargetViewCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandTargetView(Map<String, Object> map);

	int getAdminStandCopyDataCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandCopyData(Map<String, Object> map);

	int getAdminStandSyncDataCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandSyncData(Map<String, Object> map);

	int initSyncData(String param);
	int backSyncData(Map<String, Object> map);

	int getAdminStandCheckedDataCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandCheckedData(Map<String, Object> map);

	int getAdminStandCloseCheckProfCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandCloseCheckProf(Map<String, Object> map);

	int getAdminStandCloseCheckClassCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminStandCloseCheckClass(Map<String, Object> map);

	int executeCloseDataChangeProf(Map<String, Object> map);
	int executeCloseDataChangeClass(Map<String, Object> map);

	PageBean<Log> getLogList(Map<String, Object> map);

	int getAdminTermEndManageCount(Map<String, Object> map);
	List<Map<String, Object>> getAdminTermEndManage(Map<String, Object> map);

	void executeEndProcAll();
	void executeEndProcPart(Map<String, Object> map);
	
	List<Map<String, Object>> getTransmitDataExcel(Map<String, Object> map);
}
