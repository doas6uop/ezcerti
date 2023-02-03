package com.icerti.ezcerti.domain;

import java.io.Serializable;
import java.sql.Date;

public class Admin implements Serializable{
	
	private static final long serialVersionUID = -4000523014025503050L;
	
	private String row_no;
	private String univ_cd;
	private String coll_cd;
	private String dept_cd;
	private String admin_no;
	private String coll_name;
	private String dept_name;
	private String admin_name;
	private String admin_passwd;
	private String hp_no;
	private String email_addr;
	private String photo_info;
	private String admin_level_cd;
	private String admin_level_name;
	private String admin_sts_cd;
	private String admin_sts_name;
	private String admin_nick_name;
	private Date log_end_date;
	private Date passwd_mod_date;
	private String authority;
	private String reg_type_cd;
	private String reg_etc;
	private Date reg_date;
	
	public Admin() {
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

  public String getAdmin_no() {
    return admin_no;
  }

  public void setAdmin_no(String admin_no) {
    this.admin_no = admin_no;
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

  public String getAdmin_name() {
    return admin_name;
  }

  public void setAdmin_name(String admin_name) {
    this.admin_name = admin_name;
  }

  public String getAdmin_passwd() {
    return admin_passwd;
  }

  public void setAdmin_passwd(String admin_passwd) {
    this.admin_passwd = admin_passwd;
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

  public String getAdmin_level_cd() {
    return admin_level_cd;
  }

  public void setAdmin_level_cd(String admin_level_cd) {
    this.admin_level_cd = admin_level_cd;
  }

  public String getAdmin_level_name() {
    return admin_level_name;
  }

  public void setAdmin_level_name(String admin_level_name) {
    this.admin_level_name = admin_level_name;
  }
  
  public String getAdmin_sts_cd() {
    return admin_sts_cd;
  }

  public void setAdmin_sts_cd(String admin_sts_cd) {
    this.admin_sts_cd = admin_sts_cd;
  }

  public String getAdmin_sts_name() {
    return admin_sts_name;
  }

  public void setAdmin_sts_name(String admin_sts_name) {
    this.admin_sts_name = admin_sts_name;
  }
  
  public String getAdmin_nick_name() {
    return admin_nick_name;
  }

  public void setAdmin_nick_name(String admin_nick_name) {
    this.admin_nick_name = admin_nick_name;
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

  @Override
  public String toString() {
    return "Admin [row_no=" + row_no + ", univ_cd=" + univ_cd + ", coll_cd=" + coll_cd
        + ", dept_cd=" + dept_cd + ", admin_no=" + admin_no + ", coll_name=" + coll_name
        + ", dept_name=" + dept_name + ", admin_name=" + admin_name + ", admin_passwd="
        + admin_passwd + ", hp_no=" + hp_no + ", email_addr=" + email_addr + ", photo_info="
        + photo_info + ", admin_level_cd=" + admin_level_cd + ", admin_sts_cd=" + admin_sts_cd
        + ", admin_nick_name=" + admin_nick_name + ", log_end_date=" + log_end_date
        + ", passwd_mod_date=" + passwd_mod_date + ", authority=" + authority + ", reg_type_cd="
        + reg_type_cd + ", reg_etc=" + reg_etc + ", reg_date=" + reg_date + "]";
  }
		
}
