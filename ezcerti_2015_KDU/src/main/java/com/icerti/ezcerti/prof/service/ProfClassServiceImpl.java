package com.icerti.ezcerti.prof.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.AttendAppInfo;
import com.icerti.ezcerti.domain.AttendBatch;
import com.icerti.ezcerti.domain.Attenddethist;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.ClassOffRequest;
import com.icerti.ezcerti.domain.Classday;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.Classroom;
import com.icerti.ezcerti.prof.dao.ProfClassMapper;
import com.icerti.ezcerti.util.CompareTime;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;
import com.icerti.ezcerti.util.CommonUtil;

@Service
public class ProfClassServiceImpl implements ProfClassService{
	
	private static final Logger logger = LoggerFactory.getLogger(ProfClassService.class);
	
	@Autowired
	private ProfClassMapper profClassMapper = null;

	@Autowired
	private CommonService commonService = null;
	
	@Autowired
	private CommonMapper commonMapper = null;

	@Value("#{config['makeup_lesson_limit']}") 
	String globalMakLessonLimit;

	@Value("#{config['makeup_lesson_approval']}") 
	String globalMakeupLessonApproval;

	@Override
	public PageBean<Attendmaster> getAttendmasterList(Map<String, Object> map) {
		PageBean<Attendmaster> pageBean = new PageBean<Attendmaster>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		int allCnt = profClassMapper.getAttendmasterListCount(map);
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(profClassMapper.getAttendmasterList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

  @Transactional
  @Override
  public void updateClassCert(Map<String, Object> map) {
    profClassMapper.updateClassCert(map);
  }

  @Override
  public Collection<Classhour> getClasshourList(Map<String, Object> map) {
    return profClassMapper.getClasshourList(map);
  }
  
  @Override
  public Collection<Classroom> getClassroomList(Map<String, Object> map) {
	return profClassMapper.getClassroomList(map);
  }
  
  @Override
  public Collection<Classroom> getClassroomList2(Map<String, Object> map) {
	return profClassMapper.getClassroomList2(map);
  }
  
  @Transactional
  @Override
  public String classOffRequest(Map<String, Object> map) {
		String msg = "";

		try {
			// 휴,보강 정보를 신청정보에 등록 처리
			// - 기 등록여부 확인
			// - 신청정보에 등록
			// - 휴강 신청처리를 사용할 경우 종료
			// - 휴강 신청처리를 사용하지 않응 경우 해당 강의 휴강 처리, 보강 등록 처리
			
			// 신청상태인 정보만 조회하도록 함
			map.put("proc_status", "G030C001");
			
			ClassOffRequest objClassOffRequest = getClassOffRequestView(map);
			
			// 이미 동일 강의가 휴강 신청되어 있는 경우
			if(objClassOffRequest != null) {
				msg = "already request";
			}
			// 휴강신청되어 있지 않은 경우
			else {
				// 휴,보강 신청처리를 사용하지 않는다면
				if(globalMakeupLessonApproval != null && globalMakeupLessonApproval.equalsIgnoreCase("N")) {
					// 휴,보강 신청처리를 사용하지 않는 경우 신청 정보가 없기 때문에
					// 화면에서 전달받은 정보를 참조해야 함
					if(objClassOffRequest == null) {
					    map.put("classroom_no",	map.get("alter_classroom_no").toString());
					}
					
					msg = classOffConfirm(objClassOffRequest, map);
					
					// 신청처리를 사용하지 않는 경우 신청상태는 승인으로 처리				
					map.put("proc_status", "G030C002");
					map.put("proc_reason", "자동승인");
				} 
				// 휴,보강 신청처리를 사용한다면
				else {
					// class_prof_cd 값을 휴강신청(G018C003)으로 지정
					map.put("prog_cd", "G018C003");			
					profClassMapper.updateClassoffRequestAttendmaster(map);
					
					msg = "success request";

					// 신청처리를 사용하는 경우 신청상태는 신청으로 처리
					map.put("proc_status", "G030C001");
					map.put("proc_reason", "");
				}		
				
				map.put("reserve_seq", "");

				// 휴강신청정보 등록 처리
				profClassMapper.insertClassoffRequest(map);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			msg = "오류가 발생했습니다.";
		}
		
		return msg;
  }
  
  @Transactional
  @Override
  public String classOffConfirm(ClassOffRequest objClassOffRequest, Map<String, Object> map) {
		String msg = "";

		try {
			// 휴,보강 신청처리를 사용하지 않는다면 objClassOffRequest는 Null 임
			if(objClassOffRequest != null) {
			    map.put("rdo_alter",					"ok");
			    map.put("univ_cd",						objClassOffRequest.getUniv_cd());
				map.put("year",							objClassOffRequest.getYear());
			    map.put("term_cd",						objClassOffRequest.getTerm_cd());
			    map.put("prof_no",						objClassOffRequest.getProf_no());
			    map.put("classday",						objClassOffRequest.getClassday().toString());
			    map.put("class_cd",						objClassOffRequest.getClass_cd());
			    map.put("classhour_start_time",			objClassOffRequest.getClasshour_start_time());
			    map.put("classhour_end_time",			objClassOffRequest.getClasshour_end_time());
		        map.put("classroom_no",					objClassOffRequest.getAdd_classroom_no());
			    
		        map.put("alterClassday",				objClassOffRequest.getAdd_classday().toString());
		        map.put("alter_classhour_start_time",	objClassOffRequest.getAdd_classhour_start_time());
		        map.put("alter_classhour_end_time",		objClassOffRequest.getAdd_classhour_end_time());
		        map.put("alter_classhour_name", "");
		        map.put("alter_classoff_reason",		objClassOffRequest.getProc_reason());
		        map.put("alter_classroom_no",			objClassOffRequest.getAdd_classroom_no());
			}
			
			// 보강이 있는 경우
			if(map.get("rdo_alter").toString().equals("ok")) {
				// 강의가 존재하는지 않는 경우
				if(profClassMapper.checkAlterClass(map) == 0){
					String currClassday = map.get("classday").toString();
					String dateTime = map.get("alterClassday").toString() + " " + map.get("alter_classhour_start_time").toString();
					String dateTime2 = map.get("classday").toString() + " " + map.get("classhour_start_time").toString();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					
					Date alterClassTime = sdf.parse(dateTime);
					Date beforeClassTime = sdf.parse(dateTime2);
					map.put("alterClassTime", alterClassTime);
					map.put("beforeClassTime", beforeClassTime);
					logger.info("ALTERCLASSTIME - PROF_NO : " + map.get("prof_no") + ", "+ map.get("alterClassTime").toString());

					Classday classday = profClassMapper.getClassday(map);
					
					// 강의일이 존재하는 경우 (V_CHUL_VW_CLASSDAY)
					if(classday != null) {
						map.put("classday_no", classday.getClassday_no());
						map.put("classday_name", classday.getClassday_name());
	            
						//현재일 이후 강의일 경우
						if(!CompareTime.compareCurrentTime(commonMapper.getCurrentTime(), map.get("alterClassday").toString(), map.get("alter_classhour_start_time").toString())) {
							// 보강데이터 등록
							profClassMapper.insertClassoffAttendmasterAddInfo(map);
	            	        		
							msg = "success";
						} 
						// 현재일  이전 강의일 경우
						else {
							// 휴강 제한일이 없는 경우 이전 강의 보강 처리
							if(globalMakLessonLimit != null && globalMakLessonLimit.equalsIgnoreCase("0")) {
								profClassMapper.insertClassoffEarlyAttendmasterAddInfo(map);
								
								msg = "success";
							} 
							// 휴강 제한일이 지정된 경우 보강불가 처리
							else {
								msg = "earlier than today";
							}
						}
						
						// 보강정보가 정상적으로 처리된 경우 출결정보 변경 처리
						if(msg != null && msg.equalsIgnoreCase("success")) {
							// 강의정보를 휴강으로 상태변경
							profClassMapper.updateClassoffAttendmaster(map);
							// 출결이력정보의 강의상태를 휴강으로, 출결상태를 출결전으로 변경
							profClassMapper.updateClassoffAttenddethist(map);
							
							//SMS 전송 ////////////////////////////////
							// SMS 전송
							map.put("sms_type", "CLASSOFF");
							commonService.sendSMS(map);
							/////////////////////////////////////////								
							
							// 강의실 예약정보 처리 ///////////////////////////
							// - 보강정보는 강의실 사용 뷰에서 처리되기 때문에 별도로 예약정보를 등록할 필요 없음 
							//map.put("reserve_reason", "CLASSOFF");
							//profClassMapper.insertClasshourReserve(map);
							/////////////////////////////////////////								
						}
					}
					// 강의일이 존재하지 않는 경우 (V_CHUL_VW_CLASSDAY)
					else {
						msg = "classday not exist";
					}
				}
				// 강의가 존재하는 경우
				else {
					msg = "already exist";
				}			
			}
			// 보강이 없는 경우
			else {
				System.out.println("-> 보강없음");
			    map.put("rdo_alter",			"no");
			    map.put("univ_cd",				map.get("univ_cd").toString());
			    map.put("year",					map.get("year").toString());
			    map.put("term_cd",				map.get("term_cd").toString());
			    map.put("class_cd",				map.get("class_cd").toString());
			    map.put("classday",				map.get("classday").toString());
			    map.put("classhour_start_time",	map.get("classhour_start_time").toString());
			    map.put("prof_no",				map.get("prof_no").toString());
			    
				// 강의정보를 휴강으로 상태변경
				profClassMapper.updateClassoffAttendmaster(map);
				// 출결이력정보의 강의상태를 휴강으로, 출결상태를 출결전으로 변경
				profClassMapper.updateClassoffAttenddethist(map);
				
				msg = "success";
			}			
		} catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			msg = "오류가 발생했습니다.";
		}
		
		return msg;
  }  

  @Transactional
  @Override
  public String classOff(Map<String, Object> map) {
    String msg = "";

    if(map.get("rdo_alter").toString().equals("no")){
      profClassMapper.updateClassoffAttendmaster(map);
      // 2015.01.05 /////////////////
      // - 휴강시 학사정보 변경을 위한 처리
      //profClassMapper.updateClassoffStatusAttendmaster(map);
      ///////////////////////////////
      profClassMapper.updateClassoffAttenddethist(map);
      msg = "success";
      logger.info("CLASSOFF -- class_cd : " + map.get("class_cd") + ", classday : " + map.get("classday"));
    }else if(map.get("rdo_alter").toString().equals("ok")){
      if(profClassMapper.checkAlterClass(map) == 0){
        /*
         * 보강등록을 위해 같은 시간에 강의가 존재하는지 확인
         */
    	  String currClassday = map.get("classday").toString();
          String dateTime = map.get("alterClassday").toString() + " " + map.get("alter_classhour_start_time").toString();
          String dateTime2 = map.get("classday").toString() + " " + map.get("classhour_start_time").toString();
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
          try {
            Date alterClassTime = sdf.parse(dateTime);
            Date beforeClassTime = sdf.parse(dateTime2);
            map.put("alterClassTime", alterClassTime);
            map.put("beforeClassTime", beforeClassTime);
            logger.info("ALTERCLASSTIME - PROF_NO:[" + map.get("prof_no") + "],alterClassTime:["+ map.get("alterClassTime").toString()+"],beforeClassTime:["+map.get("beforeClassTime").toString()+"]");

            Classday classday = profClassMapper.getClassday(map);
            map.put("classday_no", classday.getClassday_no());
            map.put("classday_name", classday.getClassday_name());

            if(!CompareTime.compareCurrentTime(commonMapper.getCurrentTime(), map.get("alterClassday").toString(), map.get("alter_classhour_start_time").toString())){
            	// - 보강 등록(유형:보강, 상태:강의전) 
            	profClassMapper.insertClassoffAttendmasterAddInfo(map);
            	
            	msg = "success";
            } else {
               	profClassMapper.insertClassoffEarlyAttendmasterAddInfo(map);
                    
               	msg = "success";
            }
            
            // 정상 처리된 경우 //////////////////////////
            // - 현재 강의 상태 변경
            // - 휴,보강 신청정보 등록
            if(msg.equalsIgnoreCase("success")) {
                // 강의상태 변경 //////////////////////////
            	// - 현재 강의 정보 변경(유형:휴강, 상태:완료) 
            	profClassMapper.updateClassoffAttendmaster(map);
            	// - 현재 강의 출결이력 정보 변경(유형:휴강) 
                profClassMapper.updateClassoffAttenddethist(map);
                ////////////////////////////////////////
            	
        		map.put("classday", currClassday);
        		map.put("reserve_seq", "");
        		
            	profClassMapper.insertClassoffRequest(map);
            }
            //////////////////////////////////////////
           
          } catch (ParseException e) {
            e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			logger.error("CLASSOFF ERROR - \r\n prof_no : " + map.get("prof_no"));
			msg = "오류가 발생했습니다.";            
          }

        } else {
          msg = "already exist";
        }
    }
    return msg;
  }

  @Transactional
  @Override
  public String classOffCancel(Map<String, Object> map) {
	String msg = "";

	try {
		// 휴,보강 취소 처리
		profClassMapper.updateClassoffRequestAttendmaster(map);

		// 신청정보의 상태 변경
		map.put("proc_status", "G030C001");
		
		profClassMapper.deleteClassoffRequest(map);
		
		msg = "정상처리되었습니다.";
	} catch(Exception e) {
		e.printStackTrace();
		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		msg = "오류가 발생했습니다.";
	}
	
	return msg;
  }	
  
  @Transactional
  @Override
  public void updateProfAttendAuthoiry(ArrayList<Attenddethist> attendUpdateList) {
	Map<String, Object> map = new HashMap<String, Object>();
    
    map.put("class_cd", attendUpdateList.get(0).getClass_cd());
    map.put("classday", attendUpdateList.get(0).getClassday().toString());
    map.put("classhour_start_time", attendUpdateList.get(0).getClasshour_start_time());
    
    //System.out.println("[updateProfAttendAuthoiry Start]");
    
    ArrayList<Attenddethist> attenddethist = (ArrayList<Attenddethist>) profClassMapper.getBatchAttendDetailList(map);

    //System.out.println("attendUpdateList:["+attendUpdateList.size()+"]");
    //System.out.println("attenddethist:["+attenddethist.size()+"]");
    
    try{
	    for (Attenddethist attenddethist2 : attenddethist) {
			for(Attenddethist attendStudent : attendUpdateList){
				
				// 직권처리 사용자 IP 조회 (2015.08.27)
				String ip = CommonUtil.getIpAddr();
				
				if(attenddethist2.getStudent_no().equals(attendStudent.getStudent_no())){
					// 2015.01.05 ///////////////////////
					// - TB_ATTENDDETHIST에 데이터를 입력하게 될 경우 더 많은 정보를 가지고 있는 attenddethist2로 변경
					//profClassMapper.updateProfAttendAuthorityAttenddethist(attendStudent);
					/////////////////////////////////////					
					attenddethist2.setAttend_sts_cd(attendStudent.getAttend_sts_cd());
					attenddethist2.setAttend_auth_cd(attendStudent.getAttend_auth_cd());
					attenddethist2.setAttend_auth_reason_cd(attendStudent.getAttend_auth_reason_cd());
					
					attenddethist2.setIpaddr(ip);
					
					if (profClassMapper.updateProfAttendAuthorityAttenddethist(attenddethist2) == 0) {
						profClassMapper.insertProfAttendAuthorityAttenddethist(attenddethist2);
					}
					/////////////////////////////////////
				}else{
				}
			}
		}
	    
	    // 2015.01.05 ///////////////////////
	    // - 출결상태별 수강생 수는 별도로 조회하도록 변경
	    /////////////////////////////////////
	    Attendmaster attendmaster = profClassMapper.getProfClassAttendCnt(attenddethist.get(0));
	    
	    attendmaster.setUniv_cd(attendUpdateList.get(0).getUniv_cd());
	    attendmaster.setTerm_cd(attendUpdateList.get(0).getTerm_cd());
	    attendmaster.setClass_cd(attendUpdateList.get(0).getClass_cd());
	    attendmaster.setClassday(attendUpdateList.get(0).getClassday());
	    attendmaster.setClasshour_start_time(attendUpdateList.get(0).getClasshour_start_time());
	    attendmaster.setProf_no(attendUpdateList.get(0).getProf_no());
	    /////////////////////////////////////

	    //System.out.println("[attendmaster] present:["+attendmaster.getAttend_present_cnt()+"],late:["+attendmaster.getAttend_late_cnt()+"],absent:["+attendmaster.getAttend_absent_cnt()+"]");

	    /////////////////////////////////////
	    // 직권처리 시 인증방식을 교수호명 방식으로 변경 처리 (2015.04.09)
	    // - 강의완료 시 결강 여부를 판단하기 위함 (CERT_TYPE이 없는 경우 결강 처리)
	    attendmaster.setCert_type("PROF_AUTH");
	    /////////////////////////////////////
	    
	    String[] array = attendmaster.getClass_cd().split("\\|");
	    attendmaster.setSubject_cd(array[3]);
	    attendmaster.setSubject_div_cd(array[4]);
	    
	    profClassMapper.updateProfAttendAuthorityAttendmaster(attendmaster);
	    logger.info("ATTEND -- prof_no : "+ attendmaster.getProf_no() + ", class_cd : " + attendmaster.getClass_cd() + " , classday : " + attendmaster.getClassday());

	    System.out.println("[updateProfAttendAuthoiry End]");
	    
    }catch(Exception e){
    	e.printStackTrace();
    	TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
    }
    
  }

  @Override
  public Map<String, Object> getClassAttendDetailList(Map<String, Object> map) {
    ArrayList<Attenddethist> attendDetailList = (ArrayList<Attenddethist>) commonMapper.getAttendDetailList(map);
    ArrayList<Attenddethist> attendAuthorityDetailList = new ArrayList<Attenddethist>();
    for (Attenddethist attenddethist : attendDetailList) {
      if(attenddethist.getAttend_auth_cd().equals("G022C002")){
        attendAuthorityDetailList.add(attenddethist);
      }
    }
    map.put("attendDetailList", attendDetailList);
    map.put("attendAuthorityDetailList", attendAuthorityDetailList);
    
    return map;
  }

  @Transactional
  @Override
  public String addClass(Map<String, Object> map) {
    String msg = "";
    map.put("alter_classhour_start_time", map.get("classhour_start_time"));
    
      if(profClassMapper.checkAlterClass(map) == 0){
        Classday classday = commonMapper.getClassday(map);
        map.put("classday_no", classday.getClassday_no());
        map.put("classday_name", classday.getClassday_name());
        
        // 2015.01.06 //////////////////////
        // - 인증번호는 발행 시 생성되도록 변경함으로 주석 처리
        /*
        String class_cert_no="";
        while(class_cert_no.length()<6){
          class_cert_no+=(int)(Math.random()*10);
        }
        map.put("class_cert_no", class_cert_no);
        */
        ////////////////////////////////////
        
        if(!CompareTime.compareCurrentTime(commonMapper.getCurrentTime(), map.get("classday").toString(), map.get("classhour_start_time").toString())){
        	//profClassMapper.insertClassAddAttendmaster(map);
        	// 2015.01.06 /////////////////////////
        	// - AttendHist 정보는 미리 등록하지 않기 때문에 주석 처리
	        //profClassMapper.insertClassAddAttenddethist(map);
        	// - 보강 정보를 TB_ATTENDMASTER_ADDINFO에도 같이 등록 처리
        	profClassMapper.insertClassAddAttendmasterAddInfo(map);
        	///////////////////////////////////////
        }else{
        	//profClassMapper.insertClassAddEarlyAttendmaster(map);
        	// 2015.01.06 /////////////////////////
        	// - AttendHist 정보는 미리 등록하지 않기 때문에 주석 처리
	        //profClassMapper.insertClassAddEarlyAttenddethist(map);
        	// - 보강 정보를 TB_ATTENDMASTER_ADDINFO에도 같이 등록 처리
        	profClassMapper.insertClassAddEarlyAttendmasterAddInfo(map);
        	///////////////////////////////////////
        }
        msg = "success";
        logger.info("ADDCLASS -- classday : " + map.get("classday") +"class_cd : "+ map.get("class_cd"));
      }else{
        msg = "already exist";
      }
    return msg;
  }  
  
  @Override
  public Attendmaster checkClass(Map<String, Object> map){
    return profClassMapper.checkClass(map);
    
  }

  @Override
  public Collection<Attendmaster> getCopyAttendList(Map<String, Object> map) {
    return profClassMapper.getCopyAttendList(map);
  }

  @Transactional
  @Override
  public String copyClass(Map<String, Object> map) {
    
	String msg = "";
    String[] classList = (String[]) map.get("classList");
    
    ArrayList<Attenddethist> attenddethist = (ArrayList<Attenddethist>) commonMapper.getAttendDetailList(map);  //복사하려는 강의의 수강생
    
    for(int i = 0; i < attenddethist.size(); i++){
      if(attenddethist.get(i).getAttend_sts_cd().contains("G023C005")){
    	  attenddethist.remove(i);    //휴학생 제거
    	  i--;
      }else if(attenddethist.get(i).getAttend_sts_cd().contains("G023C007")){
    	  attenddethist.remove(i);    //제적생 제거
    	  i--;
      }else if(attenddethist.get(i).getReg_etc() != null){
    	  
    	  if(attenddethist.get(i).getReg_etc().contains("GONGGYUL")){
	          attenddethist.remove(i);    //공결 제거
	          i--;
    	  }
      }
    }
    
    Attendmaster am = commonMapper.getAttendmaster(map);    //복사하려는 강의의 attendmaster정보(출결상태 복사 휴학, 퇴학은 복사하지 않음)
    ArrayList<Attendmaster> copyAttendmaster = new ArrayList<Attendmaster>();
    
	// Log Proc ///////////////
    commonService.insertLogInfo("APP", am.getClass_cd(), am.getClassday().toString(), "", "", "[copyClass]Source Class");
	///////////////////////////
    
    for(int i = 0; i<classList.length; i++){
      Attendmaster attendmaster = new Attendmaster();
      String copy_class_cd = classList[i].split("\\|\\|")[0];
      String copy_classday_tmp = classList[i].split("\\|\\|")[1];
      java.sql.Date copy_classday = java.sql.Date.valueOf(copy_classday_tmp);
      String copy_classhour_start_time = classList[i].split("\\|\\|")[2];
      String copy_univ_cd = copy_class_cd.split("\\|")[0]; 
      
      String copy_year = copy_class_cd.split("\\|")[1];
      String copy_term_cd = copy_class_cd.split("\\|")[2];
      
      attendmaster.setUniv_cd(copy_univ_cd);
      attendmaster.setYear(copy_year);
      attendmaster.setTerm_cd(copy_term_cd);
      attendmaster.setClass_cd(copy_class_cd);
      attendmaster.setClassday(copy_classday);
      attendmaster.setClasshour_start_time(copy_classhour_start_time);
      attendmaster.setAttend_proc_cnt(am.getAttend_proc_cnt());
      attendmaster.setAttend_present_cnt(am.getAttend_present_cnt());
      attendmaster.setAttend_late_cnt(am.getAttend_late_cnt());
      attendmaster.setAttend_absent_cnt(am.getAttend_absent_cnt());
      attendmaster.setAttend_auth_cnt(attenddethist.size());    //attenddethist 에서 걸러진 학생이 직권처리인원임
      attendmaster.setCert_type("PROF_AUTH");
      
      copyAttendmaster.add(i, attendmaster);
    }
    try{
    for (Attendmaster attendmaster : copyAttendmaster) {
      profClassMapper.copyAttendmaster(attendmaster);
      
      // 기존의 등록되어 있는 TB_ATTENDDETHIST의 정보 삭제 //
      am.setClass_cd(attendmaster.getClass_cd());
      am.setClassday(attendmaster.getClassday());
      am.setClasshour_start_time(attendmaster.getClasshour_start_time());
      
      profClassMapper.deleteExistsAttenddethist(am);
      ///////////////////////////////////////////////////////
      
      for(Attenddethist attenddethist2 : attenddethist){
        attenddethist2.setClass_cd(attendmaster.getClass_cd());
        attenddethist2.setClassday(attendmaster.getClassday());
        attenddethist2.setClasshour_start_time(attendmaster.getClasshour_start_time());
        // 2015.01.06 ////////////////////
        // - AttendHist 정보를 Update가 아닌 Insert 처리로 변경
        profClassMapper.copyAttenddethist(attenddethist2);
        //////////////////////////////////
      }
      
		// 연강 처리후 강의 출결 cnt 처리 20160615
		Attendmaster attendmasterAttendCnt = profClassMapper.getProfClassAttendCnt(attenddethist.get(0));
		
		if(attendmasterAttendCnt != null) {
			attendmaster.setAttend_present_cnt(attendmasterAttendCnt.getAttend_present_cnt());
			attendmaster.setAttend_late_cnt(attendmasterAttendCnt.getAttend_late_cnt());
			attendmaster.setAttend_absent_cnt(attendmasterAttendCnt.getAttend_absent_cnt());
			attendmaster.setAttend_off_cnt(attendmasterAttendCnt.getAttend_off_cnt());
			attendmaster.setAttend_quit_cnt(attendmasterAttendCnt.getAttend_quit_cnt());
		}
		/////////////////////////////////////
		// 팀티칭 여부 판단 20160615
		attendmaster.setIs_team(attenddethist.get(0).getIs_team());
		
		// 직권처리 시 인증방식을 교수호명 방식으로 변경 처리 (2015.04.09)
		// - 강의완료 시 결강 여부를 판단하기 위함 (CERT_TYPE이 없는 경우 결강 처리)
		attendmaster.setCert_type("PROF_AUTH");
		/////////////////////////////////////
		
		String[] array = attendmaster.getClass_cd().split("\\|");
		attendmaster.setSubject_cd(array[3]);
		attendmaster.setSubject_div_cd(array[4]);
		
		profClassMapper.updateProfAttendAuthorityAttendmaster(attendmaster);
		
		// Log Proc ///////////////
	    commonService.insertLogInfo("APP", attendmaster.getClass_cd(), attendmaster.getClassday().toString(), "", "", "[copyClass]Target Class");
		///////////////////////////		
    }
    
    msg = "정상처리되었습니다.";
    }catch(Exception e){
      msg = "오류가 발생했습니다.";
      e.printStackTrace();
      TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
      logger.error("COPYCLASS ERROR -- \r\n prof_no : " + map.get("prof_no"));
    }
    return msg;
  }

	@Override
	public ArrayList<AttendBatch> getBatchList(Map<String, Object> map) {
		
		ArrayList<AttendBatch> attendBatch = null;
		
		attendBatch = profClassMapper.getBatchClassdayList(map);

		for (int i = 0; i < attendBatch.size(); i++) {
			attendBatch.get(i).setAttenddethist(profClassMapper.getBatchAttendeeList(attendBatch.get(i)));
		}
		return attendBatch;
	}
	
	// 직권처리 사용자 IP 조회 (2015.08.27)
	public String getIpAddress () {
		
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();        
		
		String ip = req.getHeader("X-Forwarded-For");  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = req.getHeader("Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = req.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = req.getHeader("HTTP_CLIENT_IP");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = req.getHeader("HTTP_X_FORWARDED_FOR");  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = req.getRemoteAddr();  
	    } 
		
	    return ip;
	}
	
	/*
	 * 교수출석일괄처리페이지
	 */	
	@Transactional
	@Override
	public String profAttendBatch(Map<String, Object> map) {
		
		String msg = "";
		String ip = getIpAddress();
		
		String[] attendStatus = (String[]) map.get("attendStatus");
		String classday = attendStatus[0].split("\\|")[0];
		String classhour_start_time = attendStatus[0].split("\\|")[1];
		
		map.put("classday", classday);
		map.put("classhour_start_time", classhour_start_time);
		
		ArrayList<Attenddethist> attenddethist = (ArrayList<Attenddethist>) profClassMapper.getBatchAttendDetailList(map);
		
		try{
			for (Attenddethist attenddethist2 : attenddethist) {
				for(int i = 0; i < attendStatus.length; i++){
					if(attenddethist2.getStudent_no().equals(attendStatus[i].split("\\|")[2])){
						
						// 2015.01.05 ///////////////////////
						// - TB_ATTENDDETHIST에 데이터를 입력하게 될 경우 더 많은 정보를 가지고 있는 attenddethist2로 변경
						//profClassMapper.updateProfAttendAuthorityAttenddethist(attendStudent);
						/////////////////////////////////////					
						attenddethist2.setAttend_sts_cd(attendStatus[i].split("\\|")[3]);
						attenddethist2.setAttend_auth_reason_cd(attendStatus[i].split("\\|")[4]);
						attenddethist2.setAttend_auth_cd("G022C002");
						
						attenddethist2.setIpaddr(ip);
						
						if (profClassMapper.updateProfAttendAuthorityAttenddethist(attenddethist2) == 0) {
							profClassMapper.insertProfAttendAuthorityAttenddethist(attenddethist2);
						}
						
						/////////////////////////////////////
					}
				}
			}
			
		    /////////////////////////////////////
		    Attendmaster attendmaster = profClassMapper.getProfClassAttendCnt(attenddethist.get(0));
		    
			attendmaster.setUniv_cd(map.get("univ_cd").toString());
			attendmaster.setTerm_cd(map.get("term_cd").toString());
			attendmaster.setClass_cd(map.get("class_cd").toString());
			attendmaster.setClassday(attenddethist.get(0).getClassday());
			attendmaster.setClasshour_start_time(classhour_start_time);
			attendmaster.setProf_no(map.get("prof_no").toString());
		    /////////////////////////////////////
			  
		    /////////////////////////////////////
		    // 직권처리 시 인증방식을 교수호명 방식으로 변경 처리 (2015.04.09)
		    // - 강의완료 시 결강 여부를 판단하기 위함 (CERT_TYPE이 없는 경우 결강 처리)
		    attendmaster.setCert_type("PROF_AUTH");
		    /////////////////////////////////////
			
		    String[] array = attendmaster.getClass_cd().split("\\|");
		    attendmaster.setSubject_cd(array[3]);
		    attendmaster.setSubject_div_cd(array[4]);
		    
			profClassMapper.updateProfAttendAuthorityAttendmaster(attendmaster);			
			logger.info("BATCHATTEND -- prof : " + attendmaster.getProf_no() + ", class_cd : " + attendmaster.getClass_cd() + ", classday : " + attendmaster.getClassday());
			msg = "정상처리되었습니다.";
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			logger.error("BATCH ERROR -- \r\n prof_no : " + map.get("prof_no"));
			msg = "오류가 발생했습니다.";
		}
		
		
		return msg;
	}

	@Override
	public Attendmaster getCurrentRestoreClass(Map<String, Object> map) {
		return profClassMapper.getCurrentRestoreClass(map);
	}

	@Override
	public Attendmaster getBeforeRestoreClass(Map<String, Object> map) {
		return profClassMapper.getBeforeRestoreClass(map);
	}

	@Transactional
	@Override
	public String restoreClassRequest(Map<String, Object> map) {
		String msg = "";
		
		try {
			// 휴,보강 취소정보를 신청정보에 등록 처리 (취소처리는 승인된 신청정보에 대한 처리임)
			// - 기 등록여부 확인 (취소요청)
			//   : 기등록시 메세지 처리 후 종료
			// - 휴강 신청처리를 사용할 경우 취소신청 처리
			// - 휴강 신청처리를 사용하지 않응 경우 해당 강의 휴강 취소처리, 보강 삭제 처리, 취소신청 처리(승인)

			// 강의유형 조회
			String currClassType = map.get("current_class_type_cd").toString();
			
			// 강의유형이 보강인 경우 map의 데이터를 휴강 데이터 기준으로 변경
			// - 휴,보강 취소는 휴강정보와 보강정보 화면에서 요청할 수 있는데
			//   하나의 정보로 요청정보를 사용하기 위함임, 그렇지 않으면 취소 요청 정보가 각각 생성될 수 있음
			if(currClassType.equalsIgnoreCase("G019C003")) {
				Map<String, Object> tmpMap = new HashMap<String, Object>(); 
				
				tmpMap.put("before_classday",				map.get("before_classday").toString());
				tmpMap.put("before_classhour_start_time",	map.get("before_classhour_start_time").toString());
				tmpMap.put("before_class_type_cd",			map.get("before_class_type_cd").toString());
				tmpMap.put("before_class_cd",				map.get("before_class_cd").toString());

				tmpMap.put("current_classday",				map.get("current_classday").toString());
				tmpMap.put("current_classhour_start_time",	map.get("current_classhour_start_time").toString());
				tmpMap.put("current_class_type_cd",			map.get("current_class_type_cd").toString());
				tmpMap.put("class_cd",						map.get("class_cd").toString());
				
				map.put("before_classday",					tmpMap.get("current_classday").toString());				
				map.put("before_classhour_start_time",		tmpMap.get("current_classhour_start_time").toString());				
				map.put("before_class_type_cd",				tmpMap.get("current_class_type_cd").toString());
				map.put("before_class_cd",					tmpMap.get("class_cd").toString());

				map.put("current_classday",					tmpMap.get("before_classday").toString());				
				map.put("current_classhour_start_time",		tmpMap.get("before_classhour_start_time").toString());				
				map.put("current_class_type_cd",			tmpMap.get("before_class_type_cd").toString());
				map.put("class_cd",							tmpMap.get("before_class_cd").toString());
			}
			
			// 이전 휴강 신청정보 조회
			map.put("classday",						map.get("current_classday").toString());
			map.put("classhour_start_time",			map.get("current_classhour_start_time").toString());
			map.put("alter_classday",				map.get("before_classday").toString());
			map.put("alter_classhour_start_time",	map.get("before_classhour_start_time").toString());		
			map.put("proc_status",					"G030C002");		
			ClassOffRequest objPrevClassOffRequest = getClassOffRequestView(map);

			// 취소신청상태인 정보만 조회하도록 함
			map.put("proc_status", "G030C004");
			ClassOffRequest objClassOffRequest = getClassOffRequestView(map);
			
			// 이미 동일 강의가 휴강 취소신청되어 있는 경우
			if(objClassOffRequest != null) {
				msg = "already request";
			}
			// 취소신청되어 있지 않은 경우
			else {
				// 휴,보강 신청처리를 사용하지 않는다면
				if(globalMakeupLessonApproval != null && globalMakeupLessonApproval.equalsIgnoreCase("N")) {
					// 휴,보강 신청처리를 사용하지 않는 경우 취소신청 정보가 없기 때문에
					// 이전 자동승인 정보를 조회하여 필요한 정보를 참조해야 함
					if(objPrevClassOffRequest != null) {
						map.put("prof_no", 						objPrevClassOffRequest.getProf_no());
					    map.put("alterClassday",				objPrevClassOffRequest.getClassday());						
					    map.put("alter_classhour_start_time",	objPrevClassOffRequest.getClasshour_start_time());						
					    map.put("alter_classhour_end_time",		objPrevClassOffRequest.getClasshour_end_time());						
						
					    map.put("classhour_start_time",	objPrevClassOffRequest.getAdd_classhour_start_time());						
					    map.put("classhour_end_time",	objPrevClassOffRequest.getAdd_classhour_end_time());						
					    map.put("classroom_no",			objPrevClassOffRequest.getAdd_classroom_no());						
					    map.put("reserve_date",			objPrevClassOffRequest.getAdd_classday().toString());						
					}

					msg = restoreClassConfirm(objClassOffRequest, map);
					
					// 신청처리를 사용하지 않는 경우 신청상태는 승인으로 처리
					map.put("proc_status", "G030C005");
					map.put("proc_reason", "취소자동승인");
					map.put("alter_classoff_reason", "취소신청");
				} 
				// 휴,보강 신청처리를 사용한다면
				else {
					// class_prof_cd 값을 휴강취소신청(G018C004)으로 지정
					map.put("prog_cd", "G018C004");			
					profClassMapper.updateClassoffRequestAttendmaster(map);
					
					// 보강정보의 class_prof_cd 값도 휴강취소신청(G018C004)으로 지정
					profClassMapper.updateClassoffRequestAddAttendmaster(map);
					
					// 신청처리를 사용하는 경우 신청상태는 신청으로 처리
					map.put("proc_status", "G030C004");
					map.put("proc_reason", "");
					map.put("alter_classoff_reason", "취소신청");
					
					msg = "success request";
				}			

				// 휴강 취소신청정보 등록 처리
				if(objPrevClassOffRequest != null) {
					System.out.println("objPrevClassOffRequest != null");
					System.out.println("getAdd_classday:["+objPrevClassOffRequest.getAdd_classday()+"]");
					
					map.put("alterClassday", objPrevClassOffRequest.getAdd_classday());	
					map.put("alter_classhour_start_time", objPrevClassOffRequest.getAdd_classhour_start_time());	
					map.put("alter_classhour_end_time", objPrevClassOffRequest.getAdd_classhour_end_time());	
					map.put("alter_classroom_no", objPrevClassOffRequest.getAdd_classroom_no());	
					map.put("reserve_seq", "");
					map.put("classday", objPrevClassOffRequest.getClassday());
					map.put("classhour_start_time", objPrevClassOffRequest.getClasshour_start_time());
				}

				map.put("reserve_seq", "");
				
				if(msg != null && (msg.equalsIgnoreCase("success") || msg.equalsIgnoreCase("success request"))) {
					profClassMapper.insertClassoffRequest(map);
				}				
			}			
		} catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			msg = "오류가 발생했습니다.";
		}		

		return msg;
	}
		
	@Transactional
	@Override
	public String restoreClassConfirm(ClassOffRequest objClassOffRequest, Map<String, Object> map) {
		String msg = "";

		try {
			// 휴,보강 신청처리를 사용하지 않는다면 objClassOffRequest은 Null임
			if(objClassOffRequest != null) {
				map.put("univ_cd",						objClassOffRequest.getUniv_cd());
				map.put("year",							objClassOffRequest.getYear());
			    map.put("term_cd",						objClassOffRequest.getTerm_cd());
			    map.put("prof_no",						objClassOffRequest.getProf_no());
			    map.put("class_cd",						objClassOffRequest.getClass_cd());
			    map.put("class_name",					objClassOffRequest.getClass_name());
			    map.put("current_classday",				objClassOffRequest.getClassday().toString());
			    map.put("current_classhour_start_time",	objClassOffRequest.getClasshour_start_time());
			    map.put("current_classhour_end_time",	objClassOffRequest.getClasshour_end_time());
			    map.put("current_class_type_cd",		"G019C002");

			    // 휴강된 강의일/시간에 다른 보강정보가 있는 지 확인을 위해 사용되는 변수 //
			    map.put("alterClassday",				objClassOffRequest.getClassday().toString());

			    map.put("alter_classhour_start_time",	objClassOffRequest.getClasshour_start_time());
			    map.put("alter_classhour_end_time",		objClassOffRequest.getClasshour_end_time());
			    //////////////////////////////////////////////
			    
		        map.put("before_classday",				objClassOffRequest.getAdd_classday().toString());
		        map.put("before_classhour_start_time",	objClassOffRequest.getAdd_classhour_start_time());
		        map.put("before_class_type_cd",			"G019C003");
		        map.put("before_class_cd",				objClassOffRequest.getClass_cd());
		        
			    map.put("classday",						objClassOffRequest.getAdd_classday().toString());
			    map.put("classhour_start_time",			objClassOffRequest.getAdd_classhour_start_time());
			    map.put("classhour_end_time",			objClassOffRequest.getAdd_classhour_end_time());
			    map.put("classroom_no",					objClassOffRequest.getAdd_classroom_no());
			    
			    map.put("reserve_date",					objClassOffRequest.getAdd_classday().toString());									    
			}

			String current_classtype = map.get("current_class_type_cd").toString();

			// 휴강된 강의일/시간에 다른 보강정보가 있는 지 확인 (2016.09.26)
			// - 해당 시간에 보강정보가 있으면 휴강 취소를 할 수 없음 
			if(profClassMapper.checkAlterClass(map) == 0){
				// 현재 강의정보 처리 ////////////////////////////
				// 휴강정보일 경우
				if(current_classtype.equals("G019C002")){
					// 강의유형을 휴강에서 정상으로 변경
					profClassMapper.updateCurrentClassMasterAddInfo(map);
					// 출결이력정보의 강의유형을 휴강에서 정상으로 변경
					profClassMapper.updateCurrentClassDetail(map);				
				}
				// 보강정보일 경우
				else if(current_classtype.equals("G019C003")) {
					// 보강정보 삭제
					profClassMapper.deleteCurrentClassMasterAddInfo(map);
					// 출결이력정보 삭제
					profClassMapper.deleteCurrentClassDetail(map);
				}
				/////////////////////////////////////////
				
				// 이전 강의정보 처리 ////////////////////////////
				if(map.get("before_class_type_cd") != null){
					String before_classtype = map.get("before_class_type_cd").toString();
					
					// 휴강정보일 경우
					if(before_classtype.equals("G019C002")){
						// 강의유형을 휴강에서 정상으로 변경
						profClassMapper.updateBeforeClassMasterAddInfo(map);
						// 출결이력정보의 강의유형을 휴강에서 정상으로 변경
						profClassMapper.updateBeforeClassDetail(map);
					} 
					// 보강정보일 경우
					else if(before_classtype.equals("G019C003")) {
						// 보강정보 삭제
						profClassMapper.deleteBeforeClassMasterAddInfo(map);
						// 출결이력정보 삭제				
						profClassMapper.deleteBeforeClassDetail(map);	
					}
					
				}
				/////////////////////////////////////////	
				
				// SMS 전송  ///////////////////////////////
				// 휴강정보일 경우
				if(current_classtype.equals("G019C002")){
					map.put("sms_type", "CLASSOFFCANCEL");
				}
				// 보강정보일 경우
				else if(current_classtype.equals("G019C003")) {
					map.put("sms_type", "CLASSADDCANCEL");
				}			

				commonService.sendSMS(map);
				/////////////////////////////////////////	
				
				// 강의실 예약정보 처리 ///////////////////////////
				// - 보강정보는 강의실 사용 뷰에서 처리되기 때문에 별도의 처리가 필요 없음 
				//profClassMapper.deleteClasshourReserve(map);
				/////////////////////////////////////////	
				
				msg = "success";				
			}
			else {
				msg = "already exist";
			}						

		} catch(Exception e) {
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			msg = "오류가 발생했습니다.";
		}
		
		return msg;
	}
	
	@Transactional
	@Override
	public String restoreClass(Map<String, Object> map) {
		String msg = "";
		
		String current_classtype = map.get("current_class_type_cd").toString();
		
		try{
			if(current_classtype.equals("G019C002")){				// 휴강
				//profClassMapper.updateCurrentClassMaster(map);
				// 2015.01.06 /////////////////////
				// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 강의상태도 같이 변경 처리
				profClassMapper.updateCurrentClassMasterAddInfo(map);
				///////////////////////////////////
				profClassMapper.updateCurrentClassDetail(map);
				
				// 휴강요청 정보에 있는 시설물 예약 정보 조회 (2015.09.09)
				// - getClassOffRequestView의 classday를 맞추기 위해 current_classday 정보 사용
				map.put("classday", map.get("current_classday").toString());			

				ClassOffRequest objClassOffRequest = getClassOffRequestView(map);
				if(objClassOffRequest != null) {
					map.put("reserve_seq", objClassOffRequest.getReserve_seq());		
					
					// 휴강정보 처리시 등록된 휴강요청 정보 삭제 처리 (2015.08.24)
					profClassMapper.deleteCurrentClassoffRequest(map);
					
					System.out.println("[restoreClass] 휴강에서 취소한 경우..");				
				}
			}else if(current_classtype.equals("G019C003")){		// 보강
				//profClassMapper.deleteCurrentClassMaster(map);
				// 2015.01.06 /////////////////////
				// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 보강정보 삭제
				profClassMapper.deleteCurrentClassMasterAddInfo(map);
				///////////////////////////////////
				profClassMapper.deleteCurrentClassDetail(map);

				// 휴강요청 정보에 있는 시설물 예약 정보 조회 (2015.09.09)
				// - getClassOffRequestView의 class_cd, classday를 맞추기 위해 before_class_cd, before_classday 정보 사용
				map.put("class_cd", map.get("before_class_cd").toString());			
				map.put("classday", map.get("before_classday").toString());			
				
				ClassOffRequest objClassOffRequest = getClassOffRequestView(map);
				map.put("reserve_seq", objClassOffRequest.getReserve_seq());		
				
				// 보강에 대한 휴강정보의 요청정보 삭제 처리 (2015.08.24)
				profClassMapper.deleteBeforeClassoffRequest(map);
				
				System.out.println("[restoreClass] 보강에서 취소한 경우..");
				// 시설물 예약 취소 처리 (2015.09.08)
				//hsuReservationProc(map);
			}
			
			if(map.get("before_class_type_cd") != null){
				String before_classtype = map.get("before_class_type_cd").toString();
				if(before_classtype.equals("G019C002")){			// 휴강
					//profClassMapper.updateBeforeClassMaster(map);
					// 2015.01.06 /////////////////////
					// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 강의상태도 같이 변경 처리
					profClassMapper.updateBeforeClassMasterAddInfo(map);
					///////////////////////////////////
					profClassMapper.updateBeforeClassDetail(map);

					System.out.println("[restoreClass] 이전 강의 수정 처리..");
				
				}else if(before_classtype.equals("G019C003")){		// 보강
					//profClassMapper.deleteBeforeClassMaster(map);
					// 2015.01.06 /////////////////////
					// - 휴강취소 시 TB_ATTENDMASTER_ADDINFO의 보강정보 삭제
					profClassMapper.deleteBeforeClassMasterAddInfo(map);
					///////////////////////////////////					
					profClassMapper.deleteBeforeClassDetail(map);	

					// 시설물 예약 취소 처리 (2015.09.08)
					//hsuReservationProc(map);
				}
				
			}
			
			logger.info("RestoreClass - prof : " + map.get("prof_no").toString() + ", class_cd : " + map.get("class_cd"));
			msg = "정상처리되었습니다.";
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			logger.error("RESTORE ERROR -- \r\n prof_no : " + map.get("prof_no"));
			msg = "오류가 발생했습니다.";
		}
		
		return msg;
	}
	
	public void hsuReservationProc(Map<String, Object> map) {
		String current_classtype = map.get("current_class_type_cd").toString();
		Map<String, String> objReserveStatusMap = new HashMap<String, String>();
		
		if(current_classtype.equals("G019C002")){
			// 휴강일 경우 시설뭉 예약정보 처리시 휴강 정보로 지정
			map.put("classday", map.get("current_classday").toString());			

			objReserveStatusMap.put("CLASSDAY", map.get("before_classday").toString());	
			objReserveStatusMap.put("START_TIME", map.get("before_classhour_start_time").toString());	
		} else {									// 보강
			// 보강일 경우 시설뭉 예약정보 처리시 휴강 정보로 지정
			map.put("class_cd", map.get("before_class_cd").toString());			
			map.put("classday", map.get("before_classday").toString());			

			objReserveStatusMap.put("CLASSDAY", map.get("current_classday").toString());	
			objReserveStatusMap.put("START_TIME", map.get("current_classhour_start_time").toString());	
		}

		map.put("alter_classhour_start_time", map.get("current_classhour_start_time").toString());		
		
		Map<String, String> objAttendmasterMap = profClassMapper.hsu_getattendmaster(map);
		
		// RESERVATION 정보 삭제
		if(map.get("reserve_seq") != null && map.get("reserve_seq").toString().length() > 0) {
			profClassMapper.hsu_deletereservation(map);
		}
		
		// RESERVATION_STATUS 정보 초기화
    	String reserveClassday = objReserveStatusMap.get("CLASSDAY").toString();
    	objReserveStatusMap.put("CLASSDAY", reserveClassday.replace("-", ""));
		
		objReserveStatusMap.put("ROOM_NO", objAttendmasterMap.get("ROOM_NO").toString());	
		objReserveStatusMap.put("MAXSEQ", "");	
		objReserveStatusMap.put("PORTAL_ID", "");	
		objReserveStatusMap.put("PROF_NAME", "");	
		objReserveStatusMap.put("SUUP_FLAG", "");	
		
		profClassMapper.hsu_updatereservation_status(objReserveStatusMap);
	}

	@Override
	public void updateClassCertType(Map<String, Object> map) {
		try{
			profClassMapper.updateClassCertType(map);
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
	}
	
	@Override
	public Collection<AttendAppInfo> getAttendAppErrorList(Map<String, Object> map) {
		return profClassMapper.getAttendAppErrorList(map);
	}	

	@Override
	public AttendAppInfo getAttendAppStatusCnt(Map<String, Object> map) {
		return profClassMapper.getAttendAppStatusCnt(map);
	}	
	
	@Override
	public List<Classhour> getClasshour(Map<String, Object> map) {
		List<Classhour> list = profClassMapper.getClassHour(map);
		return list;
	}
	
	@Override
	public List<Classhour> getClasshour2(Map<String, Object> map) {
		List<Classhour> list = profClassMapper.getClassHour2(map);
		return list;
	}

	public String checkClassHour(String attendClasshour, Map husClasshour) {
		String isExist = "Y";
		
		// husClasshour에서의 Y는 교시 지정이 가능하다는 의미이고, isExist는 지정되지 않았음을 의미함
		// - 휴강처리 화면에서는 isExist값이 N인 정보만 사용하도록 되어 있음
		if(attendClasshour.equalsIgnoreCase("01")) {
			if(husClasshour.get("T01").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("02")) {
			if(husClasshour.get("T03").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("05")) {
			if(husClasshour.get("T07").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("06")) {
			if(husClasshour.get("T09").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("07")) {
			if(husClasshour.get("T11").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("08")) {
			if(husClasshour.get("T13").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("09")) {
			if(husClasshour.get("T15").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("10")) {
			if(husClasshour.get("T17").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("11")) {
			if(husClasshour.get("T19").equals("N")) {
				isExist = "N";
			}
		} else if(attendClasshour.equalsIgnoreCase("12")) {
			if(husClasshour.get("T21").equals("N")) {
				isExist = "N";
			}
		} else {
			isExist = "Y";
		}
		
		return isExist;
	}

	@Override
	public List<Attendmaster> hsu_getSmsInfo(Map<String, Object> map) {
		return profClassMapper.hsu_getSmsInfo(map);
	}
	
	@Override
	public PageBean<Attendmaster> getClassOffApproveList(Map<String, Object> map) {
		PageBean<Attendmaster> pageBean = new PageBean<Attendmaster>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type"); 

		int allCnt = profClassMapper.getClassOffApproveListCount(map);

		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL") || type.equals("EXCEL2")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		if(type.equals("EXCEL2")){
			pageBean.setList(profClassMapper.getClassOffApproveList2(map));
		} else {
			pageBean.setList(profClassMapper.getClassOffApproveList(map));
		}
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}
	
	/*
	 * 휴, 보강 신청목록 (2015.04.21)
	 */
	@Override
	public PageBean<ClassOffRequest> getClassOffRequestList(Map<String, Object> map) {
		PageBean<ClassOffRequest> pageBean = new PageBean<ClassOffRequest>();		
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");

		int allCnt = profClassMapper.getClassOffLastRequestListCount(map);
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
		
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(profClassMapper.getClassOffLastRequestList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}
	
	/*
	 * 휴, 보강 신청 조회 (2015.04.22)
	 */
	@Override
	public ClassOffRequest getClassOffRequestView(Map<String, Object> map) {
		
		ClassOffRequest objClassOffRequest = profClassMapper.getClassOffRequestView(map);
		
		return objClassOffRequest;
	}  		

	@Override
	public List<Attendmaster> getAttendeeClassdayList(Map<String, Object> map) {
		return profClassMapper.getAttendeeClassdayList(map);
	}

	@Override
	public String getCampusTime(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return profClassMapper.getCampusTime(map);
	}	
	
}