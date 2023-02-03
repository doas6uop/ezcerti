package com.icerti.ezcerti.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CompareTime {
  /**
   * true == 출석, false == 지각
   * @param currentTime 현재시간
   * @param certIssueTime 인증번호 발급시간
   * @param seconds 유효시간
   * @return
   */
  public static boolean compareCertTime(Timestamp currentTime, Timestamp certIssueTime, int seconds ) {

    long time = (currentTime.getTime() - certIssueTime.getTime()) / 1000;
    
    if(time > seconds){
      return false;
    }else{
      return true;
    }
  }
  
  /**
   * @param currentTime
   * @param classday
   * @param classhour_start_time
   * @return
   */
  public static boolean compareCurrentTime(Timestamp currentTime, String classday, String classhour_start_time){
    
    String classDateTime = classday+" "+classhour_start_time;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    Date cDate = null;
    try {
      cDate = sdf.parse(classDateTime);
    } catch (ParseException e) {
      e.printStackTrace();
    } 
    Timestamp cDateTime = new Timestamp(cDate.getTime());
    if(cDateTime.compareTo(currentTime)<1){
      return true;
    }else{
      return false;
    }
  }

}
