package com.icerti.ezcerti.domain;

public class ClassoffManage {
	
	private String row_no;
	private String classoffmanage_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String classday;
	private String before_classday;
	private String classoffmanage_sayu;
	private String regdate;
	private String perform_flag;
	private String perform_date;
	
	public ClassoffManage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ClassoffManage(String row_no, String classoffmanage_no,
			String univ_cd, String year, String term_cd, String classday,
			String before_classday, String classoffmanage_sayu, String regdate,
			String perform_flag, String perform_date) {
		super();
		this.row_no = row_no;
		this.classoffmanage_no = classoffmanage_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.classday = classday;
		this.before_classday = before_classday;
		this.classoffmanage_sayu = classoffmanage_sayu;
		this.regdate = regdate;
		this.perform_flag = perform_flag;
		this.perform_date = perform_date;
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}

	public String getClassoffmanage_no() {
		return classoffmanage_no;
	}

	public void setClassoffmanage_no(String classoffmanage_no) {
		this.classoffmanage_no = classoffmanage_no;
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

	public String getClassday() {
		return classday;
	}

	public void setClassday(String classday) {
		this.classday = classday;
	}

	public String getBefore_classday() {
		return before_classday;
	}

	public void setBefore_classday(String before_classday) {
		this.before_classday = before_classday;
	}

	public String getClassoffmanage_sayu() {
		return classoffmanage_sayu;
	}

	public void setClassoffmanage_sayu(String classoffmanage_sayu) {
		this.classoffmanage_sayu = classoffmanage_sayu;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getPerform_flag() {
		return perform_flag;
	}

	public void setPerform_flag(String perform_flag) {
		this.perform_flag = perform_flag;
	}

	public String getPerform_date() {
		return perform_date;
	}

	public void setPerform_date(String perform_date) {
		this.perform_date = perform_date;
	}

	@Override
	public String toString() {
		return "ClassoffManage [row_no=" + row_no + ", classoffmanage_no="
				+ classoffmanage_no + ", univ_cd=" + univ_cd + ", year=" + year
				+ ", term_cd=" + term_cd + ", classday=" + classday
				+ ", before_classday=" + before_classday
				+ ", classoffmanage_sayu=" + classoffmanage_sayu + ", regdate="
				+ regdate + ", perform_flag=" + perform_flag
				+ ", perform_date=" + perform_date + "]";
	}

	
}





