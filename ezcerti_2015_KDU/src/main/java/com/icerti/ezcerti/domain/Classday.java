package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Classday {
	private String row_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private Date classday;
	private String classday_no;
	private String classday_name;
	private String classday_sts_cd;
	private String reg_type_cd;
	private Date reg_date;
	
	public Classday() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Classday(String row_no, String year, String univ_cd, String term_cd,
			Date classday, String classday_no, String classday_name,
			String classday_sts_cd, String reg_type_cd, Date reg_date) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.classday = classday;
		this.classday_no = classday_no;
		this.classday_name = classday_name;
		this.classday_sts_cd = classday_sts_cd;
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

	public String getClassday_name() {
		return classday_name;
	}

	public void setClassday_name(String classday_name) {
		this.classday_name = classday_name;
	}

	public String getClassday_sts_cd() {
		return classday_sts_cd;
	}

	public void setClassday_sts_cd(String classday_sts_cd) {
		this.classday_sts_cd = classday_sts_cd;
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
		return "Classday [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", classday=" + classday
				+ ", classday_no=" + classday_no + ", classday_name="
				+ classday_name + ", classday_sts_cd=" + classday_sts_cd
				+ ", reg_type_cd=" + reg_type_cd + ", reg_date=" + reg_date
				+ "]";
	}
	
	
}
