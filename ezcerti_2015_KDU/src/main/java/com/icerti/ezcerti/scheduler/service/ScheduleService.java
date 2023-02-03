package com.icerti.ezcerti.scheduler.service;

public interface ScheduleService {

	void checkClassStatus();
	void checkConseClassAttend();
	void endedClassAttendeeProc();
	void gonghuilProc();
	void gonggyulProc();	
	void syncInitDataProc();
	void syncUserInfoProc();
	void syncClassInfoProc();
	void syncHyuBogangInfoProc();

	void dataSyncProc(String syncType);
  
}
