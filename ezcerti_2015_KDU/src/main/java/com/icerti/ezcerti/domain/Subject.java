package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Subject {
	
	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String subject_cd;
	private String subject_div_cd;
	private String subject_name;
	private String subject_sts_cd;
	private String reg_type_cd;
	private Date reg_date;
	
	public Subject() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Subject(String row_no, String univ_cd, String term_cd,
			String subject_cd, String subject_div_cd, String subject_name,
			String subject_sts_cd, String reg_type_cd, Date reg_date) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.term_cd = term_cd;
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.subject_name = subject_name;
		this.subject_sts_cd = subject_sts_cd;
		this.reg_type_cd = reg_type_cd;
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

	public String getSubject_name() {
		return subject_name;
	}

	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

	public String getSubject_sts_cd() {
		return subject_sts_cd;
	}

	public void setSubject_sts_cd(String subject_sts_cd) {
		this.subject_sts_cd = subject_sts_cd;
	}

	public String getReg_type_cd() {
		return reg_type_cd;
	}

	public void setReg_type_cd(String reg_type_cd) {
		this.reg_type_cd = reg_type_cd;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "Subject [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", subject_cd=" + subject_cd
				+ ", subject_div_cd=" + subject_div_cd + ", subject_name="
				+ subject_name + ", subject_sts_cd=" + subject_sts_cd
				+ ", reg_type_cd=" + reg_type_cd + ", reg_date=" + reg_date
				+ "]";
	}
}
