package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Attendmaster {
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
  private String class_name;
  private String classday_name;
  private String classhour_name;
  private String prof_name;
  private String prof_coll_name;
  private String prof_dept_name;
  private int attendee_cnt;
  private int attend_proc_cnt;
  private int attend_present_cnt;
  private int attend_late_cnt;
  private int attend_absent_cnt;
  private int attend_off_cnt;
  private int attend_quit_cnt;
  private int attend_auth_cnt;
  private String classroom_no;
  private String class_cert_no;
  private int class_cert_time;
  private Timestamp class_cert_issue_time;
  private String class_prog_cd;
  private String class_type_cd;
  private String class_sts_cd;
  private String cert_sts_cd;
  private String attend_auth_cd;
  private String cert_type;
  private Timestamp before_classday;
  private String reg_type_cd;
  private String reg_etc;
  private Timestamp reg_date;

  private String class_prog_name;
  private String class_type_name;
  private String class_sts_name;
  private String cert_sts_name;
  private String attend_auth_name;
  
  private String is_team;
  private String classoff_yn;
  private String curr_week;

  /* 휴보강 엑셀다운로드2 인자 */
  private Timestamp add_classday;
  private String add_classhour_start_time;
  private String add_classhour_end_time;
  private String add_classroom_no;
  private String chul_flag;
  private String req_reason;
  private String req_class_cd;
  private String req_add_classday;
  private String req_add_classhour_start_time;
  
  /* 교수 연락처 추가 */
  private String hp_no;
  
  private String class_adm_cd;
  private String req_proc_date;
  private String etc_val;
  private String prof_jikjong;
  
  public Attendmaster(String row_no, String univ_cd, String year, String term_cd,
		String subject_cd, String subject_div_cd, String classday_no,
		String classhour_start_time, String classhour_end_time, String prof_no,
		String class_cd, Date classday, String class_name,
		String classday_name, String classhour_name, String prof_name,
		String prof_coll_name, String prof_dept_name, int attendee_cnt,
		int attend_proc_cnt, int attend_present_cnt, int attend_late_cnt,
		int attend_absent_cnt, int attend_off_cnt, int attend_quit_cnt,
		int attend_auth_cnt, String classroom_no, String class_cert_no,
		int class_cert_time, Timestamp class_cert_issue_time,
		String class_prog_cd, String class_type_cd, String class_sts_cd,
		String cert_sts_cd, String attend_auth_cd, String cert_type,
		Timestamp before_classday, String reg_type_cd, String reg_etc,
		Timestamp reg_date, String class_prog_name, String class_type_name,
		String class_sts_name, String cert_sts_name, String attend_auth_name,
		String is_team, String classoff_yn, String curr_week,
		Timestamp add_classday, String add_classhour_start_time,
		String add_classhour_end_time, String add_classroom_no,
		String chul_flag, String req_reason, String req_class_cd,
		String req_add_classday, String req_add_classhour_start_time,
		String hp_no, String class_adm_cd, String req_proc_date, String etc_val, String prof_jikjong) {
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
	this.class_name = class_name;
	this.classday_name = classday_name;
	this.classhour_name = classhour_name;
	this.prof_name = prof_name;
	this.prof_coll_name = prof_coll_name;
	this.prof_dept_name = prof_dept_name;
	this.attendee_cnt = attendee_cnt;
	this.attend_proc_cnt = attend_proc_cnt;
	this.attend_present_cnt = attend_present_cnt;
	this.attend_late_cnt = attend_late_cnt;
	this.attend_absent_cnt = attend_absent_cnt;
	this.attend_off_cnt = attend_off_cnt;
	this.attend_quit_cnt = attend_quit_cnt;
	this.attend_auth_cnt = attend_auth_cnt;
	this.classroom_no = classroom_no;
	this.class_cert_no = class_cert_no;
	this.class_cert_time = class_cert_time;
	this.class_cert_issue_time = class_cert_issue_time;
	this.class_prog_cd = class_prog_cd;
	this.class_type_cd = class_type_cd;
	this.class_sts_cd = class_sts_cd;
	this.cert_sts_cd = cert_sts_cd;
	this.attend_auth_cd = attend_auth_cd;
	this.cert_type = cert_type;
	this.before_classday = before_classday;
	this.reg_type_cd = reg_type_cd;
	this.reg_etc = reg_etc;
	this.reg_date = reg_date;
	this.class_prog_name = class_prog_name;
	this.class_type_name = class_type_name;
	this.class_sts_name = class_sts_name;
	this.cert_sts_name = cert_sts_name;
	this.attend_auth_name = attend_auth_name;
	this.is_team = is_team;
	this.classoff_yn = classoff_yn;
	this.curr_week = curr_week;
	this.add_classday = add_classday;
	this.add_classhour_start_time = add_classhour_start_time;
	this.add_classhour_end_time = add_classhour_end_time;
	this.add_classroom_no = add_classroom_no;
	this.chul_flag = chul_flag;
	this.req_reason = req_reason;
	this.req_class_cd = req_class_cd;
	this.req_add_classday = req_add_classday;
	this.req_add_classhour_start_time = req_add_classhour_start_time;
	this.hp_no = hp_no;
	this.class_adm_cd = class_adm_cd;
	this.req_proc_date = req_proc_date;
	this.etc_val = etc_val;
	this.prof_jikjong = prof_jikjong;
  }

  public Attendmaster() {
    super();
  }

  public String getHp_no() {
	return hp_no;
  }

  public void setHp_no(String hp_no) {
	this.hp_no = hp_no;
  }

  public String getClass_adm_cd() {
	return class_adm_cd;
  }

  public void setClass_adm_cd(String class_adm_cd) {
	this.class_adm_cd = class_adm_cd;
  }

  public String getEtc_val() {
	return etc_val;
  }

  public void setEtc_val(String etc_val) {
	this.etc_val = etc_val;
  }

  public String getChul_flag() {
	return chul_flag;
  }

  public void setChul_flag(String chul_flag) {
	this.chul_flag = chul_flag;
  }

  public String getAdd_classroom_no() {
	return add_classroom_no;
  }

  public void setAdd_classroom_no(String add_classroom_no) {
	this.add_classroom_no = add_classroom_no;
  }

  public String getAdd_classhour_end_time() {
	return add_classhour_end_time;
  }

  public void setAdd_classhour_end_time(String add_classhour_end_time) {
	this.add_classhour_end_time = add_classhour_end_time;
  }

  public String getAdd_classhour_start_time() {
	return add_classhour_start_time;
  }

  public void setAdd_classhour_start_time(String add_classhour_start_time) {
	this.add_classhour_start_time = add_classhour_start_time;
  }

  public Timestamp getAdd_classday() {
	return add_classday;
  }

  public void setAdd_classday(Timestamp add_classday) {
	this.add_classday = add_classday;
  }

  public String getReq_class_cd() {
	return req_class_cd;
  }

  public void setReq_class_cd(String req_class_cd) {
	this.req_class_cd = req_class_cd;
  }

  public String getReq_add_classday() {
	return req_add_classday;
  }

  public void setReq_add_classday(String req_add_classday) {
	this.req_add_classday = req_add_classday;
  }

  public String getReq_add_classhour_start_time() {
	return req_add_classhour_start_time;
  }

  public void setReq_add_classhour_start_time(String req_add_classhour_start_time) {
	this.req_add_classhour_start_time = req_add_classhour_start_time;
  }

  public String getReq_proc_date() {
	return req_proc_date;
  }

  public void setReq_proc_date(String req_proc_date) {
	this.req_proc_date = req_proc_date;
  }

  public String getReq_reason() {
	return req_reason;
  }

  public void setReq_reason(String req_reason) {
	this.req_reason = req_reason;
  }

  public String getIs_team() {
	return is_team;
  }

  public void setIs_team(String is_team) {
	this.is_team = is_team;
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

  public String getClasshour_name() {
    return classhour_name;
  }

  public void setClasshour_name(String classhour_name) {
    this.classhour_name = classhour_name;
  }

  public String getProf_name() {
    return prof_name;
  }

  public void setProf_name(String prof_name) {
    this.prof_name = prof_name;
  }

  public String getProf_coll_name() {
    return prof_coll_name;
  }

  public void setProf_coll_name(String prof_coll_name) {
    this.prof_coll_name = prof_coll_name;
  }

  public String getProf_dept_name() {
    return prof_dept_name;
  }

  public void setProf_dept_name(String prof_dept_name) {
    this.prof_dept_name = prof_dept_name;
  }

  public int getAttendee_cnt() {
    return attendee_cnt;
  }

  public void setAttendee_cnt(int attendee_cnt) {
    this.attendee_cnt = attendee_cnt;
  }

  public int getAttend_proc_cnt() {
    return attend_proc_cnt;
  }

  public void setAttend_proc_cnt(int attend_proc_cnt) {
    this.attend_proc_cnt = attend_proc_cnt;
  }

  public int getAttend_present_cnt() {
    return attend_present_cnt;
  }

  public void setAttend_present_cnt(int attend_present_cnt) {
    this.attend_present_cnt = attend_present_cnt;
  }

  public int getAttend_late_cnt() {
    return attend_late_cnt;
  }

  public void setAttend_late_cnt(int attend_late_cnt) {
    this.attend_late_cnt = attend_late_cnt;
  }

  public int getAttend_absent_cnt() {
    return attend_absent_cnt;
  }

  public void setAttend_absent_cnt(int attend_absent_cnt) {
    this.attend_absent_cnt = attend_absent_cnt;
  }

  public int getAttend_off_cnt() {
    return attend_off_cnt;
  }

  public void setAttend_off_cnt(int attend_off_cnt) {
    this.attend_off_cnt = attend_off_cnt;
  }

  public int getAttend_quit_cnt() {
    return attend_quit_cnt;
  }

  public void setAttend_quit_cnt(int attend_quit_cnt) {
    this.attend_quit_cnt = attend_quit_cnt;
  }

  public int getAttend_auth_cnt() {
    return attend_auth_cnt;
  }

  public void setAttend_auth_cnt(int attend_auth_cnt) {
    this.attend_auth_cnt = attend_auth_cnt;
  }

  public String getClassroom_no() {
    return classroom_no;
  }

  public void setClassroom_no(String classroom_no) {
    this.classroom_no = classroom_no;
  }

  public String getClass_cert_no() {
    return class_cert_no;
  }

  public void setClass_cert_no(String class_cert_no) {
    this.class_cert_no = class_cert_no;
  }

  public int getClass_cert_time() {
    return class_cert_time;
  }

  public void setClass_cert_time(int class_cert_time) {
    this.class_cert_time = class_cert_time;
  }

  public Timestamp getClass_cert_issue_time() {
    return class_cert_issue_time;
  }

  public void setClass_cert_issue_time(Timestamp class_cert_issue_time) {
    this.class_cert_issue_time = class_cert_issue_time;
  }

  public String getClass_prog_cd() {
    return class_prog_cd;
  }

  public void setClass_prog_cd(String class_prog_cd) {
    this.class_prog_cd = class_prog_cd;
  }

  public String getClass_type_cd() {
    return class_type_cd;
  }

  public void setClass_type_cd(String class_type_cd) {
    this.class_type_cd = class_type_cd;
  }

  public String getClass_sts_cd() {
    return class_sts_cd;
  }

  public void setClass_sts_cd(String class_sts_cd) {
    this.class_sts_cd = class_sts_cd;
  }

  public String getCert_sts_cd() {
    return cert_sts_cd;
  }

  public void setCert_sts_cd(String cert_sts_cd) {
    this.cert_sts_cd = cert_sts_cd;
  }

  public String getAttend_auth_cd() {
    return attend_auth_cd;
  }

  public void setAttend_auth_cd(String attend_auth_cd) {
    this.attend_auth_cd = attend_auth_cd;
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

  public String getClass_prog_name() {
    return class_prog_name;
  }

  public void setClass_prog_name(String class_prog_name) {
    this.class_prog_name = class_prog_name;
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

  public String getAttend_auth_name() {
    return attend_auth_name;
  }

  public void setAttend_auth_name(String attend_auth_name) {
    this.attend_auth_name = attend_auth_name;
  }

  public String getCert_type() {
	return cert_type;
  }
	
  public void setCert_type(String cert_type) {
	this.cert_type = cert_type;
  }

  public String getClassoff_yn() {
	return classoff_yn;
  }

  public void setClassoff_yn(String classoff_yn) {
	this.classoff_yn = classoff_yn;
  }
  
  public String getCurr_week() {
	return curr_week;
  }

  public void setCurr_week(String curr_week) {
	this.curr_week = curr_week;
  }

  public String getProf_jikjong() {
	return prof_jikjong;
  }

  public void setProf_jikjong(String prof_jikjong) {
	this.prof_jikjong = prof_jikjong;
  }

  @Override
  public String toString() {
	return "Attendmaster [row_no=" + row_no + ", univ_cd=" + univ_cd
			+ ", year=" + year + ", term_cd=" + term_cd + ", subject_cd="
			+ subject_cd + ", subject_div_cd=" + subject_div_cd
			+ ", classday_no=" + classday_no + ", classhour_start_time="
			+ classhour_start_time + ", classhour_end_time="
			+ classhour_end_time + ", prof_no=" + prof_no + ", class_cd="
			+ class_cd + ", classday=" + classday + ", class_name="
			+ class_name + ", classday_name=" + classday_name
			+ ", classhour_name=" + classhour_name + ", prof_name=" + prof_name
			+ ", prof_coll_name=" + prof_coll_name + ", prof_dept_name="
			+ prof_dept_name + ", attendee_cnt=" + attendee_cnt
			+ ", attend_proc_cnt=" + attend_proc_cnt + ", attend_present_cnt="
			+ attend_present_cnt + ", attend_late_cnt=" + attend_late_cnt
			+ ", attend_absent_cnt=" + attend_absent_cnt + ", attend_off_cnt="
			+ attend_off_cnt + ", attend_quit_cnt=" + attend_quit_cnt
			+ ", attend_auth_cnt=" + attend_auth_cnt + ", classroom_no="
			+ classroom_no + ", class_cert_no=" + class_cert_no
			+ ", class_cert_time=" + class_cert_time
			+ ", class_cert_issue_time=" + class_cert_issue_time
			+ ", class_prog_cd=" + class_prog_cd + ", class_type_cd="
			+ class_type_cd + ", class_sts_cd=" + class_sts_cd
			+ ", cert_sts_cd=" + cert_sts_cd + ", attend_auth_cd="
			+ attend_auth_cd + ", cert_type=" + cert_type
			+ ", before_classday=" + before_classday + ", reg_type_cd="
			+ reg_type_cd + ", reg_etc=" + reg_etc + ", reg_date=" + reg_date
			+ ", class_prog_name=" + class_prog_name + ", class_type_name="
			+ class_type_name + ", class_sts_name=" + class_sts_name
			+ ", cert_sts_name=" + cert_sts_name + ", attend_auth_name="
			+ attend_auth_name + ", is_team=" + is_team + ", classoff_yn="
			+ classoff_yn + ", curr_week=" + curr_week + ", add_classday="
			+ add_classday + ", add_classhour_start_time="
			+ add_classhour_start_time + ", add_classhour_end_time="
			+ add_classhour_end_time + ", add_classroom_no=" + add_classroom_no
			+ ", chul_flag=" + chul_flag + ", req_reason=" + req_reason
			+ ", req_class_cd=" + req_class_cd + ", req_add_classday="
			+ req_add_classday + ", req_add_classhour_start_time="
			+ req_add_classhour_start_time + ", hp_no=" + hp_no
			+ ", class_adm_cd=" + class_adm_cd + ", req_proc_date="
			+ req_proc_date + ", etc_val=" + etc_val + ", prof_jikjong=" + prof_jikjong + "]";
	}
}
