package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Log;

public interface AdminStandMapper {

	public int getAdminStandCodeCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandCode(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandDetailCode(Map<String, Object> map);

	public int getAdminStandProfCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandProf(Map<String, Object> map);

	public int getAdminStandStudentCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandStudent(Map<String, Object> map);

	public int getAdminStandYearCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandYear(Map<String, Object> map);

	public int getAdminStandClassdayCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandClassday(Map<String, Object> map);

	public int getAdminStandOrganizationCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandOrganization(Map<String, Object> map);

	public int getAdminStandDetailOrganizationCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandDetailOrganization(Map<String, Object> map);

	public int getAdminStandClasshourCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandClasshour(Map<String, Object> map);

	public int getAdminStandClassroomCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandClassroom(Map<String, Object> map);

	public int getAdminStandDetailClassroomCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandDetailClassroom(Map<String, Object> map);

	public int getAdminStandSubjectCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandSubject(Map<String, Object> map);

	public int getAdminStandClassCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandClass(Map<String, Object> map);

	public int getAdminStandAddinfoCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandAddinfo(Map<String, Object> map);

	public int getAdminStandDetailAddinfoCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandDetailAddinfo(Map<String, Object> map);

	public int getAdminStandAttendeeCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandAttendee(Map<String, Object> map);

	public int getAdminStandDetailAttendeeCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandDetailAttendee(Map<String, Object> map);

	public int getAdminStandTargetViewChkCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandTargetViewChk(Map<String, Object> map);

	public int getAdminStandTargetViewSelectCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandTargetViewSelect(Map<String, Object> map);

	public int getAdminStandTargetViewCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandTargetView(Map<String, Object> map);

	public int getAdminStandCopyDataCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandCopyData(Map<String, Object> map);

	public int getAdminStandSyncDataCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandSyncData(Map<String, Object> map);

	public int initSyncData(String param);
	public int backSyncData(Map<String, Object> map);

	public int getAdminStandCheckedDataCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandCheckedData(Map<String, Object> map);

	public int getAdminStandCloseCheckProfCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandCloseCheckProf(Map<String, Object> map);

	public int getAdminStandCloseCheckClassCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminStandCloseCheckClass(Map<String, Object> map);

	public int executeCloseDataChangeProf(Map<String, Object> map);
	public int executeCloseDataChangeClass(Map<String, Object> map);

	public int getLogListCount(Map<String, Object> map);
	public Collection<Log> getLogList(Map<String, Object> map);

	public int getAdminTermEndManageCount(Map<String, Object> map);
	public List<Map<String, Object>> getAdminTermEndManage(Map<String, Object> map);

	public void executeEndProcAll();
	public void executeEndProcPart(Map<String, Object> map);
	
	List<Map<String, Object>> getTransmitDataExcel(Map<String, Object> map);
}
