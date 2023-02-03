package com.icerti.ezcerti.domain;

import java.sql.Date;

public class Codemaster {
  private String code;          
  private String code_grp_cd;          
  private String code_cd;           
  private String code_grp_name;          
  private String code_name;          
  private String reg_etc;           
  private Date reg_date;
  
  public Codemaster() {
    super();
    // TODO Auto-generated constructor stub
  }

  public Codemaster(String code, String code_grp_cd, String code_cd, String code_grp_name,
      String code_name, String reg_etc, Date reg_date) {
    super();
    this.code = code;
    this.code_grp_cd = code_grp_cd;
    this.code_cd = code_cd;
    this.code_grp_name = code_grp_name;
    this.code_name = code_name;
    this.reg_etc = reg_etc;
    this.reg_date = reg_date;
  }

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public String getCode_grp_cd() {
    return code_grp_cd;
  }

  public void setCode_grp_cd(String code_grp_cd) {
    this.code_grp_cd = code_grp_cd;
  }

  public String getCode_cd() {
    return code_cd;
  }

  public void setCode_cd(String code_cd) {
    this.code_cd = code_cd;
  }

  public String getCode_grp_name() {
    return code_grp_name;
  }

  public void setCode_grp_name(String code_grp_name) {
    this.code_grp_name = code_grp_name;
  }

  public String getCode_name() {
    return code_name;
  }

  public void setCode_name(String code_name) {
    this.code_name = code_name;
  }

  public String getReg_etc() {
    return reg_etc;
  }

  public void setReg_etc(String reg_etc) {
    this.reg_etc = reg_etc;
  }

  public Date getReg_date() {
    return reg_date;
  }

  public void setReg_date(Date reg_date) {
    this.reg_date = reg_date;
  }

  @Override
  public String toString() {
    return "Codemaster [code=" + code + ", code_grp_cd=" + code_grp_cd + ", code_cd=" + code_cd
        + ", code_grp_name=" + code_grp_name + ", code_name=" + code_name + ", reg_etc=" + reg_etc
        + ", reg_date=" + reg_date + "]";
  }
  
}
