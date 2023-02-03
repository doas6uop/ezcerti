package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class AttendAppInfo {
	private String row_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String class_cd;
	private Date classday;
	private String prof_no;
	private String student_no;
	private String student_name;
	private String app_exec;
	private String app_error;
	private Timestamp reg_date;
	  
	private int app_exec_cnt;
	private int app_error_cnt;

	public AttendAppInfo() {
		super();
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
	
	public String getProf_no() {
		return prof_no;
	}
	
	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
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

	public String getApp_exec() {
		return app_exec;
	}
	
	public void setApp_exec(String app_exec) {
		this.app_exec = app_exec;
	}
	
	public String getApp_error() {
		return app_error;
	}
	
	public void setApp_error(String app_error) {
		this.app_error = app_error;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	public int getApp_exec_cnt() {
		return app_exec_cnt;
	}
	
	public void setApp_exec_cnt(int app_exec_cnt) {
		this.app_exec_cnt = app_exec_cnt;
	}
	
	public int getApp_error_cnt() {
		return app_error_cnt;
	}
	
	public void setApp_error_cnt(int app_error_cnt) {
		this.app_error_cnt = app_error_cnt;
	}
	

}
