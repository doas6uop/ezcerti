package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Classhour {

	private String row_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String classhour;
	private String classhour_start_time;
	private String classhour_end_time;
	private String classhour_name;
	private String classhour_sts_cd;
	private String reg_type;
	private Date reg_date;
	private String isExsist;
	
	private String able_select_flag;
	
	public Classhour() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Classhour(String row_no, String univ_cd, String year,
			String term_cd, String classhour, String classhour_start_time,
			String classhour_end_time, String classhour_name,
			String classhour_sts_cd, String reg_type, Date reg_date,
			String isExsist, String able_select_flag) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.classhour = classhour;
		this.classhour_start_time = classhour_start_time;
		this.classhour_end_time = classhour_end_time;
		this.classhour_name = classhour_name;
		this.classhour_sts_cd = classhour_sts_cd;
		this.reg_type = reg_type;
		this.reg_date = reg_date;
		this.isExsist = isExsist;
		this.able_select_flag = able_select_flag;
	}

	public String getAble_select_flag() {
		return able_select_flag;
	}

	public void setAble_select_flag(String able_select_flag) {
		this.able_select_flag = able_select_flag;
	}

	public String getIsExsist() {
		return isExsist;
	}

	public void setIsExsist(String isExsist) {
		this.isExsist = isExsist;
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

	public String getClasshour() {
		return classhour;
	}

	public void setClasshour(String classhour) {
		this.classhour = classhour;
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

	public String getClasshour_name() {
		return classhour_name;
	}

	public void setClasshour_name(String classhour_name) {
		this.classhour_name = classhour_name;
	}

	public String getClasshour_sts_cd() {
		return classhour_sts_cd;
	}

	public void setClasshour_sts_cd(String classhour_sts_cd) {
		this.classhour_sts_cd = classhour_sts_cd;
	}

	public String getReg_type() {
		return reg_type;
	}

	public void setReg_type(String reg_type) {
		this.reg_type = reg_type;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "Classhour [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", year=" + year + ", term_cd=" + term_cd + ", classhour="
				+ classhour + ", classhour_start_time=" + classhour_start_time
				+ ", classhour_end_time=" + classhour_end_time
				+ ", classhour_name=" + classhour_name + ", classhour_sts_cd="
				+ classhour_sts_cd + ", reg_type=" + reg_type + ", reg_date="
				+ reg_date + ", isExsist=" + isExsist + ", able_select_flag="
				+ able_select_flag + "]";
	}
}
