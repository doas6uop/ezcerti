package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

public class AttendBatch {

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
	  private Timestamp before_classday;
	  private String reg_type_cd;
	  private String reg_etc;
	  private Timestamp reg_date;

	  private String class_prog_name;
	  private String class_type_name;
	  private String class_sts_name;
	  private String cert_sts_name;
	  private String attend_auth_name;
	  
	  private Collection<Attenddethist> attenddethist;

	public AttendBatch() {
		super();
		// TODO Auto-generated constructor stub
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

	public Collection<Attenddethist> getAttenddethist() {
		return attenddethist;
	}

	public void setAttenddethist(Collection<Attenddethist> attenddethist) {
		this.attenddethist = attenddethist;
	}

	@Override
	public String toString() {
		return "AttendBatch [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", subject_cd=" + subject_cd
				+ ", subject_div_cd=" + subject_div_cd + ", classday_no="
				+ classday_no + ", classhour_start_time="
				+ classhour_start_time + ", classhour_end_time="
				+ classhour_end_time + ", prof_no=" + prof_no + ", class_cd="
				+ class_cd + ", classday=" + classday + ", class_name="
				+ class_name + ", classday_name=" + classday_name
				+ ", classhour_name=" + classhour_name + ", prof_name="
				+ prof_name + ", prof_coll_name=" + prof_coll_name
				+ ", prof_dept_name=" + prof_dept_name + ", attendee_cnt="
				+ attendee_cnt + ", attend_proc_cnt=" + attend_proc_cnt
				+ ", attend_present_cnt=" + attend_present_cnt
				+ ", attend_late_cnt=" + attend_late_cnt
				+ ", attend_absent_cnt=" + attend_absent_cnt
				+ ", attend_off_cnt=" + attend_off_cnt + ", attend_quit_cnt="
				+ attend_quit_cnt + ", attend_auth_cnt=" + attend_auth_cnt
				+ ", classroom_no=" + classroom_no + ", class_cert_no="
				+ class_cert_no + ", class_cert_time=" + class_cert_time
				+ ", class_cert_issue_time=" + class_cert_issue_time
				+ ", class_prog_cd=" + class_prog_cd + ", class_type_cd="
				+ class_type_cd + ", class_sts_cd=" + class_sts_cd
				+ ", cert_sts_cd=" + cert_sts_cd + ", attend_auth_cd="
				+ attend_auth_cd + ", before_classday=" + before_classday
				+ ", reg_type_cd=" + reg_type_cd + ", reg_etc=" + reg_etc
				+ ", reg_date=" + reg_date + ", class_prog_name="
				+ class_prog_name + ", class_type_name=" + class_type_name
				+ ", class_sts_name=" + class_sts_name + ", cert_sts_name="
				+ cert_sts_name + ", attend_auth_name=" + attend_auth_name
				+ ", attenddethist=" + attenddethist + "]";
	}

	
}
