package com.icerti.ezcerti.domain;

import java.io.Serializable;
import java.sql.Date;

public class UserInfo implements Serializable{
	
	private static final long serialVersionUID = 763948652490277544L;
	
	private String row_no;
	private String univ_cd;
	private String user_no;
	private String user_id;
	private String coll_cd;
	private String dept_cd;
	private String coll_name;
	private String dept_name;
	private String user_name;
	private String grade;
	private String grade_cd;
	private String user_passwd;
	private String user_status;
	private String hp_no;
	private String email_addr;
	private String photo_info;
	private String nation_cd;
	private String authority;
	private Date log_end_date;
	private Date passwd_mod_date;
	private String user_type;
	private String reg_etc;
	private Date reg_date;
	private String adm_cd;
	private String sts_cd;
	
	private String nation_name;
	private String user_sts_name;
	private String grade_name;
	
	public UserInfo() {
		super();
		// TODO Auto-generated constructor stub
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

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
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

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getGrade_cd() {
		return grade_cd;
	}

	public void setGrade_cd(String grade_cd) {
		this.grade_cd = grade_cd;
	}

	public String getUser_passwd() {
		return user_passwd;
	}

	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}

	public String getUser_status() {
		return user_status;
	}

	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}

	public String getHp_no() {
		return hp_no;
	}

	public void setHp_no(String hp_no) {
		this.hp_no = hp_no;
	}

	public String getEmail_addr() {
		return email_addr;
	}

	public void setEmail_addr(String email_addr) {
		this.email_addr = email_addr;
	}

	public String getPhoto_info() {
		return photo_info;
	}

	public void setPhoto_info(String photo_info) {
		this.photo_info = photo_info;
	}

	public String getNation_cd() {
		return nation_cd;
	}

	public void setNation_cd(String nation_cd) {
		this.nation_cd = nation_cd;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public Date getLog_end_date() {
		return log_end_date;
	}

	public void setLog_end_date(Date log_end_date) {
		this.log_end_date = log_end_date;
	}

	public Date getPasswd_mod_date() {
		return passwd_mod_date;
	}

	public void setPasswd_mod_date(Date passwd_mod_date) {
		this.passwd_mod_date = passwd_mod_date;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
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

	public String getNation_name() {
		return nation_name;
	}

	public void setNation_name(String nation_name) {
		this.nation_name = nation_name;
	}

	public String getUser_sts_name() {
		return user_sts_name;
	}

	public void setUser_sts_name(String user_sts_name) {
		this.user_sts_name = user_sts_name;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}

	public String getAdm_cd() {
		return adm_cd;
	}

	public void setAdm_cd(String adm_cd) {
		this.adm_cd = adm_cd;
	}

	public String getSts_cd() {
		return sts_cd;
	}

	public void setSts_cd(String sts_cd) {
		this.sts_cd = sts_cd;
	}
	
}
