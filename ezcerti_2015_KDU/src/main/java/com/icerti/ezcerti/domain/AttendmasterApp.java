package com.icerti.ezcerti.domain;

import java.sql.Date;

public class AttendmasterApp {
	private String subject_cd;
	private String subject_div_cd;
	private String class_cd;
	private String class_name;
	private Date classday;
	private String classhour_start_time;
	private String classhour_end_time;
	private String prof_no;
	private String prof_name;
	private String student_no;
	private String student_name;
	private String coll_name;
	private String dept_name;
	private String class_cert_no;
	private String cert_type;
	private String classroom_no;
	private int class_cert_time;

	public AttendmasterApp() {
		super();
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
	
	public String getClass_cd() {
		return class_cd;
	}
	
	public void setClass_cd(String class_cd) {
		this.class_cd = class_cd;
	}
	
	public String getClass_name() {
		return class_name;
	}
	
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	
	public Date getClassday() {
		return classday;
	}
	
	public void setClassday(Date classday) {
		this.classday = classday;
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
	
	public String getProf_name() {
		return prof_name;
	}
	
	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
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
	
	public String getColl_name() {
		return coll_name;
	}
	
	public void setColl_name(String coll_name) {
		this.coll_name = coll_name;
	}
	
	public String getDept_name() {
		return dept_name;
	}
	
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
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

	public String getClassroom_no() {
		return classroom_no;
	}

	public void setClassroom_no(String classroom_no) {
		this.classroom_no = classroom_no;
	}

	public String getCert_type() {
		return cert_type;
	}

	public void setCert_type(String cert_type) {
		this.cert_type = cert_type;
	}
  
}
