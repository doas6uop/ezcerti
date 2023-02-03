package com.icerti.ezcerti.prof.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.AttendAppInfo;
import com.icerti.ezcerti.domain.AttendBatch;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.ClassOffRequest;
import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Classroom;

public interface ProfClassMapper {

	int getAttendmasterListCount(Map<String, Object> map);

	Collection<Attendmaster> getAttendmasterList(Map<String, Object> map);

	void updateClassCert(Map<String, Object> map);

	Collection<Classhour> getClasshourList(Map<String, Object> map);
	Collection<Classroom> getClassroomList(Map<String, Object> map);
	Collection<Classroom> getClassroomList2(Map<String, Object> map);

	void updateClassoffAttendmaster(Map<String, Object> map);
	void updateClassoffAttenddethist(Map<String, Object> map);

	void insertClassoffAttendmaster(Map<String, Object> map);
	void insertClassoffAttenddethist(Map<String, Object> map);

	void insertClassoffEarlyAttendmaster(Map<String, Object> map);
	void insertClassoffEarlyAttenddethist(Map<String, Object> map);

	Classday getClassday(Map<String, Object> map);

	int checkAlterClass(Map<String, Object> map);

	int updateProfAttendAuthorityAttenddethist(Attenddethist attendStudent);

	void insertProfAttendAuthorityAttenddethist(Attenddethist attendStudent);

	void updateProfAttendAuthorityAttendmaster(Attendmaster attendmaster);

	void insertClassAddAttendmaster(Map<String, Object> map);
	void insertClassAddAttenddethist(Map<String, Object> map);

	void insertClassAddEarlyAttendmaster(Map<String, Object> map);
	void insertClassAddEarlyAttenddethist(Map<String, Object> map);

	Attendmaster checkClass(Map<String, Object> map);

	Collection<Attendmaster> getCopyAttendList(Map<String, Object> map);

	void copyAttendmaster(Attendmaster attendmaster);

	void copyAttenddethist(Attenddethist attenddethist2);

	void deleteExistsAttenddethist(Attendmaster attendmaster);

	Collection<Attenddethist> getBatchAttendeeList(AttendBatch attendBatch);

	ArrayList<AttendBatch> getBatchClassdayList(Map<String, Object> map);

	Collection<Attenddethist> getBatchAttendDetailList(Map<String, Object> map);

	Attendmaster getCurrentRestoreClass(Map<String, Object> map);
	Attendmaster getBeforeRestoreClass(Map<String, Object> map);

	void updateBeforeClassMaster(Map<String, Object> map);
	void updateBeforeClassDetail(Map<String, Object> map);
	void deleteBeforeClassMaster(Map<String, Object> map);
	void deleteBeforeClassDetail(Map<String, Object> map);

	void updateCurrentClassMaster(Map<String, Object> map);
	void updateCurrentClassDetail(Map<String, Object> map);
	void deleteCurrentClassMaster(Map<String, Object> map);
	void deleteCurrentClassDetail(Map<String, Object> map);

	// 2015.01.05 /////////////////
	// - 강의별 출결 수를 조회
	//   : 교수의 강의 출결 상세 정보조회에서 출결상태별 인원수를 처리하기위해 사용
	Attendmaster getProfClassAttendCnt(Attenddethist attenddethist);  
	// - 휴강처리 (학사DB 처리)
	void updateClassoffStatusAttendmaster(Map<String, Object> map);
	// - 보강정보 등록(이후)
	void insertClassoffAttendmasterAddInfo(Map<String, Object> map);
	// - 보강정보 등록(이전)
	void insertClassoffEarlyAttendmasterAddInfo(Map<String, Object> map);
	// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 CLASS_TYPE_CD, CLASS_STS_CD 변경
	void updateBeforeClassMasterAddInfo(Map<String, Object> map);
	// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 보강정보 삭체
	void deleteBeforeClassMasterAddInfo(Map<String, Object> map);
	// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 CLASS_TYPE_CD, CLASS_STS_CD 변경
	void updateCurrentClassMasterAddInfo(Map<String, Object> map);
	// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 보강정보 삭체
	void deleteCurrentClassMasterAddInfo(Map<String, Object> map);
	// - 보강정보 등록 처리 (강의 목록에서 보강 등록 시)
	void insertClassAddAttendmasterAddInfo(Map<String, Object> map);
	// - 보강정보 등록 처리 (강의 목록에서 보강 등록 시)
	void insertClassAddEarlyAttendmasterAddInfo(Map<String, Object> map);
	// - 출결방식 저장
	void updateClassCertType(Map<String, Object> map);
	// - 출결 앱 상태이상 수강생 조회
	Collection<AttendAppInfo> getAttendAppErrorList(Map<String, Object> map);
	// - 출결 앱 상태별 수 조회
	AttendAppInfo getAttendAppStatusCnt(Map<String, Object> map);
	///////////////////////////////

	//시설물 관리연동 - 빈 신간 강의실 가져오기 및 강의실 예약
	Map<String, String> getclassroom(Map<String, Object> map);
	String hsu_getclassroom_no(Map<String, Object> map);
	Map<String, String> hsu_getreservation_status(Map<String, Object> map);
	Map<String, String> hsu_getattendmaster(Map<String, Object> map);
	int hsu_insertreservation_status(Map<String, Object> map);
	int hsu_insertreservation(Map<String, String> map);
	int hsu_updatereservation_status(Map<String, String> map);

	void hsu_deletereservation(Map<String, Object> map);

	List<Attendmaster> hsu_getSmsInfo(Map<String, Object> map);


	int getClassOffApproveListCount(Map<String, Object> map);
	Collection<Attendmaster> getClassOffApproveList(Map<String, Object> map);
	Collection<Attendmaster> getClassOffApproveList2(Map<String, Object> map);

	//휴, 보강 신청목록 (2015.04.21) 
	int getClassOffRequestListCount(Map<String, Object> map);
	int getClassOffLastRequestListCount(Map<String, Object> map);
	Collection<ClassOffRequest> getClassOffRequestList(Map<String, Object> map);
	Collection<ClassOffRequest> getClassOffLastRequestList(Map<String, Object> map);
	// 휴, 보강 신청조회 (2015.04.22) 
	ClassOffRequest getClassOffRequestView(Map<String, Object> map);  
	
	void deleteCurrentClassoffRequest(Map<String, Object> map);
	void deleteBeforeClassoffRequest(Map<String, Object> map);
	void insertClassoffRequest(Map<String, Object> map);
	void deleteClassoffRequest(Map<String, Object> map);

	List<Classhour> getClassHour(Map<String, Object> map);
	List<Classhour> getClassHour2(Map<String, Object> map);
		
	List<Attendmaster> getAttendeeClassdayList(Map<String, Object> map);	
	
	// 휴, 보강 신청시 Attendmaster의 class_prog_cd값을 신청 코드로 변경
	// - 휴강신청(G018C003), 휴강취소신청(G018C004)
	void updateClassoffRequestAttendmaster(Map<String, Object> map);
	void updateClassoffRequestAddAttendmaster(Map<String, Object> map);
	void updateClassoffRequestStatus(Map<String, Object> map);
	void updateClassoffRequestReason(Map<String, Object> map);
	void updateClassoffChangeFlag(Map<String, Object> map);
	
	// 강의실 예약정보 처리
	void insertClasshourReserve(Map<String, Object> map);
	void deleteClasshourReserve(Map<String, Object> map);	
	List<Classhour> getClassroomhour(Map<String, Object> map);
	
	/* 00000강의실 관련 campus_time 조회 */
	String getCampusTime(Map<String, Object> map);
}
