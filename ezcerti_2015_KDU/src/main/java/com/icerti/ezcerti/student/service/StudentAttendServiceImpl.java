package com.icerti.ezcerti.student.service;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Claim;
import com.icerti.ezcerti.student.dao.StudentAttendMapper;
import com.icerti.ezcerti.student.dao.StudentClaimMapper;
import com.icerti.ezcerti.util.CompareTime;


@Transactional
@Service
public class StudentAttendServiceImpl implements StudentAttendService {

  @Autowired
  private StudentAttendMapper studentAttendMapper = null;

  @Autowired
  private StudentClaimMapper studentClaimMapper = null;
  
  @Autowired
  private CommonMapper commonMapper = null;
  

  @Override
  public Collection<Attenddethist> getStudentAttendDetailHistoryList(Map<String, Object> map) {
    return studentAttendMapper.getStudentAttendDetailHistoryList(map);
  }

  @Override
  public Map<String, Object> getStudentAttendCnt(Map<String, Object> map) {
    return studentAttendMapper.getStudentAttendCnt(map);
  }

  @Override
  public String checkStudentCert(Map<String, Object> map) {
    String msg = "";
    
    Attendmaster attendmaster = studentAttendMapper.getStudentAttendmaster(map);
    Timestamp time = commonMapper.getCurrentTime();
    
    if(!(map.get("class_cert_no")==null)){
      if(attendmaster != null && attendmaster.getClass_sts_cd().equals("G020C002") && attendmaster.getCert_sts_cd().equals("G021C002")){
        if(map.get("class_cert_no").toString().equals(attendmaster.getClass_cert_no())){ // 인증번호 방식
          if(CompareTime.compareCertTime(time, attendmaster.getClass_cert_issue_time(), attendmaster.getClass_cert_time())){
        	map.put("attendStatus", "present");
	        map.put("attend_sts_cd", "G023C002");
            msg = "attend_present"; //정상출석
          }else{
            map.put("attendStatus", "late");
            map.put("attend_sts_cd", "G023C003");
            msg = "attend_late";    //지각
          }
          
          // 2015.02.09 /////////////////////////
          // - 출결허용시간이 지나면 출결처리가 되지 않도록 처리 (직권처리함)
          //if(msg.equalsIgnoreCase("attend_present")) {
        	  String[] array = ((String)(map.get("class_cd"))).split("\\|");
              map.put("subject_cd", array[3]);
              map.put("subject_div_cd", array[4]);
              
              // 2015.01.02 ////////////////
              // - TB_ATTENDDETHIST 테이블은 출결처리시 데이터가 누적되므로 Update가 아닌 Insert처리를 해야 함
              studentAttendMapper.insertStudentAttendStatus(map);
              //studentAttendMapper.updateStudentAttendStatus(map);
              //////////////////////////////
              studentAttendMapper.updateMasterAttendStatus(map);
          //}
          ///////////////////////////////////////
          
        } else if (map.get("class_cert_no").toString().equals("beacon_cert_method")) { // 비콘 인증 방식
        	if(CompareTime.compareCertTime(time, attendmaster.getClass_cert_issue_time(), attendmaster.getClass_cert_time())){
            	map.put("attendStatus", "present");
    	        map.put("attend_sts_cd", "G023C002");
                msg = "attend_present"; //정상출석
              }else{
                map.put("attendStatus", "late");
                map.put("attend_sts_cd", "G023C003");
                msg = "attend_late";    //지각
              }
              
              //if(msg.equalsIgnoreCase("attend_present") || msg.equalsIgnoreCase("attend_late")) {
            	  String[] array = ((String)(map.get("class_cd"))).split("\\|");
                  map.put("subject_cd", array[3]);
                  map.put("subject_div_cd", array[4]);
                  
                  // 2015.01.02 ////////////////
                  // - TB_ATTENDDETHIST 테이블은 출결처리시 데이터가 누적되므로 Update가 아닌 Insert처리를 해야 함
                  studentAttendMapper.insertStudentAttendStatus(map);
                  //studentAttendMapper.updateStudentAttendStatus(map);
                  //////////////////////////////
                  studentAttendMapper.updateMasterAttendStatus(map);
              //}
        } else {
          msg = "incorrect_cert_no"; //인증번호 불일치
        }
      } else {
        msg = "incorrect_classday"; //강의중이 아님
      }
    }      
    return msg;
  }

  @Override
  public Attenddethist getStudentAttendDetailHistory(Map<String, Object> map) {
    return studentAttendMapper.getStudentAttendDetailHistory(map);
  }

  @Transactional
  @Override
  public String studentAttendClaim(Map<String, Object> map) {
    String msg = "";
    Claim claim = new Claim();
    
    Attendmaster am = studentAttendMapper.getStudentAttendmaster(map);
    Attenddethist adh = studentAttendMapper.getStudentAttendDetailHistory(map);
    
    if(am != null && adh != null){
      claim.setUniv_cd(am.getUniv_cd());
      claim.setTerm_cd(am.getTerm_cd());
      claim.setYear(map.get("year").toString());
      claim.setClass_cd(am.getClass_cd());
      claim.setClassday(am.getClassday());
      claim.setClasshour_start_time(am.getClasshour_start_time());
      claim.setClass_name(am.getClass_name());
      claim.setProf_no(am.getProf_no());
      claim.setProf_name(am.getProf_name());
      claim.setStudent_no(adh.getStudent_no());
      claim.setStudent_name(adh.getStudent_name());
      claim.setStudent_coll_name(adh.getStudent_coll_name());
      claim.setStudent_dept_name(adh.getStudent_dept_name());
      claim.setBefore_claim_cd(adh.getAttend_sts_cd());
      claim.setAsk_claim_cd(map.get("ask_claim_cd").toString());
      claim.setClaim_sts_cd("G028C001");
      claim.setAsk_claim_content(map.get("ask_claim_content").toString());
      
      studentClaimMapper.insertStudentAttendClaim(claim);
      msg = "ok";
    }else{
      msg = "null";
    }
    
    return msg;
  }

  @Transactional
  @Override
  public String studentAttendImprove(Map<String, Object> map) {
    String msg = "";
    Claim claim = new Claim();
    
    Attendmaster am = studentAttendMapper.getStudentAttendmaster(map);
    Attenddethist adh = studentAttendMapper.getStudentAttendDetailHistory(map);
    
    if(am != null && adh != null){
      claim.setUniv_cd(am.getUniv_cd());
      claim.setTerm_cd(am.getTerm_cd());
      claim.setYear(map.get("year").toString());
      claim.setClass_cd(am.getClass_cd());
      claim.setClassday(am.getClassday());
      claim.setClasshour_start_time(am.getClasshour_start_time());
      claim.setClass_name(am.getClass_name());
      claim.setProf_no(am.getProf_no());
      claim.setProf_name(am.getProf_name());
      claim.setAsk_claim_content(map.get("ask_claim_content").toString());
      claim.setStudent_no(map.get("student_no").toString());
      
      studentClaimMapper.insertStudentAttendImprove(claim);
      msg = "ok";
    }else{
      msg = "null";
    }
    
    return msg;
  }

  @Transactional
  @Override
  public String studentAttendImproveDelete(Map<String, Object> map) {
    String msg = "";
    Claim claim = new Claim();
    
    if(map != null){
      claim.setImprove_no(map.get("improve_no").toString());
      
      studentClaimMapper.deleteStudentAttendImprove(claim);
      msg = "ok";
    }else{
      msg = "null";
    }
    
    return msg;
  }  
}
