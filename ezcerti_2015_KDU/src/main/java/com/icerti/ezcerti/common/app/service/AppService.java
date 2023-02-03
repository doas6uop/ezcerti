package com.icerti.ezcerti.common.app.service;

import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.AttendmasterApp;
import com.icerti.ezcerti.domain.UnivApp;
import com.icerti.ezcerti.domain.Attendmaster;

public interface AppService {
	
	List<UnivApp> getUnivList(Map<String, Object> map);
	String checkStudentNo(Map<String, Object> map);
	List<AttendmasterApp> getCurrentClass(Map<String, Object> map);
	Attendmaster getAttendmaster(Map<String, Object> map);
	String getClassCertNo(Map<String, Object> map);
	int checkStudentAttend(Map<String, Object> map);
	
	void insertAppExec(Map<String, Object> map);
	void updateAppStatus(Map<String, Object> map);
	int selectAppExec(Map<String, Object> map);

	int getEnableBeaconCount(String uuid, List<String> lstBeacon);
	void insertCertBeaconInfo(Map<String, Object> map);
	int selectCertBeaconInfo(Map<String, Object> map);
	void updateCertBeaconInfo(Map<String, Object> map);
}
