package com.icerti.ezcerti.domain;

import java.util.Date;

public class BoardFile {

	private String row_no;
	private String file_no;
	private String board_no;
	private String org_file_name;
	private String saved_file_name;
	private String file_path;
	private Date reg_date;

	public BoardFile() {
		super();
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

	public String getSaved_file_name() {
		return saved_file_name;
	}

	public void setSaved_file_name(String saved_file_name) {
		this.saved_file_name = saved_file_name;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

}
