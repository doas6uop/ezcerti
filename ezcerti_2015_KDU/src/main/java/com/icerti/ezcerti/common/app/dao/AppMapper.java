package com.icerti.ezcerti.common.app.dao;

import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.AttendmasterApp;
import com.icerti.ezcerti.domain.UnivApp;

public interface AppMapper {

	List<UnivApp> getUnivList(Map<String, Object> map);
	String checkStudentNo(Map<String, Object> map);
	List<AttendmasterApp> getCurrentClass(Map<String, Object> map);
	Attendmaster getAttendmaster(Map<String, Object> map);
	String getClassCertNo(Map<String, Object> map);
	int checkStudentAttend(Map<String, Object> map);
	
	void insertAppExec(Map<String, Object> map);
	void updateAppStatus(Map<String, Object> map);
	int selectAppExec(Map<String, Object> map);
	
	int getEnableBeaconCount(Map<String, Object> map);
	void insertCertBeaconInfo(Map<String, Object> map);
	int selectCertBeaconInfo(Map<String, Object> map);
	void updateCertBeaconInfo(Map<String, Object> map);	
	List<String> getEnableBeaconList(Map<String, Object> map);
	
	void insertStudentCert(Map<String, Object> map);
	int checkStudentCertCount(Map<String, Object> map);
}
