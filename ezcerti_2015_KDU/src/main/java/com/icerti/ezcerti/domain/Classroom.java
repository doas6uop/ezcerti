package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Classroom {

	private String row_no;
	private String univ_cd;
	private String year;
	private String term_cd;
	private String classroom_no;
	private String classroom_name;
	private Date reserve_date;
	private String start_time;
	private String end_time;
	
	private String prof_no;
	private String prof_name;
	
	public Classroom() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Classroom(String row_no, String univ_cd, String year,
			String term_cd, String classroom_no, String classroom_name,
			Date reserve_date, String start_time, String end_time,
			String prof_no, String prof_name) {
		super();
		this.row_no = row_no;
		this.univ_cd = univ_cd;
		this.year = year;
		this.term_cd = term_cd;
		this.classroom_no = classroom_no;
		this.classroom_name = classroom_name;
		this.reserve_date = reserve_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.prof_no = prof_no;
		this.prof_name = prof_name;
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

	public String getClassroom_no() {
		return classroom_no;
	}

	public void setClassroom_no(String classroom_no) {
		this.classroom_no = classroom_no;
	}

	public String getClassroom_name() {
		return classroom_name;
	}

	public void setClassroom_name(String classroom_name) {
		this.classroom_name = classroom_name;
	}

	public Date getReserve_date() {
		return reserve_date;
	}

	public void setReserve_date(Date reserve_date) {
		this.reserve_date = reserve_date;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	@Override
	public String toString() {
		return "Classroom [row_no=" + row_no + ", univ_cd=" + univ_cd
				+ ", year=" + year + ", term_cd=" + term_cd + ", classroom_no="
				+ classroom_no + ", classroom_name=" + classroom_name
				+ ", reserve_date=" + reserve_date + ", start_time="
				+ start_time + ", end_time=" + end_time + ", prof_no="
				+ prof_no + ", prof_name=" + prof_name + "]";
	}
}