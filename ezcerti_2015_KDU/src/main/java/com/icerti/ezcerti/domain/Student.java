package com.icerti.ezcerti.domain;

import java.io.Serializable;
import java.sql.Date;

public class Student implements Serializable{
	
	private static final long serialVersionUID = 763948652490277544L;
	
	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String student_no;
	private String coll_cd;
	private String dept_cd;
	private String coll_name;
	private String dept_name;
	private String student_name;
	private String student_grade;
	private String student_grade_cd;
	private String student_passwd;
	private String hp_no;
	private String email_addr;
	private String photo_info;
	private String nation_cd;
	private String student_sts_cd;
	private String student_nick_name;
	private Date log_end_date;
	private Date passwd_mod_date;
	private String authority;
	private String reg_type_cd;
	private String reg_etc;
	private Date reg_date;
	private int cert_count;
	
	private String nation_name;
	private String student_sts_name;
	private String student_grade_name;
	private String status_change_date;
	
	// 결석수 관련 추가
	private String absence_cnt;
	private String subject_cd;
	private String subject_div_cd;
	private String prof_name;
	private String prof_deft_name;
	private String prof_hp_no;
	private String class_name;
	private String hakjum;
	private String sigan;
	private String pra_sigan;
	private String total_cnt; 

	private String iphak_year;
	private String student_img;
	
	public Student() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Student(String row_no, String univ_cd, String term_cd,
			String student_no, String coll_cd, String dept_cd,
			String coll_name, String dept_name, String student_name,
			String student_grade, String student_grade_cd,
			String student_passwd, String hp_no, String email_addr,
			String photo_info, String nation_cd, String student_sts_cd,
			String student_nick_name, Date log_end_date, Date passwd_mod_date,
			String authority, String reg_type_cd, String reg_etc,
			Date reg_date, int cert_count, String nation_name,
			String student_sts_name, String student_grade_name,
			String status_change_date, String absence_cnt, String subject_cd,
			String subject_div_cd, String prof_name, String prof_deft_name,
			String prof_hp_no, String class_name, String hakjum, String sigan,
			String pra_sigan, String total_cnt, String iphak_year,
			String student_img) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.term_cd = term_cd;
		this.student_no = student_no;
		this.coll_cd = coll_cd;
		this.dept_cd = dept_cd;
		this.coll_name = coll_name;
		this.dept_name = dept_name;
		this.student_name = student_name;
		this.student_grade = student_grade;
		this.student_grade_cd = student_grade_cd;
		this.student_passwd = student_passwd;
		this.hp_no = hp_no;
		this.email_addr = email_addr;
		this.photo_info = photo_info;
		this.nation_cd = nation_cd;
		this.student_sts_cd = student_sts_cd;
		this.student_nick_name = student_nick_name;
		this.log_end_date = log_end_date;
		this.passwd_mod_date = passwd_mod_date;
		this.authority = authority;
		this.reg_type_cd = reg_type_cd;
		this.reg_etc = reg_etc;
		this.reg_date = reg_date;
		this.cert_count = cert_count;
		this.nation_name = nation_name;
		this.student_sts_name = student_sts_name;
		this.student_grade_name = student_grade_name;
		this.status_change_date = status_change_date;
		this.absence_cnt = absence_cnt;
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.prof_name = prof_name;
		this.prof_deft_name = prof_deft_name;
		this.prof_hp_no = prof_hp_no;
		this.class_name = class_name;
		this.hakjum = hakjum;
		this.sigan = sigan;
		this.pra_sigan = pra_sigan;
		this.total_cnt = total_cnt;
		this.iphak_year = iphak_year;
		this.student_img = student_img;
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

	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
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

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public String getStudent_grade() {
		return student_grade;
	}

	public void setStudent_grade(String student_grade) {
		this.student_grade = student_grade;
	}

	public String getStudent_grade_cd() {
		return student_grade_cd;
	}

	public void setStudent_grade_cd(String student_grade_cd) {
		this.student_grade_cd = student_grade_cd;
	}

	public String getStudent_passwd() {
		return student_passwd;
	}

	public void setStudent_passwd(String student_passwd) {
		this.student_passwd = student_passwd;
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

	public String getStudent_sts_cd() {
		return student_sts_cd;
	}

	public void setStudent_sts_cd(String student_sts_cd) {
		this.student_sts_cd = student_sts_cd;
	}

	public String getStudent_nick_name() {
		return student_nick_name;
	}

	public void setStudent_nick_name(String student_nick_name) {
		this.student_nick_name = student_nick_name;
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

	public int getCert_count() {
		return cert_count;
	}

	public void setCert_count(int cert_count) {
		this.cert_count = cert_count;
	}

	public String getNation_name() {
		return nation_name;
	}

	public void setNation_name(String nation_name) {
		this.nation_name = nation_name;
	}

	public String getStudent_sts_name() {
		return student_sts_name;
	}

	public void setStudent_sts_name(String student_sts_name) {
		this.student_sts_name = student_sts_name;
	}

	public String getStudent_grade_name() {
		return student_grade_name;
	}

	public void setStudent_grade_name(String student_grade_name) {
		this.student_grade_name = student_grade_name;
	}

	public String getStatus_change_date() {
		return status_change_date;
	}

	public void setStatus_change_date(String status_change_date) {
		this.status_change_date = status_change_date;
	}

	public String getAbsence_cnt() {
		return absence_cnt;
	}

	public void setAbsence_cnt(String absence_cnt) {
		this.absence_cnt = absence_cnt;
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

	public String getProf_name() {
		return prof_name;
	}

	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}

	public String getProf_deft_name() {
		return prof_deft_name;
	}

	public void setProf_deft_name(String prof_deft_name) {
		this.prof_deft_name = prof_deft_name;
	}

	public String getProf_hp_no() {
		return prof_hp_no;
	}

	public void setProf_hp_no(String prof_hp_no) {
		this.prof_hp_no = prof_hp_no;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getHakjum() {
		return hakjum;
	}

	public void setHakjum(String hakjum) {
		this.hakjum = hakjum;
	}

	public String getSigan() {
		return sigan;
	}

	public void setSigan(String sigan) {
		this.sigan = sigan;
	}

	public String getPra_sigan() {
		return pra_sigan;
	}

	public void setPra_sigan(String pra_sigan) {
		this.pra_sigan = pra_sigan;
	}

	public String getTotal_cnt() {
		return total_cnt;
	}

	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}

	public String getIphak_year() {
		return iphak_year;
	}

	public void setIphak_year(String iphak_year) {
		this.iphak_year = iphak_year;
	}

	public String getStudent_img() {
		return student_img;
	}

	public void setStudent_img(String student_img) {
		this.student_img = student_img;
	}

	@Override
	public String toString() {
		return "Student [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", student_no=" + student_no
				+ ", coll_cd=" + coll_cd + ", dept_cd=" + dept_cd
				+ ", coll_name=" + coll_name + ", dept_name=" + dept_name
				+ ", student_name=" + student_name + ", student_grade="
				+ student_grade + ", student_grade_cd=" + student_grade_cd
				+ ", student_passwd=" + student_passwd + ", hp_no=" + hp_no
				+ ", email_addr=" + email_addr + ", photo_info=" + photo_info
				+ ", nation_cd=" + nation_cd + ", student_sts_cd="
				+ student_sts_cd + ", student_nick_name=" + student_nick_name
				+ ", log_end_date=" + log_end_date + ", passwd_mod_date="
				+ passwd_mod_date + ", authority=" + authority
				+ ", reg_type_cd=" + reg_type_cd + ", reg_etc=" + reg_etc
				+ ", reg_date=" + reg_date + ", cert_count=" + cert_count
				+ ", nation_name=" + nation_name + ", student_sts_name="
				+ student_sts_name + ", student_grade_name="
				+ student_grade_name + ", status_change_date="
				+ status_change_date + ", absence_cnt=" + absence_cnt
				+ ", subject_cd=" + subject_cd + ", subject_div_cd="
				+ subject_div_cd + ", prof_name=" + prof_name
				+ ", prof_deft_name=" + prof_deft_name + ", prof_hp_no="
				+ prof_hp_no + ", class_name=" + class_name + ", hakjum="
				+ hakjum + ", sigan=" + sigan + ", pra_sigan=" + pra_sigan
				+ ", total_cnt=" + total_cnt + ", iphak_year=" + iphak_year
				+ ", student_img=" + student_img + "]";
	}
}
