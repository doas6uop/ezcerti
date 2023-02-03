package com.icerti.ezcerti.common.dao;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Codemaster;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.domain.Univ;

public interface CommonMapper {
	
	Univ getCurrentTerm(Univ univ);
	Univ getActivityTerm(Univ univ);
	Univ getLastTerm(Univ univ);

	Collection<Univ> getTermList(String univ_cd);

	Collection<Coll> getCollList(Map<String, Object> map);

	Collection<Dept> getDeptList(Map<String, Object> map);

	List<String> loginHsuInfo(String person_num);

	Collection<Univ> getProfTermList(Map<String, Object> map);

	UserInfo getUserInfo(UserInfo user);
	UserInfo getUserInfo(Map<String, Object> map);
	UserInfo loginUserInfo(UserInfo user);
	UserInfo findUserPassword(UserInfo user);
	void updateUserPassword(UserInfo user);

	Integer isUninterruptLecture(Map<String, Object> map);

	List<UserInfo> getLoginUserInfo(Map<String, Object> map);

	// 2014.12.26 
	// - getUserInfo로 대체
	Prof getProfInfo(Prof prof);

	// 2014.12.26 
	// - getUserInfo로 대체
	Student getStudentInfo(Map<String, Object> map);

	Attendmaster getAttendmaster(Map<String, Object> map);

	Collection<Attenddethist> getAttendDetailList(Map<String, Object> map);

	Collection<Codemaster> getCode(String code_grp_cd);

	Collection<Univ> getStudentTermList(Map<String, Object> map);

	Lecture getLectureDetail(Map<String, Object> map);

	Timestamp getCurrentTime();

	String getCurrentTime_HH24();
	
	String getCurrentDate();

	Univ getUniv(Map<String, Object> map);

	Classday getClassday(Map<String, Object> map);

	Collection<Prof> getProf(Map<String, Object> map);

	// 2014.12.26 
	// - loginUserInfo로 대체
	Admin loginAdminInfo(Admin admin);

	// 2014.12.26 
	// - loginUserInfo로 대체
	Prof loginProfInfo(Prof prof);

	// 2014.12.26 
	// - loginUserInfo로 대체
	Student loginStudentInfo(Student student);

	// 2014.12.26 
	// - findUserPassword로 대체  
	Student findStudentPassword(Student student);

	// 2014.12.26 
	// - updateUserPassword로 대체  
	void updateStudentPassword(Student student);

	// 2014.12.26 
	// - findUserPassword로 대체  
	Prof findProfPassword(Prof prof);

	// 2014.12.26 
	// - updateUserPassword로 대체  
	void updateProfPassword(Prof prof);

	int getClasstime(Map<String, Object> map);
	
	Classhour checkClasstime(Classhour classhour);

	Attenddethist getAttenddethist(Map<String, Object> map);

	String getPersonNum(String user_id);
	String getPersonNumOfLogin(Map<String, Object> map);
	String getUserIdFromPersonNum(String person_num);
	UserInfo getUserLoinInfo(Map<String, Object> map);

	void insertLogInfo(Map<String, Object> map);

	// SMS 전송
	void sendSMS(Map<String, Object> map);
	
	Collection<Classhour> getClasshourInfo(Map<String, Object> map);
}
