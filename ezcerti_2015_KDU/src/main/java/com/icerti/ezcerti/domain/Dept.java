package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Dept {
	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String coll_cd;
	private String dept_cd;
	private String dept_name;
	private String dept_sts_cd;
	private String reg_type_cd;
	private Date reg_date;
	
	public Dept() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Dept(String row_no, String univ_cd, String term_cd, String coll_cd,
			String dept_cd, String dept_name, String dept_sts_cd,
			String reg_type_cd, Date reg_date) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.term_cd = term_cd;
		this.coll_cd = coll_cd;
		this.dept_cd = dept_cd;
		this.dept_name = dept_name;
		this.dept_sts_cd = dept_sts_cd;
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
	public String getColl_cd() {
		return coll_cd;
	}
	public void setColl_cd(String coll_cd) {
		this.coll_cd = coll_cd;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getDept_sts_cd() {
		return dept_sts_cd;
	}
	public void setDept_sts_cd(String dept_sts_cd) {
		this.dept_sts_cd = dept_sts_cd;
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
		return "Dept [row_no=" + row_no + ", univ_cd=" + univ_cd + ", term_cd="
				+ term_cd + ", coll_cd=" + coll_cd + ", dept_cd=" + dept_cd
				+ ", dept_name=" + dept_name + ", dept_sts_cd=" + dept_sts_cd
				+ ", reg_type_cd=" + reg_type_cd + ", reg_date=" + reg_date
				+ "]";
	}
	
	
	
}
