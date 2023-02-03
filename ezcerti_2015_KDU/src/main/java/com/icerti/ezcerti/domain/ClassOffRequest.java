package com.icerti.ezcerti.domain;

import java.sql.Date;

public class ClassOffRequest {
	private String row_no;
	private String req_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String subject_cd;
	private String subject_div_cd;
	private String prof_no;
	private String class_cd;
	private Date classday;
	private String classday_no;
	private String classhour_start_time;
	private String classhour_end_time;
	private String class_name;
	private String classday_name;
	private String prof_name;
	private Date add_classday;
	private String add_classday_no;
	private String add_classhour_start_time;
	private String add_classhour_end_time;
	private String add_classday_name;
	private String add_classroom_no;	
	private Date req_date;
	private String req_reason;
	private Date proc_date;
	private String proc_status;
	private String proc_status_nm;
	private String proc_reason;
	private String reserve_seq;
	
	private String classoff_flag;
	private String sayu;
	
	/* 교수 연락처 추가 */
	private String hp_no;
	
	public ClassOffRequest() {
		super();
	}
	
	public String getHp_no() {
		return hp_no;
	}

	public void setHp_no(String hp_no) {
		this.hp_no = hp_no;
	}

	public String getClassoff_flag() {
		return classoff_flag;
	}

	public void setClassoff_flag(String classoff_flag) {
		this.classoff_flag = classoff_flag;
	}

	public String getSayu() {
		return sayu;
	}

	public void setSayu(String sayu) {
		this.sayu = sayu;
	}

	public String getRow_no() {
		return row_no;
	}
	
	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}
	
	public String getReq_no() {
		return req_no;
	}
	
	public void setReq_no(String req_no) {
		this.req_no = req_no;
	}
	
	public String getUniv_cd() {
		return univ_cd;
	}
	
	public void setUniv_cd(String univ_cd) {
		this.univ_cd = univ_cd;
	}
	
	public String getYear() {
		return year;
	}
	
	public void setYear(String year) {
		this.year = year;
	}
	
	public String getTerm_cd() {
		return term_cd;
	}
	
	public void setTerm_cd(String term_cd) {
		this.term_cd = term_cd;
	}
	
	public String getSubject_cd() {
		return subject_cd;
	}
	
	public void setSubject_cd(String subject_cd) {
		this.subject_cd = subject_cd;
	}
	
	public String getSubject_div_cd() {
		return subject_div_cd;
	}
	
	public void setSubject_div_cd(String subject_div_cd) {
		this.subject_div_cd = subject_div_cd;
	}
	
	public String getProf_no() {
		return prof_no;
	}
	
	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
	}
	
	public String getClass_cd() {
		return class_cd;
	}
	
	public void setClass_cd(String class_cd) {
		this.class_cd = class_cd;
	}
	
	public Date getClassday() {
		return classday;
	}
	
	public void setClassday(Date classday) {
		this.classday = classday;
	}
	
	public String getClassday_no() {
		return classday_no;
	}
	
	public void setClassday_no(String classday_no) {
		this.classday_no = classday_no;
	}
	
	public String getClasshour_start_time() {
		return classhour_start_time;
	}
	
	public void setClasshour_start_time(String classhour_start_time) {
		this.classhour_start_time = classhour_start_time;
	}
	
	public String getClasshour_end_time() {
		return classhour_end_time;
	}
	
	public void setClasshour_end_time(String classhour_end_time) {
		this.classhour_end_time = classhour_end_time;
	}
	
	public String getClass_name() {
		return class_name;
	}
	
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	
	public String getClassday_name() {
		return classday_name;
	}
	
	public void setClassday_name(String classday_name) {
		this.classday_name = classday_name;
	}
	
	public String getProf_name() {
		return prof_name;
	}
	
	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}
	
	public Date getAdd_classday() {
		return add_classday;
	}

	public void setAdd_classday(Date add_classday) {
		this.add_classday = add_classday;
	}

	public String getAdd_classday_no() {
		return add_classday_no;
	}

	public void setAdd_classday_no(String add_classday_no) {
		this.add_classday_no = add_classday_no;
	}

	public String getAdd_classhour_start_time() {
		return add_classhour_start_time;
	}

	public void setAdd_classhour_start_time(String add_classhour_start_time) {
		this.add_classhour_start_time = add_classhour_start_time;
	}

	public String getAdd_classhour_end_time() {
		return add_classhour_end_time;
	}

	public void setAdd_classhour_end_time(String add_classhour_end_time) {
		this.add_classhour_end_time = add_classhour_end_time;
	}

	public String getAdd_classday_name() {
		return add_classday_name;
	}

	public void setAdd_classday_name(String add_classday_name) {
		this.add_classday_name = add_classday_name;
	}

	public String getAdd_classroom_no() {
		return add_classroom_no;
	}

	public void setAdd_classroom_no(String add_classroom_no) {
		this.add_classroom_no = add_classroom_no;
	}

	public Date getReq_date() {
		return req_date;
	}
	
	public void setReq_date(Date req_date) {
		this.req_date = req_date;
	}
	
	public String getReq_reason() {
		return req_reason;
	}
	
	public void setReq_reason(String req_reason) {
		this.req_reason = req_reason;
	}
	
	public Date getProc_date() {
		return proc_date;
	}
	
	public void setProc_date(Date proc_date) {
		this.proc_date = proc_date;
	}
	
	public String getProc_status() {
		return proc_status;
	}
	
	public void setProc_status(String proc_status) {
		this.proc_status = proc_status;
	}

	public String getProc_status_nm() {
		return proc_status_nm;
	}

	public void setProc_status_nm(String proc_status_nm) {
		this.proc_status_nm = proc_status_nm;
	}

	public String getProc_reason() {
		return proc_reason;
	}
	
	public void setProc_reason(String proc_reason) {
		this.proc_reason = proc_reason;
	}

	public String getReserve_seq() {
		return reserve_seq;
	}

	public void setReserve_seq(String reserve_seq) {
		this.reserve_seq = reserve_seq;
	}
  
}
