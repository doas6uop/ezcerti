package com.icerti.ezcerti.domain;

public class GonggyulSubject {

	// 공결 기능 수정관련 인자 추가 20160905
	private String gonggyul_no;
	private String subject_cd;
	private String subject_div_cd;
	private String class_name;
	private String class_cd;
	private String classday_name;
	private String classhour_start_time;
	private String chk_visible;
	private String class_real_cnt;
	private String class_total_cnt;
	
	public GonggyulSubject() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GonggyulSubject(String subject_cd, String subject_div_cd,
			String class_name, String class_cd, String classday_name,
			String classhour_start_time, String chk_visible,
			String class_real_cnt, String class_total_cnt) {
		super();
		this.subject_cd = subject_cd;
		this.subject_div_cd = subject_div_cd;
		this.class_name = class_name;
		this.class_cd = class_cd;
		this.classday_name = classday_name;
		this.classhour_start_time = classhour_start_time;
		this.chk_visible = chk_visible;
		this.class_real_cnt = class_real_cnt;
		this.class_total_cnt = class_total_cnt;
	}

	public String getGonggyul_no() {
		return gonggyul_no;
	}

	public void setGonggyul_no(String gonggyul_no) {
		this.gonggyul_no = gonggyul_no;
	}

	public String getClass_real_cnt() {
		return class_real_cnt;
	}

	public void setClass_real_cnt(String class_real_cnt) {
		this.class_real_cnt = class_real_cnt;
	}

	public String getClass_total_cnt() {
		return class_total_cnt;
	}

	public void setClass_total_cnt(String class_total_cnt) {
		this.class_total_cnt = class_total_cnt;
	}

	public String getChk_visible() {
		return chk_visible;
	}

	public void setChk_visible(String chk_visible) {
		this.chk_visible = chk_visible;
	}

	public String getClassday_name() {
		return classday_name;
	}

	public void setClassday_name(String classday_name) {
		this.classday_name = classday_name;
	}

	public String getClasshour_start_time() {
		return classhour_start_time;
	}

	public void setClasshour_start_time(String classhour_start_time) {
		this.classhour_start_time = classhour_start_time;
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

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getClass_cd() {
		return class_cd;
	}

	public void setClass_cd(String class_cd) {
		this.class_cd = class_cd;
	}

	@Override
	public String toString() {
		return "GonggyulSubject [subject_cd=" + subject_cd
				+ ", subject_div_cd=" + subject_div_cd + ", class_name="
				+ class_name + ", class_cd=" + class_cd + ", classday_name="
				+ classday_name + ", classhour_start_time="
				+ classhour_start_time + ", chk_visible=" + chk_visible
				+ ", class_real_cnt=" + class_real_cnt + ", class_total_cnt="
				+ class_total_cnt + "]";
	}

}
