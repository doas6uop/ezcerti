package com.icerti.ezcerti.domain;

public class MainStats {

	private String prof_no;
	private String prof_name;
	private String class_name;
	private String prof_ab_cnt;
	private String class_name_ab_cnt;
	
	public MainStats() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MainStats(String prof_no, String prof_name, String class_name,
			String prof_ab_cnt, String class_name_ab_cnt) {
		super();
		this.prof_no = prof_no;
		this.prof_name = prof_name;
		this.class_name = class_name;
		this.prof_ab_cnt = prof_ab_cnt;
		this.class_name_ab_cnt = class_name_ab_cnt;
	}

	public String getClass_name_ab_cnt() {
		return class_name_ab_cnt;
	}

	public void setClass_name_ab_cnt(String class_name_ab_cnt) {
		this.class_name_ab_cnt = class_name_ab_cnt;
	}

	public String getProf_no() {
		return prof_no;
	}

	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
	}

	public String getProf_name() {
		return prof_name;
	}

	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getProf_ab_cnt() {
		return prof_ab_cnt;
	}

	public void setProf_ab_cnt(String prof_ab_cnt) {
		this.prof_ab_cnt = prof_ab_cnt;
	}

	@Override
	public String toString() {
		return "MainStats [prof_no=" + prof_no + ", prof_name=" + prof_name
				+ ", class_name=" + class_name + ", prof_ab_cnt=" + prof_ab_cnt
				+ ", class_name_ab_cnt=" + class_name_ab_cnt + "]";
	}

}
