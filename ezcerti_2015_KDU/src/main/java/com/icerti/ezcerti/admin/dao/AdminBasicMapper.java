package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Subject;
import com.icerti.ezcerti.domain.Univ;


public interface AdminBasicMapper {

	Univ getUnivInfo(Univ univ);
	Collection<Coll> getCollInfo(Map<String, Object> map);
	int getCollInfoCount(Map<String, Object> map);
	Collection<Dept> getDeptInfo(Map<String, Object> map);
	int getDeptInfoCount(Map<String, Object> map);
	Collection<Subject> getSubjectInfo(Map<String,Object> map);
	int getSubjectInfoCount(Map<String, Object> map);
	Collection<Classday> getClassdayInfo(Map<String, Object> map);
	int getClassdayInfoCount(Map<String, Object> map);
	Collection<Classhour> getClasshourInfo(Classhour classhour);
	Univ getTermEnd(Univ univ);
	void updateUnivTerm(Univ univ);
	void updateProfTerm(Univ univ);
}
