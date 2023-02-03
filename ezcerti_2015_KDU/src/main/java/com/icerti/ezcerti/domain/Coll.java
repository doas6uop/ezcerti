package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Coll {

	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String coll_cd;
	private String coll_name;
	private String coll_sts_cd;
	private String reg_type_cd;
	private Date reg_date;
	
	public Coll() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Coll(String row_no, String univ_cd, String term_cd, String coll_cd,
			String coll_name, String coll_sts_cd, String reg_type_cd,
			Date reg_date) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.term_cd = term_cd;
		this.coll_cd = coll_cd;
		this.coll_name = coll_name;
		this.coll_sts_cd = coll_sts_cd;
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

	public String getColl_name() {
		return coll_name;
	}

	public void setColl_name(String coll_name) {
		this.coll_name = coll_name;
	}

	public String getColl_sts_cd() {
		return coll_sts_cd;
	}

	public void setColl_sts_cd(String coll_sts_cd) {
		this.coll_sts_cd = coll_sts_cd;
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
		return "Coll [row_no=" + row_no + ", univ_cd=" + univ_cd + ", term_cd="
				+ term_cd + ", coll_cd=" + coll_cd + ", coll_name=" + coll_name
				+ ", coll_sts_cd=" + coll_sts_cd + ", reg_type_cd="
				+ reg_type_cd + ", reg_date=" + reg_date + "]";
	}


	
}
