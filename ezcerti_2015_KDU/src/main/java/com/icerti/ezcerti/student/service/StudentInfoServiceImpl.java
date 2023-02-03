package com.icerti.ezcerti.student.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.student.dao.StudentInfoMapper;


@Transactional
@Service
public class StudentInfoServiceImpl implements StudentInfoService {

  @Autowired
  private StudentInfoMapper studentInfoMapper = null;
  
  @Transactional
  @Override
  public String updateStudentInfo(Student student) {
    String msg = "";
    if(student.getStudent_passwd()!=null&&!student.getStudent_passwd().equals("")){
      PasswordEncoder encoder = new ShaPasswordEncoder(256);
      student.setStudent_passwd(encoder.encodePassword(student.getStudent_passwd(), null));
      System.out.println(student.getStudent_passwd());
    }else if(student.getStudent_passwd()==null){
      msg = "오류가 발생하였습니다.";
    }
    try{
      studentInfoMapper.updateStudentInfo(student);
      msg = "정상 처리되었습니다.";
    }catch(Exception e){
      msg = "오류가 발생하였습니다.";
      e.printStackTrace();
    }
    return msg;
  }

  // 2014.12.26 - 추가
  /*
  @Transactional
  @Override
  public String updateStudentInfo(UserInfo userInfo) {
    String msg = "";
    if(userInfo.getUser_passwd()!=null&&!userInfo.getUser_passwd().equals("")){
      PasswordEncoder encoder = new ShaPasswordEncoder(256);
      userInfo.setUser_passwd(encoder.encodePassword(userInfo.getUser_passwd(), null));
      System.out.println(userInfo.getUser_passwd());
    }else if(userInfo.getUser_passwd()==null){
      msg = "오류가 발생하였습니다.";
    }
    try{
      studentInfoMapper.updateStudentInfo(userInfo);
      msg = "정상 처리되었습니다.";
    }catch(Exception e){
      msg = "오류가 발생하였습니다.";
      e.printStackTrace();
    }
    return msg;
  }
*/

}
