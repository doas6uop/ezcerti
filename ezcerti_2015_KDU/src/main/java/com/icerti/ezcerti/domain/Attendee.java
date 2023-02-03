package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Attendee {
	private String row_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String subject_cd;
	private String subject_div_cd;
	private String student_no;
	private String reg_type_cd;
	private String reg_etc;
	private Date reg_date;
	
	public Attendee() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Attendee(String row_no, String univ_cd, String year, String term_cd,
			String subject_cd, String subject_div_cd, String student_no,
			String reg_type_cd, String reg_etc, Date reg_date) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.student_no = student_no;
		this.reg_type_cd = reg_type_cd;
		this.reg_etc = reg_etc;
		this.reg_date = reg_date;
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
	public String getStudent_no() {
		return student_no;
	}
	public void setStudent_no(String student_no) {
		this.student_no = student_no;
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
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "Attendee [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", subject_cd=" + subject_cd
				+ ", subject_div_cd=" + subject_div_cd + ", student_no="
				+ student_no + ", reg_type_cd=" + reg_type_cd + ", reg_etc="
				+ reg_etc + ", reg_date=" + reg_date + "]";
	}
	
	
}
