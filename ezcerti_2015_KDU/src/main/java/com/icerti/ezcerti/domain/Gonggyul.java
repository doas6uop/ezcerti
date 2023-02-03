package com.icerti.ezcerti.domain;

import java.util.ArrayList;
import java.util.Arrays;

public class Gonggyul {
	
	private String row_no;
	private String gonggyul_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String student_no;
	private String student_name;
	private String gong_ilja_start;
	private String gong_ilja_end;
	private String gong_sayu;
	private String checkbox_flag;
	private String regdate;
	private String submit_date;
	
	private String class_cd;
	private String classday;
	private String classhour_start_time;
	
	private String[] chk_classname;	
	private String tmp_class_cd;
	private ArrayList<GonggyulSubject> gonggyulSubjectList;
	
	public Gonggyul() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Gonggyul(String row_no, String gonggyul_no, String univ_cd,
			String year, String term_cd, String student_no,
			String student_name, String gong_ilja_start, String gong_ilja_end,
			String gong_sayu, String checkbox_flag, String regdate,
			String submit_date, String class_cd, String classday,
			String classhour_start_time, String[] chk_classname,
			String tmp_class_cd, ArrayList<GonggyulSubject> gonggyulSubjectList) {
		super();
		this.row_no = row_no;
		this.gonggyul_no = gonggyul_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.student_no = student_no;
		this.student_name = student_name;
		this.gong_ilja_start = gong_ilja_start;
		this.gong_ilja_end = gong_ilja_end;
		this.gong_sayu = gong_sayu;
		this.checkbox_flag = checkbox_flag;
		this.regdate = regdate;
		this.submit_date = submit_date;
		this.class_cd = class_cd;
		this.classday = classday;
		this.classhour_start_time = classhour_start_time;
		this.chk_classname = chk_classname;
		this.tmp_class_cd = tmp_class_cd;
		this.gonggyulSubjectList = gonggyulSubjectList;
	}

	public String getClasshour_start_time() {
		return classhour_start_time;
	}

	public void setClasshour_start_time(String classhour_start_time) {
		this.classhour_start_time = classhour_start_time;
	}

	public String getClass_cd() {
		return class_cd;
	}

	public void setClass_cd(String class_cd) {
		this.class_cd = class_cd;
	}

	public String getClassday() {
		return classday;
	}

	public void setClassday(String classday) {
		this.classday = classday;
	}

	public String getSubmit_date() {
		return submit_date;
	}

	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}

	public String getTmp_class_cd() {
		return tmp_class_cd;
	}

	public void setTmp_class_cd(String tmp_class_cd) {
		this.tmp_class_cd = tmp_class_cd;
	}

	public ArrayList<GonggyulSubject> getGonggyulSubjectList() {
		return gonggyulSubjectList;
	}

	public void setGonggyulSubjectList(
			ArrayList<GonggyulSubject> gonggyulSubjectList) {
		this.gonggyulSubjectList = gonggyulSubjectList;
	}

	public String[] getChk_classname() {
		return chk_classname;
	}

	public void setChk_classname(String[] chk_classname) {
		this.chk_classname = chk_classname;
	}

	public String getCheckbox_flag() {
		return checkbox_flag;
	}

	public void setCheckbox_flag(String checkbox_flag) {
		this.checkbox_flag = checkbox_flag;
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

	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public String getGong_ilja_start() {
		return gong_ilja_start;
	}

	public void setGong_ilja_start(String gong_ilja_start) {
		this.gong_ilja_start = gong_ilja_start;
	}

	public String getGong_ilja_end() {
		return gong_ilja_end;
	}

	public void setGong_ilja_end(String gong_ilja_end) {
		this.gong_ilja_end = gong_ilja_end;
	}

	public String getGong_sayu() {
		return gong_sayu;
	}

	public void setGong_sayu(String gong_sayu) {
		this.gong_sayu = gong_sayu;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getGonggyul_no() {
		return gonggyul_no;
	}

	public void setGonggyul_no(String gonggyul_no) {
		this.gonggyul_no = gonggyul_no;
	}

	@Override
	public String toString() {
		return "Gonggyul [row_no=" + row_no + ", gonggyul_no=" + gonggyul_no
				+ ", univ_cd=" + univ_cd + ", year=" + year + ", term_cd="
				+ term_cd + ", student_no=" + student_no + ", student_name="
				+ student_name + ", gong_ilja_start=" + gong_ilja_start
				+ ", gong_ilja_end=" + gong_ilja_end + ", gong_sayu="
				+ gong_sayu + ", checkbox_flag=" + checkbox_flag + ", regdate="
				+ regdate + ", submit_date=" + submit_date + ", class_cd="
				+ class_cd + ", classday=" + classday
				+ ", classhour_start_time=" + classhour_start_time
				+ ", chk_classname=" + Arrays.toString(chk_classname)
				+ ", tmp_class_cd=" + tmp_class_cd + ", gonggyulSubjectList="
				+ gonggyulSubjectList + "]";
	}

}
