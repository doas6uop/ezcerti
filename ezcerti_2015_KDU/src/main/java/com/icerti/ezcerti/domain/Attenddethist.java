package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Attenddethist {
	
  private String row_no;
  private String univ_cd;
  private String year;
  private String term_cd;
  private String subject_cd;
  private String subject_div_cd;
  private String classday_no;
  private String classhour_start_time;
  private String classhour_end_time;
  private String prof_no;
  private String class_cd;
  private Date classday;
  private String student_no;
  private String student_name;
  private String student_coll_name;
  private String student_dept_name;
  private String class_type_cd;
  private String attend_sts_cd;
  private String attend_auth_cd;
  private String attend_auth_reason_cd;
  private Timestamp attend_proc_time;
  private Timestamp attend_auth_proc_time;
  private Timestamp before_classday;
  private String reg_type_cd;
  private String reg_etc;
  private Timestamp reg_date;
  
  private String attend_sts_name;
  private String attend_auth_name;
  private String attend_auth_reason_name;
 
  private String class_type_name; 
  private String class_sts_name; 
  private String cert_sts_name;
  
  private String ipaddr;
  private String curr_week;
  private String is_team;

  private String student_sts_cd;
  private String status_change_date;
  private String abs_cnt;
  private String iphak_year;
  private String student_img;

  public Attenddethist() {
	super();
	// TODO Auto-generated constructor stub
  }

	public Attenddethist(String row_no, String univ_cd, String year,
			String term_cd, String subject_cd, String subject_div_cd,
			String classday_no, String classhour_start_time,
			String classhour_end_time, String prof_no, String class_cd,
			Date classday, String student_no, String student_name,
			String student_coll_name, String student_dept_name,
			String class_type_cd, String attend_sts_cd, String attend_auth_cd,
			String attend_auth_reason_cd, Timestamp attend_proc_time,
			Timestamp attend_auth_proc_time, Timestamp before_classday,
			String reg_type_cd, String reg_etc, Timestamp reg_date,
			String attend_sts_name, String attend_auth_name,
			String attend_auth_reason_name, String class_type_name,
			String class_sts_name, String cert_sts_name, String ipaddr,
			String curr_week, String is_team, String student_sts_cd,
			String status_change_date, String abs_cnt, String iphak_year,
			String student_img) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.classday_no = classday_no;
		this.classhour_start_time = classhour_start_time;
		this.classhour_end_time = classhour_end_time;
		this.prof_no = prof_no;
		this.class_cd = class_cd;
		this.classday = classday;
		this.student_no = student_no;
		this.student_name = student_name;
		this.student_coll_name = student_coll_name;
		this.student_dept_name = student_dept_name;
		this.class_type_cd = class_type_cd;
		this.attend_sts_cd = attend_sts_cd;
		this.attend_auth_cd = attend_auth_cd;
		this.attend_auth_reason_cd = attend_auth_reason_cd;
		this.attend_proc_time = attend_proc_time;
		this.attend_auth_proc_time = attend_auth_proc_time;
		this.before_classday = before_classday;
		this.reg_type_cd = reg_type_cd;
		this.reg_etc = reg_etc;
		this.reg_date = reg_date;
		this.attend_sts_name = attend_sts_name;
		this.attend_auth_name = attend_auth_name;
		this.attend_auth_reason_name = attend_auth_reason_name;
		this.class_type_name = class_type_name;
		this.class_sts_name = class_sts_name;
		this.cert_sts_name = cert_sts_name;
		this.ipaddr = ipaddr;
		this.curr_week = curr_week;
		this.is_team = is_team;
		this.student_sts_cd = student_sts_cd;
		this.status_change_date = status_change_date;
		this.abs_cnt = abs_cnt;
		this.iphak_year = iphak_year;
		this.student_img = student_img;
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
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

	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public String getStudent_coll_name() {
		return student_coll_name;
	}

	public void setStudent_coll_name(String student_coll_name) {
		this.student_coll_name = student_coll_name;
	}

	public String getStudent_dept_name() {
		return student_dept_name;
	}

	public void setStudent_dept_name(String student_dept_name) {
		this.student_dept_name = student_dept_name;
	}

	public String getClass_type_cd() {
		return class_type_cd;
	}

	public void setClass_type_cd(String class_type_cd) {
		this.class_type_cd = class_type_cd;
	}

	public String getAttend_sts_cd() {
		return attend_sts_cd;
	}

	public void setAttend_sts_cd(String attend_sts_cd) {
		this.attend_sts_cd = attend_sts_cd;
	}

	public String getAttend_auth_cd() {
		return attend_auth_cd;
	}

	public void setAttend_auth_cd(String attend_auth_cd) {
		this.attend_auth_cd = attend_auth_cd;
	}

	public String getAttend_auth_reason_cd() {
		return attend_auth_reason_cd;
	}

	public void setAttend_auth_reason_cd(String attend_auth_reason_cd) {
		this.attend_auth_reason_cd = attend_auth_reason_cd;
	}

	public Timestamp getAttend_proc_time() {
		return attend_proc_time;
	}

	public void setAttend_proc_time(Timestamp attend_proc_time) {
		this.attend_proc_time = attend_proc_time;
	}

	public Timestamp getAttend_auth_proc_time() {
		return attend_auth_proc_time;
	}

	public void setAttend_auth_proc_time(Timestamp attend_auth_proc_time) {
		this.attend_auth_proc_time = attend_auth_proc_time;
	}

	public Timestamp getBefore_classday() {
		return before_classday;
	}

	public void setBefore_classday(Timestamp before_classday) {
		this.before_classday = before_classday;
	}

	public String getReg_type_cd() {
		return reg_type_cd;
	}

	public void setReg_type_cd(String reg_type_cd) {
		this.reg_type_cd = reg_type_cd;
	}

	public String getReg_etc() {
		return reg_etc;
	}

	public void setReg_etc(String reg_etc) {
		this.reg_etc = reg_etc;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public String getAttend_sts_name() {
		return attend_sts_name;
	}

	public void setAttend_sts_name(String attend_sts_name) {
		this.attend_sts_name = attend_sts_name;
	}

	public String getAttend_auth_name() {
		return attend_auth_name;
	}

	public void setAttend_auth_name(String attend_auth_name) {
		this.attend_auth_name = attend_auth_name;
	}

	public String getAttend_auth_reason_name() {
		return attend_auth_reason_name;
	}

	public void setAttend_auth_reason_name(String attend_auth_reason_name) {
		this.attend_auth_reason_name = attend_auth_reason_name;
	}

	public String getClass_type_name() {
		return class_type_name;
	}

	public void setClass_type_name(String class_type_name) {
		this.class_type_name = class_type_name;
	}

	public String getClass_sts_name() {
		return class_sts_name;
	}

	public void setClass_sts_name(String class_sts_name) {
		this.class_sts_name = class_sts_name;
	}

	public String getCert_sts_name() {
		return cert_sts_name;
	}

	public void setCert_sts_name(String cert_sts_name) {
		this.cert_sts_name = cert_sts_name;
	}

	public String getIpaddr() {
		return ipaddr;
	}

	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}

	public String getCurr_week() {
		return curr_week;
	}

	public void setCurr_week(String curr_week) {
		this.curr_week = curr_week;
	}

	public String getIs_team() {
		return is_team;
	}

	public void setIs_team(String is_team) {
		this.is_team = is_team;
	}

	public String getStudent_sts_cd() {
		return student_sts_cd;
	}

	public void setStudent_sts_cd(String student_sts_cd) {
		this.student_sts_cd = student_sts_cd;
	}

	public String getStatus_change_date() {
		return status_change_date;
	}

	public void setStatus_change_date(String status_change_date) {
		this.status_change_date = status_change_date;
	}

	public String getAbs_cnt() {
		return abs_cnt;
	}

	public void setAbs_cnt(String abs_cnt) {
		this.abs_cnt = abs_cnt;
	}

	public String getIphak_year() {
		return iphak_year;
	}

	public void setIphak_year(String iphak_year) {
		this.iphak_year = iphak_year;
	}

	public String getStudent_img() {
		return student_img;
	}

	public void setStudent_img(String student_img) {
		this.student_img = student_img;
	}

	@Override
	public String toString() {
		return "Attenddethist [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", year=" + year + ", term_cd=" + term_cd + ", subject_cd="
				+ subject_cd + ", subject_div_cd=" + subject_div_cd
				+ ", classday_no=" + classday_no + ", classhour_start_time="
				+ classhour_start_time + ", classhour_end_time="
				+ classhour_end_time + ", prof_no=" + prof_no + ", class_cd="
				+ class_cd + ", classday=" + classday + ", student_no="
				+ student_no + ", student_name=" + student_name
				+ ", student_coll_name=" + student_coll_name
				+ ", student_dept_name=" + student_dept_name
				+ ", class_type_cd=" + class_type_cd + ", attend_sts_cd="
				+ attend_sts_cd + ", attend_auth_cd=" + attend_auth_cd
				+ ", attend_auth_reason_cd=" + attend_auth_reason_cd
				+ ", attend_proc_time=" + attend_proc_time
				+ ", attend_auth_proc_time=" + attend_auth_proc_time
				+ ", before_classday=" + before_classday + ", reg_type_cd="
				+ reg_type_cd + ", reg_etc=" + reg_etc + ", reg_date="
				+ reg_date + ", attend_sts_name=" + attend_sts_name
				+ ", attend_auth_name=" + attend_auth_name
				+ ", attend_auth_reason_name=" + attend_auth_reason_name
				+ ", class_type_name=" + class_type_name + ", class_sts_name="
				+ class_sts_name + ", cert_sts_name=" + cert_sts_name
				+ ", ipaddr=" + ipaddr + ", curr_week=" + curr_week
				+ ", is_team=" + is_team + ", student_sts_cd=" + student_sts_cd
				+ ", status_change_date=" + status_change_date + ", abs_cnt="
				+ abs_cnt + ", iphak_year=" + iphak_year + ", student_img="
				+ student_img + "]";
	}
}
