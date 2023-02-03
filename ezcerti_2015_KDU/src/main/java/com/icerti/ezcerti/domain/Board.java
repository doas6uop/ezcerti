package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.util.Collection;

public class Board {

	private String row_no;
	private String board_no;
	private String univ_cd;
	private String title;
	private String contents;
	private String board_type;
	private String board_subtype;
	private int view_cnt;
	private String reg_user_no;
	private String reg_user_name;
	private String mod_user_no;
	private String mod_user_name;
	private Date reg_date;
	private Date mod_date;
	
	private String cmmt_no;
	private String cmmt;
	private int cmmt_cnt;
	
	private Collection<Comment> commentList;
	private Collection<BoardFile> boardFileList;

	public Board() {
		super();
	}

	public Board(String board_no, String univ_cd, String title, String contents, 
			String board_type, String board_subtype, int view_cnt, String reg_user_no, String reg_user_name, 
			String mod_user_no, String mod_user_name, Date reg_date, Date mod_date, String cmmt_no, String cmmt) {
		super();
		this.board_no = board_no;
		this.univ_cd = univ_cd;
		this.title = title;
		this.contents = contents;
		this.board_type = board_type;
		this.board_subtype = board_subtype;
		this.view_cnt = view_cnt;
		this.reg_user_no = reg_user_no;
		this.reg_user_name = reg_user_name;
		this.mod_user_no = mod_user_no;
		this.mod_user_name = mod_user_name;
		this.reg_date = reg_date;
		this.mod_date = mod_date;
		this.cmmt_no = cmmt_no;
		this.cmmt = cmmt;
	}

	public String getRow_no() {
		return row_no;
	}

	public void setRow_no(String row_no) {
		this.row_no = row_no;
	}

	public String getBoard_no() {
		return board_no;
	}

	public void setBoard_no(String board_no) {
		this.board_no = board_no;
	}

	public String getUniv_cd() {
		return univ_cd;
	}

	public void setUniv_cd(String univ_cd) {
		this.univ_cd = univ_cd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getBoard_subtype() {
		return board_subtype;
	}

	public void setBoard_subtype(String board_subtype) {
		this.board_subtype = board_subtype;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
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

	public String getMod_user_no() {
		return mod_user_no;
	}

	public void setMod_user_no(String mod_user_no) {
		this.mod_user_no = mod_user_no;
	}

	public String getMod_user_name() {
		return mod_user_name;
	}

	public void setMod_user_name(String mod_user_name) {
		this.mod_user_name = mod_user_name;
	}

	public Date getMod_date() {
		return mod_date;
	}

	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getCmmt_no() {
		return cmmt_no;
	}

	public void setCmmt_no(String cmmt_no) {
		this.cmmt_no = cmmt_no;
	}

	public String getCmmt() {
		return cmmt;
	}

	public void setCmmt(String cmmt) {
		this.cmmt = cmmt;
	}

	public int getCmmt_cnt() {
		return cmmt_cnt;
	}

	public void setCmmt_cnt(int cmmt_cnt) {
		this.cmmt_cnt = cmmt_cnt;
	}

	public Collection<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(Collection<Comment> commentList) {
		this.commentList = commentList;
	}
	
	public Collection<BoardFile> getBoardFileList() {
		return boardFileList;
	}

	public void setBoardFileList(Collection<BoardFile> boardFileList) {
		this.boardFileList = boardFileList;
	}

	@Override
	public String toString() {
		return "Board [board_no=" + board_no + ", title=" + title + ", contents=" + contents
		+ ", board_type=" + board_type + ", view_cnt=" + view_cnt + ", reg_user_no="
		+ reg_user_no + ", reg_date=" + reg_date + "]";
	}

}
