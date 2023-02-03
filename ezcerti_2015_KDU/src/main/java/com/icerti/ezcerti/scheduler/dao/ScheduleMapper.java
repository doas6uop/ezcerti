package com.icerti.ezcerti.scheduler.dao;

public interface ScheduleMapper {

	void checkClassStatus();
	void checkConseClassAttend();
	void endedClassAttendeeProc();
	void gonghuilProc();
	void gonggyulProc();
	void syncInitDataProc();
	void syncUserInfoProc();
	void syncClassInfoProc();
	void syncHyuBogangInfoProc();

	void copyDataProc();
	void syncProc();
}
