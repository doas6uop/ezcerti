package com.icerti.ezcerti.domain;

import java.sql.Date;


public class Univ {
	
	private String univ_cd;
	private String year;
	private String term_cd;
	private String univ_name;
	private String term_name;
	private Date term_start_date;
	private Date term_end_date;
	//private String attend_proc_cd;
	private String univ_sts_cd;
	private String reg_type_cd;
	private Date reg_date;
	
	private String attend_proc_name;
	private String univ_sts_name;

	private Date bogang_start;
	private Date bogang_end;
	private Date noclass_start;
	private Date noclass_end;
	private String lssn_admt_dt;
	
	public Univ() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Univ(String univ_cd, String year, String term_cd, String univ_name,
			String term_name, Date term_start_date, Date term_end_date,
			String univ_sts_cd, String reg_type_cd, Date reg_date,
			String attend_proc_name, String univ_sts_name, Date bogang_start,
			Date bogang_end, Date noclass_start, Date noclass_end,
			String lssn_admt_dt) {
		super();
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.univ_name = univ_name;
		this.term_name = term_name;
		this.term_start_date = term_start_date;
		this.term_end_date = term_end_date;
		this.univ_sts_cd = univ_sts_cd;
		this.reg_type_cd = reg_type_cd;
		this.reg_date = reg_date;
		this.attend_proc_name = attend_proc_name;
		this.univ_sts_name = univ_sts_name;
		this.bogang_start = bogang_start;
		this.bogang_end = bogang_end;
		this.noclass_start = noclass_start;
		this.noclass_end = noclass_end;
		this.lssn_admt_dt = lssn_admt_dt;
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

	public String getUniv_name() {
		return univ_name;
	}

	public void setUniv_name(String univ_name) {
		this.univ_name = univ_name;
	}

	public String getTerm_name() {
		return term_name;
	}

	public void setTerm_name(String term_name) {
		this.term_name = term_name;
	}

	public Date getTerm_start_date() {
		return term_start_date;
	}

	public void setTerm_start_date(Date term_start_date) {
		this.term_start_date = term_start_date;
	}

	public Date getTerm_end_date() {
		return term_end_date;
	}

	public void setTerm_end_date(Date term_end_date) {
		this.term_end_date = term_end_date;
	}

	public String getUniv_sts_cd() {
		return univ_sts_cd;
	}

	public void setUniv_sts_cd(String univ_sts_cd) {
		this.univ_sts_cd = univ_sts_cd;
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

	public String getAttend_proc_name() {
		return attend_proc_name;
	}

	public void setAttend_proc_name(String attend_proc_name) {
		this.attend_proc_name = attend_proc_name;
	}

	public String getUniv_sts_name() {
		return univ_sts_name;
	}

	public void setUniv_sts_name(String univ_sts_name) {
		this.univ_sts_name = univ_sts_name;
	}

	public Date getBogang_start() {
		return bogang_start;
	}

	public void setBogang_start(Date bogang_start) {
		this.bogang_start = bogang_start;
	}

	public Date getBogang_end() {
		return bogang_end;
	}

	public void setBogang_end(Date bogang_end) {
		this.bogang_end = bogang_end;
	}

	public Date getNoclass_start() {
		return noclass_start;
	}

	public void setNoclass_start(Date noclass_start) {
		this.noclass_start = noclass_start;
	}

	public Date getNoclass_end() {
		return noclass_end;
	}

	public void setNoclass_end(Date noclass_end) {
		this.noclass_end = noclass_end;
	}

	public String getLssn_admt_dt() {
		return lssn_admt_dt;
	}

	public void setLssn_admt_dt(String lssn_admt_dt) {
		this.lssn_admt_dt = lssn_admt_dt;
	}

	@Override
	public String toString() {
		return "Univ [univ_cd=" + univ_cd + ", year=" + year + ", term_cd="
				+ term_cd + ", univ_name=" + univ_name + ", term_name="
				+ term_name + ", term_start_date=" + term_start_date
				+ ", term_end_date=" + term_end_date + ", univ_sts_cd="
				+ univ_sts_cd + ", reg_type_cd=" + reg_type_cd + ", reg_date="
				+ reg_date + ", attend_proc_name=" + attend_proc_name
				+ ", univ_sts_name=" + univ_sts_name + ", bogang_start="
				+ bogang_start + ", bogang_end=" + bogang_end
				+ ", noclass_start=" + noclass_start + ", noclass_end="
				+ noclass_end + ", lssn_admt_dt=" + lssn_admt_dt + "]";
	}

}
