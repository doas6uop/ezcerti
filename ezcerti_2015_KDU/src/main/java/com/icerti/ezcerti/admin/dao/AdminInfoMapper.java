package com.icerti.ezcerti.admin.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Classroom;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Gonggyul;
import com.icerti.ezcerti.domain.ClassoffManage;
import com.icerti.ezcerti.domain.Univ;

public interface AdminInfoMapper {
	 Collection<Admin> getAdminList(Map<String, Object> map);
	 int getAdminListCount(Map<String, Object> map);
	 Admin getAdminView(Map<String, Object> map);
	 Collection<Coll> getCollList(Map<String, Object> map);
	 Collection<Dept> getDeptList(Map<String, Object> map);
	 String getCollName(Map<String, Object> map);
	 String getDeptName(Map<String, Object> map);
	 void updateAdminInfo(Admin admin);
	 void deleteAdminInfo(Admin admin);
	 void insertAdminInfo(Admin admin);
	 int getAdminChk(Map<String, Object> map);
	 
	// 2015.01.09 /////////////////
	// - 학사정보에 관리자 등록 처리
	void insertAdminInfoToInternal(Admin admin);
	// - 학사정보에 관리자 삭제 처리
	void deleteAdminInfoToInternal(Admin admin);
	///////////////////////////////	 
	
	/* 강의실관리 */
	int getClassroomReservedListCount(Map<String, Object> map);
	Collection<Classroom> getClassroomReservedList(Map<String, Object> map);
	void insertClassroomReserveInfo(Map<String, Object> map);
	void deleteClassroomReserveInfo(Map<String, Object> map);
	
	/* 공결관리 */
	int getGonggyulListCount(Map<String, Object> map);
	Collection<Gonggyul> getGonggyulList(Map<String, Object> map);
	int duplicationGonggyul(Gonggyul gonggyul);
	void gonggyulInsertOk(Gonggyul gonggyul);
	String getGonggyulNo(Gonggyul gonggyul);
	void gonggyulSubjectInsertOk(Gonggyul gonggyul);
	Collection<Gonggyul> getGonggyulClassnameList(Map<String, Object> map);
	Gonggyul gonggyulView(String gonggyul_no);
	void gonggyulModifyOk(Gonggyul gonggyul);
	void gonggyulSubjectAllDeleteOk(Gonggyul gonggyul);
	ArrayList<Gonggyul> getSavedGonggyulDataList(Gonggyul gonggyul);
	int getSavedGonggyulInit(Gonggyul gonggyul);
	void gonggyulProc(Gonggyul gonggyul);
	void gonggyulDelete(String chk_no);
	
	/* 일괄휴강관리 */
	int getClassoffManageListCount(Map<String, Object> map);
	Collection<ClassoffManage> getClassoffManageList(Map<String, Object> map);
	int duplicationClassoffManage(ClassoffManage classoffManage);
	void classoffManageInsertOk(ClassoffManage classoffManage);
	ClassoffManage classoffManageView(String classoffmanage_no);
	void classoffManageModifyOk(ClassoffManage classoffManage);
	void classoffManageDelete(String chk_no);
	void classoffManagePerform(String chk_no);
	void classoffManagePerformUpdateFlag();	
	
	/* 연도학기관리 */
	List<Map<String, Object>> univYearGetDayOfWeekCnt(Univ univ);
	void univYearInsertOk(Univ univ);
	Univ univYearView(Map<String, Object> map);
	void univYearModifyOk(Univ univ);
	void univYearStscd(Univ univ);
	void univYearDeleteOkUnivTerm(Map<String, Object> map);
	void univYearDeleteOkClassday(Map<String, Object> map);
	void createClassday(Univ univ);
}
