package com.icerti.ezcerti.domain;

import java.util.Date;

public class Memo {

	private String row_no;
	private String memo_no;
	private String univ_cd;
	private String message;
	private String from_user_no;
	private String to_user_no;
	private String from_user_name;
	private String to_user_name;
	private Date reg_date;
	private Date receive_date;

	public Memo() {
		super();
	}

	public Memo(String memo_no, String univ_cd, String message, String from_user_no, String to_user_no, 
			String from_user_name, String to_user_name, Date reg_date, Date receive_date) {
		super();
		this.memo_no = memo_no;
		this.univ_cd = univ_cd;
		this.message = message;
		this.from_user_no = from_user_no;
		this.to_user_no = to_user_no;
		this.from_user_name = from_user_name;
		this.to_user_name = to_user_name;
		this.reg_date = reg_date;
		this.receive_date =receive_date;
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}

	public String getMemo_no() {
		return memo_no;
	}

	public void setMemo_no(String memo_no) {
		this.memo_no = memo_no;
	}

  	public String getUniv_cd() {
  		return univ_cd;
	}
	
	public void setUniv_cd(String univ_cd) {
		this.univ_cd = univ_cd;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getFrom_user_no() {
		return from_user_no;
	}

	public void setFrom_user_no(String from_user_no) {
		this.from_user_no = from_user_no;
	}

	public String getTo_user_no() {
		return to_user_no;
	}

	public void setTo_user_no(String to_user_no) {
		this.to_user_no = to_user_no;
	}

	public String getFrom_user_name() {
		return from_user_name;
	}

	public void setFrom_user_name(String from_user_name) {
		this.from_user_name = from_user_name;
	}

	public String getTo_user_name() {
		return to_user_name;
	}

	public void setTo_user_name(String to_user_name) {
		this.to_user_name = to_user_name;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getReceive_date() {
		return receive_date;
	}

	public void setReceive_date(Date receive_date) {
		this.receive_date = receive_date;
	}

	@Override
	public String toString() {
		return "Memo [memo_no=" + memo_no + ", message=" + message + ", from_user_no=" + from_user_no
		+ ", to_user_no=" + to_user_no + ", reg_date=" + reg_date + ", receive_date="
		+ receive_date + "]";
	}

}
