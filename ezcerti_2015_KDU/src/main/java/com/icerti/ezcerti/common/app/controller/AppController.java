package com.icerti.ezcerti.common.app.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icerti.ezcerti.common.app.dao.AppMapper;
import com.icerti.ezcerti.common.app.service.AppService;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.AttendmasterApp;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.domain.UnivApp;
import com.icerti.ezcerti.student.service.StudentAttendService;

@Controller
public class AppController {

	@Autowired
	private AppService appService;

	@Autowired
	private CommonService commService;

	@Autowired
	private StudentAttendService studentAttendService = null;

	@Autowired
	private AppMapper appMapper = null;

	@Autowired
	private CommonMapper commonMapper = null;
	
	@Value("#{config['student_cert_limit']}") 
	int globalStudentCertLimit;
	
	@RequestMapping(value = "app/getUnivList")
	public @ResponseBody Map<String, Object> selectUnivList(){
			
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			
		    List<UnivApp> univList = appService.getUnivList(map);
		    
		    if(univList != null && univList.size() > 0) {
			    jsonMap.put("retValue", "SUCCESS");
			    jsonMap.put("univ_cnt", String.valueOf(univList.size()));
			    jsonMap.put("univ_list", univList);
		    } else {
			    jsonMap.put("retValue", "FAIL");
		    }			
			
		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}

		return jsonMap;
	}

	@RequestMapping(value = "app/checkStudentNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> selectStudentNo(
								@RequestParam(value="univ_cd", defaultValue="") String univ_cd,
								@RequestParam(value="student_no", defaultValue="") String student_no){
			
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
	    String retValue ="";
		int certCount = 0;
		
		try {

			map.put("univ_cd", univ_cd);
			map.put("student_no", student_no);
			
			// Log Proc ///////////////
			commService.insertLogInfo("APP", "", "", "", student_no, "[checkStudentNo][student_no:"+student_no+"]");
			///////////////////////////
			
			if(student_no != null && student_no.length() > 0) {
				// ???????????? ??????
				appMapper.insertStudentCert(map);
				
				// ???????????? ??????
				certCount = appMapper.checkStudentCertCount(map);
				
				// ??????????????? ????????? ??? ???????????? ???????????? ???????????? FAIL ??????
				if(globalStudentCertLimit > 0 && certCount > globalStudentCertLimit) {
					jsonMap.put("retValue", "OVER");
				} else {
				    retValue = appService.checkStudentNo(map);
				    
				    if(retValue != null && retValue.length() > 0) {
					    jsonMap.put("retValue", retValue);
				    } else {
					    jsonMap.put("retValue", "FAIL");
				    }			
				}				
			} else {
				jsonMap.put("retValue", "FAIL");
			}
			
			// Log Proc ///////////////
			commService.insertLogInfo("APP", "", "", "", student_no, "[checkStudentNo][student_no:"+student_no+"][certCount:"+certCount+"][retValue:"+jsonMap.get("retValue").toString()+"]");
			///////////////////////////

		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}

		return jsonMap;
	}

	@RequestMapping(value = "app/getCurrentClass", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> selectCurrentClass(
								@RequestParam(value="univ_cd", defaultValue="") String univ_cd,
								@RequestParam(value="classday", defaultValue="") String classday,
								@RequestParam(value="student_no", defaultValue="") String student_no){
			
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {

			// ???????????? ?????? ?????? ?????? ////
			Univ univ = new Univ();
		    
		    univ.setUniv_cd(univ_cd);
		    univ.setUniv_sts_cd("G004C001");	// ????????????
		    
		    univ = commonMapper.getCurrentTerm(univ);			
			///////////////////////////////
		    
		    // ?????? ?????? ?????? /////////////
		    Calendar cal = Calendar.getInstance ( );
		    SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		    String strCurrDate = formatter.format (cal.getTime());
		    //System.out.println ( strCurrDate );
		    
		    if(classday != null && classday.length() > 0) {
		    	strCurrDate = classday;
		    }
		    ///////////////////////////////
		    
		    if(univ != null) {
				map.put("univ_cd", univ_cd);
				map.put("year", univ.getYear());
				map.put("term_cd", univ.getTerm_cd());
				map.put("student_no", student_no);
				map.put("classday", strCurrDate);
				map.put("class_sts_cd", "G020C002");	// ????????? ??????
		    } else {
				map.put("univ_cd", univ_cd);
				map.put("year", cal.get(cal.YEAR));
				map.put("term_cd", ((cal.get(cal.MONTH)+1) > 8) ? "G002C012" : "G002C011");
				map.put("student_no", student_no);
				map.put("classday", strCurrDate);
				map.put("class_sts_cd", "G020C002");	// ????????? ??????
		    }
			
			// Log Proc ///////////////
		    commService.insertLogInfo("APP", "", map.get("classday").toString(), "", student_no, "[getCurrentClass][TERM_CD:"+map.get("term_cd").toString()+"]");
			///////////////////////////
		    
		    // ????????? ??????????????? ???????????? ???. - ????????? ????????? ...
			List<AttendmasterApp> attendMasterList = appService.getCurrentClass(map);
			AttendmasterApp attendMaster = null;
			if (attendMasterList != null && attendMasterList.size() > 0) {
				if (attendMasterList.size() == 1)
					attendMaster = attendMasterList.get(0);
				else {
					for (AttendmasterApp am : attendMasterList) {
						if (am.getCert_type() != null && 
								(am.getCert_type().equals("PROF_AUTH") || am.getCert_type().equals("CERT_NUM") || am.getCert_type().equals("BEACON_AUTH"))) {
							attendMaster = am; break;
						}
					}
					if (attendMaster == null) attendMaster = attendMasterList.get(0); 
				}
			}
		    			
		    if(attendMaster != null) {
				// Log Proc ///////////////
		    	commService.insertLogInfo("APP", attendMaster.getClass_cd(), attendMaster.getClassday().toString(), attendMaster.getProf_no(), student_no, "[getCurrentClass][attendMaster is not null]");
				///////////////////////////

				jsonMap.put("retValue", "SUCCESS");
			    jsonMap.put("objAttend", attendMaster);
			    
			    // ??? ???????????? ?????? ////
			    int intRetValue = 0;

		    	map.put("class_cd", attendMaster.getClass_cd());
		    	map.put("prof_no", attendMaster.getProf_no());

			    intRetValue = appService.selectAppExec(map);
			    
			    System.out.println("intRetValue:["+intRetValue+"]");
			    
			    if(intRetValue <= 0) {
				    appService.insertAppExec(map);
			    }
			    ////////////////////////
		    } else {
				// Log Proc ///////////////
		    	commService.insertLogInfo("APP", "", map.get("classday").toString(), "", student_no, "[getCurrentClass][attendMaster is null]");
				///////////////////////////
		    	
			    jsonMap.put("retValue", "FAIL");
		    }			
		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}

		return jsonMap;
	}

	@RequestMapping(value = "app/getClassCertNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> selectClassCertNo(
								@RequestParam(value="univ_cd", defaultValue="") String univ_cd,
								@RequestParam(value="student_no", defaultValue="") String student_no,
								@RequestParam(value="class_cd", defaultValue="") String class_cd,
								@RequestParam(value="classday", defaultValue="") String classday,
								@RequestParam(value="prof_no", defaultValue="") String prof_no,
								@RequestParam(value="bdname", defaultValue="") String bdname,
								@RequestParam(value="uuid", defaultValue="") String uuid){
			
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			
			int beaconCount = 0;
			String retValue = "";
			String result = "";
			String etc = "";

			map.put("univ_cd", univ_cd);
			map.put("class_cd", class_cd);
			map.put("classday", classday);
			map.put("prof_no", prof_no);
			map.put("student_no", student_no);

			// Log Proc ///////////////
			commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][UUID:"+bdname+"]");
			///////////////////////////
			
			// ???????????? ?????? 
			String classCertNo = appService.getClassCertNo(map);
			
			uuid = bdname; // uuid??? ?????? ?????? ???????????? ?????? bdname?????? ?????????. 
			               // uuid??? ????????? ????????? ??????????????? ??????????????? ????????? ????????? ?????????.
			               // BD_Name-1 | BD_Name-2 | BD_Name-3 ... ???????????? ?????????.
			
			if(uuid != null && uuid.length() > 0) {
				// ????????? ???????????? ??????
				List<String> lstBeacon = null; //appMapper.getEnableBeaconList(map);
				if(lstBeacon != null && lstBeacon.size() > 0) {

					// Log Proc ///////////////
					commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][UUID:"+uuid.length()+"][lstBeacon:["+lstBeacon.size()+"]]");
					///////////////////////////
					
					map.put("SenderFlag", "Y");
					if(uuid.equalsIgnoreCase("NS")) {
						map.put("BLEFlag", "N");
						map.put("ReceiverFlag", "N");					

						retValue = "FAIL";
						result = "INVALID";
					} else {
						map.put("BLEFlag", "Y");
						map.put("ReceiverFlag", "Y");					

						beaconCount = appService.getEnableBeaconCount(uuid, lstBeacon);
						
						// Log Proc ///////////////
						commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][BECONCNT]"+beaconCount);
						///////////////////////////
						
						if(beaconCount > 0) {
							retValue = "SUCCESS";
							/*if(appService.checkStudentAttend(map) > 0) {
						    	retValue = "FAIL";
						    	result = "?????? ??????????????? ???????????????.";
						    } else {
								Univ univ = new Univ();
							    univ.setUniv_cd(univ_cd);
							    univ.setUniv_sts_cd("G004C001");	
							    univ = commonMapper.getCurrentTerm(univ);			
							    class_cert_no = "beacon_cert_method";
							    
							    if(univ != null) {
								    map.put("univ_cd", univ_cd);
								    map.put("year", univ.getYear());
								    map.put("term_cd", univ.getTerm_cd());
								    map.put("student_no", student_no);
								    map.put("class_cd", class_cd);   
								    map.put("classday", classday);
								    map.put("classhour_start_time", class_cd.substring(class_cd.length()-5));
								    map.put("class_cert_no", class_cert_no);
								    map.put("prof_no", prof_no);
							    } else {
								    Calendar cal = Calendar.getInstance ( );
								    map.put("univ_cd", univ_cd);
									map.put("year", cal.get(cal.YEAR));
									map.put("term_cd", ((cal.get(cal.MONTH)+1) > 8) ? "G002C002" : "G002C001");
								    map.put("student_no", student_no);
								    map.put("class_cd", class_cd);   
								    map.put("classday", classday);
								    map.put("classhour_start_time", class_cd.substring(class_cd.length()-5));
								    map.put("class_cert_no", class_cert_no);
								    map.put("prof_no", prof_no);
							    }
							    
						    	result = studentAttendService.checkStudentCert(map);
							    
							    if(result.equals("incorrect_cert_no")){
							    	retValue = "FAIL";
							    	result = "??????????????? ???????????? ????????????.";
							    }else if(result.equals("incorrect_classday")){
							    	retValue = "FAIL";
							    	result = "??????????????? ????????????.";
							    }else if(result.equals("attend_present")){
							    	retValue = "SUCCESS";
							    	result = "?????? ?????????????????????.";
							    }else if(result.equals("attend_late")){
							    	retValue = "FAIL";
							    	result = "?????? ??????????????? ???????????????.";
							    }
						    }*/
						} else {	// ??????????????? ?????? ?????? ??????
							retValue = "FAIL";
							result = "INVALID";
						}
					}
				} else {	// ???????????? ????????? ???????????? ?????? ??????
					// Log Proc ///////////////
					commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][BEACON NOT INSTALLED]");
					///////////////////////////
					
					map.put("SenderFlag", "N");		
					if(uuid.equalsIgnoreCase("NS")) {
						map.put("BLEFlag", "N");
						map.put("ReceiverFlag", "N");
					} else {
						map.put("BLEFlag", "Y");
						map.put("ReceiverFlag", "Y");
					}
					
					retValue = "FAIL";
					result = "INVALID";
				}
			} else {	// ????????? UUID ?????? ?????? ??????
				// Log Proc ///////////////
				commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][UUID IS  NULL]");
				///////////////////////////
				
				map.put("SenderFlag", "N");	
				map.put("BLEFlag", "N");
				map.put("ReceiverFlag", "N");

				retValue = "SUCCESS";
			}

			etc = "[UUID]:[" + uuid + "],[BEACONCNT]:[" + beaconCount + "]";
			
			map.put("etc", etc);
			map.put("Result", retValue);
			/////////////////////////////////////////////////////////////
			
			jsonMap.put("retValue", retValue);
			jsonMap.put("class_cert_no", classCertNo);

			// Log Proc ///////////////
			commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[getClassCertNo][BLEFlag:"+map.get("BLEFlag").toString()+"][SenderFlag:"+map.get("SenderFlag").toString()+"][ReceiverFlag:"+map.get("ReceiverFlag").toString()+"][retValue:"+retValue+"][classCertNo:"+classCertNo+"]");
			///////////////////////////
			
			// ?????????????????? ??????
			if(appMapper.selectCertBeaconInfo(map) > 0) {
				appMapper.updateCertBeaconInfo(map);
			} else {
				appMapper.insertCertBeaconInfo(map);				
			}
			
			if(retValue.equalsIgnoreCase("FAIL")) {
			    jsonMap.put("result", result);
			}
			
		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}

		return jsonMap;
	}
	
	@RequestMapping(value = "app/classCertProc", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> classCertProc(
									@RequestParam(value = "univ_cd") String univ_cd, 
									@RequestParam(value = "student_no") String student_no, 
									@RequestParam(value = "class_cd") String class_cd, 
									@RequestParam(value = "classday") String classday,
									@RequestParam(value = "classhour_start_time") String classhour_start_time,
									@RequestParam(value = "prof_no") String prof_no,
									@RequestParam(value = "class_cert_no") String class_cert_no) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
	
		String msg = "";
		String retValue = "";
		String strCertType = "";
		int intStudentAttend = 0;
		
		try {

			// ???????????? ?????? ?????? ?????? ////
			Univ univ = new Univ();
		    
		    univ.setUniv_cd(univ_cd);
		    univ.setUniv_sts_cd("G004C001");	// ????????????
		    
		    univ = commonMapper.getCurrentTerm(univ);			
			///////////////////////////////
		    
		    if(univ != null) {
			    map.put("univ_cd", univ_cd);
			    map.put("year", univ.getYear());
			    map.put("term_cd", univ.getTerm_cd());
		    } else {
			    // ?????? ?????? ?????? /////////////
			    Calendar cal = Calendar.getInstance ( );
			    ///////////////////////////////
		    	
			    map.put("univ_cd", univ_cd);
				map.put("year", cal.get(cal.YEAR));
				map.put("term_cd", ((cal.get(cal.MONTH)+1) > 8) ? "G002C002" : "G002C001");
		    }

		    map.put("student_no", student_no);
		    map.put("class_cd", class_cd);   
		    map.put("classday", classday);
		    map.put("classhour_start_time", classhour_start_time);
		    map.put("prof_no", prof_no);
		    map.put("cert_sts_cd", "G031C004");
		    
		    // Attendmaster ?????? ?????? /////
		    // - ??????????????? ?????? class_cert_no ?????? ?????? 
		    Attendmaster objAttendmaster = appService.getAttendmaster(map);
		    
		    if(objAttendmaster != null) {
		    	strCertType = objAttendmaster.getCert_type();

		    	if(!strCertType.equals("CERT_NUM")) {
				    if (class_cert_no == null || class_cert_no.length() == 0) {
				    	class_cert_no = "beacon_cert_method";
				    } else {
				    	if (class_cert_no.equals("BEACON_AUTH") || class_cert_no.equals("null")) {
					    	class_cert_no = "beacon_cert_method";
				    	}
				    }		    	
		    	} else {
		    		if (class_cert_no == null || class_cert_no.trim().length() == 0) {
				    	class_cert_no = "000000";
		    		}
		    	}
		    }
		    ///////////////////////////
		    
		    map.put("class_cert_no", class_cert_no);

			// Log Proc ///////////////
		    commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[classCertProc][class_cert_no:"+class_cert_no+"][strCertType:"+strCertType+"]");
			///////////////////////////
		    
		    map.put("student_no", student_no);
		    map.put("class_cd", class_cd);   
		    map.put("classday", classday);
		    map.put("classhour_start_time", classhour_start_time);
		    map.put("class_cert_no", class_cert_no);
		    map.put("prof_no", prof_no);
		    
		    // ???????????? ?????? ?????? ////////////
		    intStudentAttend = appService.checkStudentAttend(map);
		    ///////////////////////////
		    
		    if(intStudentAttend > 0) {
		    	retValue = "FAIL";
		    	msg = "?????? ??????????????? ???????????????.";
		    } else {
		    	msg = studentAttendService.checkStudentCert(map);
		    	jsonMap.put("retValue", "FAIL");
			    
			    if(msg.equals("incorrect_cert_no")){
			    	retValue = "FAIL";
			    	msg = "??????????????? ???????????? ????????????.";
			    }else if(msg.equals("incorrect_classday")){
			    	retValue = "FAIL";
			    	msg = "??????????????? ????????????.";
			    }else if(msg.equals("attend_present")){
			    	retValue = "SUCCESS";
			    	msg = "?????? ?????????????????????.";
			    }else if(msg.equals("attend_late")){
			    	retValue = "SUCCESS";
			    	msg = "??????????????? ????????? ???????????? ???????????????.";
			    }
		    }
		    
	    	// Log Proc ///////////////
		    commService.insertLogInfo("APP", class_cd, classday, prof_no, student_no, "[classCertProc][checkStudentAttend:"+intStudentAttend+"][msg:"+msg+"][retValue:"+retValue+"]");
			///////////////////////////
		    
	    	jsonMap.put("retValue", retValue);
	    	jsonMap.put("result", msg);		    
	    	
		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}
    	
    	return jsonMap;
	}	
	
	@RequestMapping(value = "app/updateAppStatus", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> updateAppStatus(
								@RequestParam(value="univ_cd", defaultValue="") String univ_cd,
								@RequestParam(value="year", defaultValue="") String year,
								@RequestParam(value="term_cd", defaultValue="") String term_cd,
								@RequestParam(value="prof_no", defaultValue="") String prof_no,
								@RequestParam(value="class_cd", defaultValue="") String class_cd,
								@RequestParam(value="classday", defaultValue="") String classday,
								@RequestParam(value="student_no", defaultValue="") String student_no){
			
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {

			// ???????????? ?????? ?????? ?????? ////
			Univ univ = new Univ();
		    
		    univ.setUniv_cd(univ_cd);
		    univ.setUniv_sts_cd("G004C001");	// ????????????
		    
		    univ = commonMapper.getCurrentTerm(univ);			
			///////////////////////////////

		    if(univ != null) {
			    map.put("year", univ.getYear());
			    map.put("term_cd", univ.getTerm_cd());
		    } else {
			    // ?????? ?????? ?????? /////////////
			    Calendar cal = Calendar.getInstance ( );
			    ///////////////////////////////
		    	
				map.put("year", cal.get(cal.YEAR));
				map.put("term_cd", ((cal.get(cal.MONTH)+1) > 8) ? "G002C002" : "G002C001");
		    }			    
		    
			map.put("univ_cd", univ_cd);
			map.put("prof_no", prof_no);
			map.put("class_cd", class_cd);
			map.put("classday", classday);
			map.put("student_no", student_no);
			
		    int intRetValue = 0;
		    
		    intRetValue = appService.selectAppExec(map);
		    
		    System.out.println("intRetValue:["+intRetValue+"]");
		    
		    if(intRetValue > 0) {
				map.put("app_error", "Y");
		    	
			    appService.updateAppStatus(map);

			    jsonMap.put("retValue", "SUCCESS");
		    } else {
			    jsonMap.put("retValue", "FAIL");
		    }

		} catch(Exception e){
			jsonMap.put("retValue", "FAIL");
			e.printStackTrace();
		}

		return jsonMap;
	}	
	
}
