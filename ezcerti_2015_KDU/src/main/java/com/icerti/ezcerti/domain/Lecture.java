package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Lecture {

	private String row_no;
	private String univ_cd;
	private String term_cd;
	private String subject_cd;
	private String subject_div_cd;
	private String classday_no;
	private String classhour_start_time;
	private String classhour_end_time;
	private String prof_no;
	private String class_cd;
	private String class_name;
	private String classday_name;
	private String classhour_name;
	private String prof_name;
	private String prof_coll_name;
	private String prof_dept_name;
	private int attendee_cnt;
	private String classroom_no;
	private String class_prog_cd;
	private String class_adm_cd;
	private String reg_type_cd;
	private String reg_etc;
	private Date reg_date;
	private String is_team;

	public Lecture() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Lecture(String row_no, String univ_cd, String term_cd,
			String subject_cd, String subject_div_cd, String classday_no,
			String classhour_start_time, String classhour_end_time,
			String prof_no, String class_cd, String class_name,
			String classday_name, String classhour_name, String prof_name,
			String prof_coll_name, String prof_dept_name, int attendee_cnt,
			String classroom_no, String class_prog_cd, String class_adm_cd,
			String reg_type_cd, String reg_etc, Date reg_date, String is_team) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.term_cd = term_cd;
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.classday_no = classday_no;
		this.classhour_start_time = classhour_start_time;
		this.classhour_end_time = classhour_end_time;
		this.prof_no = prof_no;
		this.class_cd = class_cd;
		this.class_name = class_name;
		this.classday_name = classday_name;
		this.classhour_name = classhour_name;
		this.prof_name = prof_name;
		this.prof_coll_name = prof_coll_name;
		this.prof_dept_name = prof_dept_name;
		this.attendee_cnt = attendee_cnt;
		this.classroom_no = classroom_no;
		this.class_prog_cd = class_prog_cd;
		this.class_adm_cd = class_adm_cd;
		this.reg_type_cd = reg_type_cd;
		this.reg_etc = reg_etc;
		this.reg_date = reg_date;
		this.is_team = is_team;
	}

	public String getClass_adm_cd() {
		return class_adm_cd;
	}

	public void setClass_adm_cd(String class_adm_cd) {
		this.class_adm_cd = class_adm_cd;
	}

	public String getIs_team() {
		return is_team;
	}

	public void setIs_team(String is_team) {
		this.is_team = is_team;
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

	public String getClassday_no() {
		return classday_no;
	}

	public void setClassday_no(String classday_no) {
		this.classday_no = classday_no;
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

	public String getProf_no() {
		return prof_no;
	}

	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
	}

	public String getClass_cd() {
		return class_cd;
	}

	public void setClass_cd(String class_cd) {
		this.class_cd = class_cd;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getClassday_name() {
		return classday_name;
	}

	public void setClassday_name(String classday_name) {
		this.classday_name = classday_name;
	}

	public String getClasshour_name() {
		return classhour_name;
	}

	public void setClasshour_name(String classhour_name) {
		this.classhour_name = classhour_name;
	}

	public String getProf_name() {
		return prof_name;
	}

	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}

	public String getProf_coll_name() {
		return prof_coll_name;
	}

	public void setProf_coll_name(String prof_coll_name) {
		this.prof_coll_name = prof_coll_name;
	}

	public String getProf_dept_name() {
		return prof_dept_name;
	}

	public void setProf_dept_name(String prof_dept_name) {
		this.prof_dept_name = prof_dept_name;
	}

	public int getAttendee_cnt() {
		return attendee_cnt;
	}

	public void setAttendee_cnt(int attendee_cnt) {
		this.attendee_cnt = attendee_cnt;
	}

	public String getClassroom_no() {
		return classroom_no;
	}

	public void setClassroom_no(String classroom_no) {
		this.classroom_no = classroom_no;
	}

	public String getClass_prog_cd() {
		return class_prog_cd;
	}

	public void setClass_prog_cd(String class_prog_cd) {
		this.class_prog_cd = class_prog_cd;
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
		return "Lecture [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", term_cd=" + term_cd + ", subject_cd=" + subject_cd
				+ ", subject_div_cd=" + subject_div_cd + ", classday_no="
				+ classday_no + ", classhour_start_time="
				+ classhour_start_time + ", classhour_end_time="
				+ classhour_end_time + ", prof_no=" + prof_no + ", class_cd="
				+ class_cd + ", class_name=" + class_name + ", classday_name="
				+ classday_name + ", classhour_name=" + classhour_name
				+ ", prof_name=" + prof_name + ", prof_coll_name="
				+ prof_coll_name + ", prof_dept_name=" + prof_dept_name
				+ ", attendee_cnt=" + attendee_cnt + ", classroom_no="
				+ classroom_no + ", class_prog_cd=" + class_prog_cd
				+ ", class_adm_cd=" + class_adm_cd + ", reg_type_cd="
				+ reg_type_cd + ", reg_etc=" + reg_etc + ", reg_date="
				+ reg_date + ", is_team=" + is_team + "]";
	}
}
