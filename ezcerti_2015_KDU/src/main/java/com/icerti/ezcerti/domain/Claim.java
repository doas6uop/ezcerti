package com.icerti.ezcerti.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Claim {

  private String claim_no;
  private String improve_no;
  private String year;
  private String univ_cd;
  private String term_cd;
  private String class_cd;
  private Date classday;
  private String classhour_start_time;
  private String class_name;
  private String prof_no;
  private String prof_name;
  private String student_no;
  private String student_name;
  private String student_coll_name;
  private String student_dept_name;
  private String before_claim_cd;
  private String ask_claim_cd;
  private String reply_claim_cd;
  private String claim_sts_cd;
  private String ask_claim_content;
  private String class_improve_content;
  private String reply_claim_content;
  private Timestamp ask_claim_time;
  private Timestamp reply_claim_time;
  private String reg_etc;
  private Timestamp reg_date;

  private String before_claim_name;
  private String ask_claim_name;
  private String reply_claim_name;
  private String claim_sts_name;

  public Claim() {
    super();
  }

  public Claim(String claim_no, String univ_cd, String year, String term_cd, String class_cd, Date classday,
      String classhour_start_time, String class_name, String prof_no, String prof_name,
      String student_no, String student_name, String student_coll_name, String student_dept_name,
      String before_claim_cd, String ask_claim_cd, String reply_claim_cd, String claim_sts_cd,
      String ask_claim_content, String reply_claim_content, Timestamp ask_claim_time,
      Timestamp reply_claim_time, String reg_etc, Timestamp reg_date, String before_claim_name,
      String ask_claim_name, String reply_claim_name, String claim_sts_name) {
    super();
    this.claim_no = claim_no;
    this.year = year;
    this.univ_cd = univ_cd;
    this.term_cd = term_cd;
    this.class_cd = class_cd;
    this.classday = classday;
    this.classhour_start_time = classhour_start_time;
    this.class_name = class_name;
    this.prof_no = prof_no;
    this.prof_name = prof_name;
    this.student_no = student_no;
    this.student_name = student_name;
    this.student_coll_name = student_coll_name;
    this.student_dept_name = student_dept_name;
    this.before_claim_cd = before_claim_cd;
    this.ask_claim_cd = ask_claim_cd;
    this.reply_claim_cd = reply_claim_cd;
    this.claim_sts_cd = claim_sts_cd;
    this.ask_claim_content = ask_claim_content;
    this.reply_claim_content = reply_claim_content;
    this.ask_claim_time = ask_claim_time;
    this.reply_claim_time = reply_claim_time;
    this.reg_etc = reg_etc;
    this.reg_date = reg_date;
    this.before_claim_name = before_claim_name;
    this.ask_claim_name = ask_claim_name;
    this.reply_claim_name = reply_claim_name;
    this.claim_sts_name = claim_sts_name;
  }

  public String getClaim_no() {
    return claim_no;
  }

  public void setClaim_no(String claim_no) {
    this.claim_no = claim_no;
  }
  
  public String getImprove_no() {
	return improve_no;
  }

  public void setImprove_no(String improve_no) {
	this.improve_no = improve_no;
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

  public String getClass_cd() {
    return class_cd;
  }

  public void setClass_cd(String class_cd) {
    this.class_cd = class_cd;
  }

  public Date getClassday() {
    return classday;
  }

  public void setClassday(Date classday) {
    this.classday = classday;
  }

  public String getClasshour_start_time() {
    return classhour_start_time;
  }

  public void setClasshour_start_time(String classhour_start_time) {
    this.classhour_start_time = classhour_start_time;
  }

  public String getClass_name() {
    return class_name;
  }

  public void setClass_name(String class_name) {
    this.class_name = class_name;
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

  public String getStudent_coll_name() {
    return student_coll_name;
  }

  public void setStudent_coll_name(String student_coll_name) {
    this.student_coll_name = student_coll_name;
  }

  public String getStudent_dept_name() {
    return student_dept_name;
  }

  public void setStudent_dept_name(String student_dept_name) {
    this.student_dept_name = student_dept_name;
  }

  public String getBefore_claim_cd() {
    return before_claim_cd;
  }

  public void setBefore_claim_cd(String before_claim_cd) {
    this.before_claim_cd = before_claim_cd;
  }

  public String getAsk_claim_cd() {
    return ask_claim_cd;
  }

  public void setAsk_claim_cd(String ask_claim_cd) {
    this.ask_claim_cd = ask_claim_cd;
  }

  public String getReply_claim_cd() {
    return reply_claim_cd;
  }

  public void setReply_claim_cd(String reply_claim_cd) {
    this.reply_claim_cd = reply_claim_cd;
  }

  public String getClaim_sts_cd() {
    return claim_sts_cd;
  }

  public void setClaim_sts_cd(String claim_sts_cd) {
    this.claim_sts_cd = claim_sts_cd;
  }

  public String getAsk_claim_content() {
    return ask_claim_content;
  }

  public void setAsk_claim_content(String ask_claim_content) {
    this.ask_claim_content = ask_claim_content;
  }
  
  public String getClass_improve_content() {
	return class_improve_content;
  }

  public void setClass_improve_content(String class_improve_content) {
	this.class_improve_content = class_improve_content;
  }

  public String getReply_claim_content() {
    return reply_claim_content;
  }

  public void setReply_claim_content(String reply_claim_content) {
    this.reply_claim_content = reply_claim_content;
  }

  public Timestamp getAsk_claim_time() {
    return ask_claim_time;
  }

  public void setAsk_claim_time(Timestamp ask_claim_time) {
    this.ask_claim_time = ask_claim_time;
  }

  public Timestamp getReply_claim_time() {
    return reply_claim_time;
  }

  public void setReply_claim_time(Timestamp reply_claim_time) {
    this.reply_claim_time = reply_claim_time;
  }

  public String getReg_etc() {
    return reg_etc;
  }

  public void setReg_etc(String reg_etc) {
    this.reg_etc = reg_etc;
  }

  public Timestamp getReg_date() {
    return reg_date;
  }

  public void setReg_date(Timestamp reg_date) {
    this.reg_date = reg_date;
  }

  public String getBefore_claim_name() {
    return before_claim_name;
  }

  public void setBefore_claim_name(String before_claim_name) {
    this.before_claim_name = before_claim_name;
  }

  public String getAsk_claim_name() {
    return ask_claim_name;
  }

  public void setAsk_claim_name(String ask_claim_name) {
    this.ask_claim_name = ask_claim_name;
  }

  public String getReply_claim_name() {
    return reply_claim_name;
  }

  public void setReply_claim_name(String reply_claim_name) {
    this.reply_claim_name = reply_claim_name;
  }

  public String getClaim_sts_name() {
    return claim_sts_name;
  }

  public void setClaim_sts_name(String claim_sts_name) {
    this.claim_sts_name = claim_sts_name;
  }

  @Override
  public String toString() {
    return "Claim [claim_no=" + claim_no + ", univ_cd=" + univ_cd + ", term_cd=" + term_cd
        + ", class_cd=" + class_cd + ", classday=" + classday + ", classhour_start_time="
        + classhour_start_time + ", class_name=" + class_name + ", prof_no=" + prof_no
        + ", prof_name=" + prof_name + ", student_no=" + student_no + ", student_name="
        + student_name + ", student_coll_name=" + student_coll_name + ", student_dept_name="
        + student_dept_name + ", before_claim_cd=" + before_claim_cd + ", ask_claim_cd="
        + ask_claim_cd + ", reply_claim_cd=" + reply_claim_cd + ", claim_sts_cd=" + claim_sts_cd
        + ", ask_claim_content=" + ask_claim_content + ", reply_claim_content="
        + reply_claim_content + ", ask_claim_time=" + ask_claim_time + ", reply_claim_time="
        + reply_claim_time + ", reg_etc=" + reg_etc + ", reg_date=" + reg_date
        + ", before_claim_name=" + before_claim_name + ", ask_claim_name=" + ask_claim_name
        + ", reply_claim_name=" + reply_claim_name + ", claim_sts_name=" + claim_sts_name + "]";
  }
  
}
