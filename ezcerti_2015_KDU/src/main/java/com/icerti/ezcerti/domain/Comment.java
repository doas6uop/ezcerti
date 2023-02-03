package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Comment {

	private String cmmt_no;
	private String board_no;
	private String cmmt;
	private String reg_user_no;
	private String reg_user_name;
	private Date reg_date;

	public Comment() {
		super();
	}

	public Comment(String cmmt_no, String board_no, String cmmt, String reg_user_no, String reg_user_name, Date reg_date) {
		super();
		this.cmmt_no = cmmt_no;
		this.board_no = board_no;
		this.cmmt = cmmt;
		this.reg_user_no = reg_user_no;
		this.reg_user_name = reg_user_name;
		this.reg_date = reg_date;
	}

	public String getCmmt_no() {
		return cmmt_no;
	}

	public void setCmmt_no(String cmmt_no) {
		this.cmmt_no = cmmt_no;
	}

	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getCmmt() {
		return cmmt;
	}

	public void setCmmt(String cmmt) {
		this.cmmt = cmmt;
	}

	public String getReg_user_no() {
		return reg_user_no;
	}

	public void setReg_user_no(String reg_user_no) {
		this.reg_user_no = reg_user_no;
	}

	public String getReg_user_name() {
		return reg_user_name;
	}

	public void setReg_user_name(String reg_user_name) {
		this.reg_user_name = reg_user_name;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "Comment [cmmt_no=" + cmmt_no + ", board_no=" + board_no + ", cmmt=" + cmmt
		+ ", reg_user_no=" + reg_user_no + ", reg_date=" + reg_date + "]";
	}

}
