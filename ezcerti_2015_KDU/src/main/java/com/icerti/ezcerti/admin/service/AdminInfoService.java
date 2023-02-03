package com.icerti.ezcerti.admin.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Classroom;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Gonggyul;
import com.icerti.ezcerti.domain.ClassoffManage;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.util.PageBean;

public interface AdminInfoService {
	PageBean<Admin> getAdminList(Map<String, Object> map);
	Map<String, Object> getAdminView(Map<String, Object> map);
	Collection<Coll> getColl(Map<String, Object> map);
	Collection<Dept> getDept(Map<String, Object> map);
	String getCollName(Map<String, Object> map);
	String getDeptName(Map<String, Object> map);
	void updateAdminInfo(Admin admin);
	void deleteAdminInfo(Admin admin);
	void insertAdminInfo(Admin admin);
	int getAdminChk(Map<String, Object> map);
	
	/* 강의실관리 */
	PageBean<Classroom> getClassroomReservedList(Map<String, Object> map);
	void insertClassroomReserveInfo(Map<String, Object> map);
	void deleteClassroomReserveInfo(Map<String, Object> map);
	
	/* 공결관리 */
	PageBean<Gonggyul> getGonggyulList(Map<String, Object> map);
	boolean duplicationGonggyul(Gonggyul gonggyul);
	Collection<Gonggyul> getGonggyulClassnameList(Map<String, Object> map);
	void gonggyulInsertOk(Gonggyul gonggyul);
	Gonggyul gonggyulView(String gonggyul_no);
	void gonggyulModifyOk(Gonggyul gonggyul);
	void gonggyulDelete(String chk_no);
	
	/* 일괄휴강관리 */
	PageBean<ClassoffManage> getClassoffManageList(Map<String, Object> map);
	boolean duplicationClassoffManage(ClassoffManage classoffManage);
	void classoffManageInsertOk(ClassoffManage classoffManage);
	ClassoffManage classoffManageView(String classoffmanage_no);
	void classoffManageModifyOk(ClassoffManage classoffManage);
	void classoffManageDelete(String chk_no);
	void classoffManagePerform(String chk_no);

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
