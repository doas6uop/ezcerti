package com.icerti.ezcerti.domain;

public class Log {

	private String row_no;
	private String type;
	private String class_cd;
	private String classday;
	private String prof_no;
	private String student_no;
	private String msg;
	private String reg_date;
	
	public Log() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Log(String row_no, String type, String class_cd, String classday,
			String prof_no, String student_no, String msg,
			String reg_date) {
		super();
		this.row_no = row_no;
		this.type = type;
		this.class_cd = class_cd;
		this.classday = classday;
		this.prof_no = prof_no;
		this.student_no = student_no;
		this.msg = msg;
		this.reg_date = reg_date;
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getProf_no() {
		return prof_no;
	}

	public void setProf_no(String prof_no) {
		this.prof_no = prof_no;
	}

	public String getStudent_no() {
		return student_no;
	}

	public void setStudent_no(String student_no) {
		this.student_no = student_no;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "Coll [row_no=" + row_no + ", type=" + type + ", class_cd="
				+ class_cd + ", classday=" + classday + ", prof_no=" + prof_no
				+ ", student_no=" + student_no + ", msg="
				+ msg + ", reg_date=" + reg_date + "]";
	}


	
}
