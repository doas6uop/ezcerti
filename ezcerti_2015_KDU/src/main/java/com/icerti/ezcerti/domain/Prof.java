package com.icerti.ezcerti.domain;

import java.io.Serializable;
import java.sql.Date;

public class Prof implements Serializable{
	
	private static final long serialVersionUID = -8180956036710438918L;
	
	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String prof_no;
	private String coll_cd;
	private String dept_cd;
	private String coll_name;
	private String dept_name;
	private String prof_name;
	private String prof_passwd;
	private String hp_no;
	private String email_addr;
	private String photo_info;
	private String prof_status;
	private String prof_sts_cd;
	private String prof_adm_cd;
	private String prof_nick_name;
	private Date log_end_date;
	private Date passwd_mod_date;
	private String authority;
	private String reg_type_cd;
	private String reg_etc;
	private Date reg_date;
	
	private String prof_adm_name;
	
	public Prof() {
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

	public String getTerm_cd() {
		return term_cd;
	}

	public void setTerm_cd(String term_cd) {
		this.term_cd = term_cd;
	}

	public String getProf_no() {
		return prof_no;
	}

	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
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

	public String getProf_name() {
		return prof_name;
	}

	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}

	public String getProf_passwd() {
		return prof_passwd;
	}

	public void setProf_passwd(String prof_passwd) {
		this.prof_passwd = prof_passwd;
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

	public String getProf_status() {
		return prof_status;
	}

	public void setProf_status(String prof_status) {
		this.prof_status = prof_status;
	}

	public String getProf_sts_cd() {
		return prof_sts_cd;
	}

	public void setProf_sts_cd(String prof_sts_cd) {
		this.prof_sts_cd = prof_sts_cd;
	}

	public String getProf_adm_cd() {
		return prof_adm_cd;
	}

	public void setProf_adm_cd(String prof_adm_cd) {
		this.prof_adm_cd = prof_adm_cd;
	}

	public String getProf_nick_name() {
		return prof_nick_name;
	}

	public void setProf_nick_name(String prof_nick_name) {
		this.prof_nick_name = prof_nick_name;
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

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
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

	public String getProf_adm_name() {
		return prof_adm_name;
	}

	public void setProf_adm_name(String prof_adm_name) {
		this.prof_adm_name = prof_adm_name;
	}

	@Override
	public String toString() {
		return "Prof [row_no=" + row_no + ", univ_cd=" + univ_cd + ", term_cd="
				+ term_cd + ", prof_no=" + prof_no + ", coll_cd=" + coll_cd
				+ ", dept_cd=" + dept_cd + ", coll_name=" + coll_name
				+ ", dept_name=" + dept_name + ", prof_name=" + prof_name
				+ ", prof_passwd=" + prof_passwd + ", hp_no=" + hp_no
				+ ", email_addr=" + email_addr + ", photo_info=" + photo_info
				+ ", prof_status=" + prof_status + ", prof_sts_cd="
				+ prof_sts_cd + ", prof_adm_cd=" + prof_adm_cd
				+ ", prof_nick_name=" + prof_nick_name + ", log_end_date="
				+ log_end_date + ", passwd_mod_date=" + passwd_mod_date
				+ ", authority=" + authority + ", reg_type_cd=" + reg_type_cd
				+ ", reg_etc=" + reg_etc + ", reg_date=" + reg_date
				+ ", prof_adm_name=" + prof_adm_name + "]";
	}
}
