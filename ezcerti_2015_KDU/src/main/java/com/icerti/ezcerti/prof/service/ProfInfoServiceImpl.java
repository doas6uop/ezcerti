package com.icerti.ezcerti.prof.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.prof.dao.ProfInfoMapper;


@Transactional
@Service
public class ProfInfoServiceImpl implements ProfInfoService {

  @Autowired
  private ProfInfoMapper profInfoMapper = null;

  @Override
  public String updateProfInfo(Prof prof) {
    String msg = "";
    if(prof.getProf_passwd()!=null&&!prof.getProf_passwd().equals("")){
      PasswordEncoder encoder = new ShaPasswordEncoder(256);
      prof.setProf_passwd(encoder.encodePassword(prof.getProf_passwd(), null));
    }else if(prof.getProf_passwd()==null){
      msg = "오류발생";
    }
    try{
      profInfoMapper.updateProfInfo(prof);
      msg = "정상 처리되었습니다.";
    }catch(Exception e){
      msg = "오류가 발생했습니다.";
      e.printStackTrace();
    }
    return msg;
  }



}
