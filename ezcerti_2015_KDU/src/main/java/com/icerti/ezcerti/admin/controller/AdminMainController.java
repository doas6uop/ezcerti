package com.icerti.ezcerti.admin.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.service.AdminAttendService;
import com.icerti.ezcerti.admin.service.AdminMainService;
import com.icerti.ezcerti.admin.service.AdminProfService;
import com.icerti.ezcerti.admin.service.AdminStudentService;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.ClassOffRequest;
import com.icerti.ezcerti.domain.Gonggyul;
import com.icerti.ezcerti.prof.dao.ProfClassMapper;
import com.icerti.ezcerti.prof.service.ProfClassService;
import com.icerti.ezcerti.util.CommonUtil;

@Controller
public class AdminMainController {

	private static final Logger logger = LoggerFactory.getLogger(AdminMainController.class);
	
	@Autowired
	private AdminMainService adminMainService;

	@Autowired
	private AdminAttendService adminAttendService = null;

	@Autowired
	private AdminProfService adminProfService = null;
	
	@Autowired
	private ProfClassService profClassService = null;
	
	@Autowired
	private ProfClassMapper profClassMapper = null;
	
	@Autowired
	private AdminStudentService adminStudentService = null;

	@Autowired
	private CommonService commonService = null;
	
	@RequestMapping(value = "muniv/main")
	public String adminMain(Model model, HttpSession session){
	  
		Map<String, Object> map = new HashMap<String, Object>();
      
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());		
		
		// 현재날짜 생성
		Calendar oCalendar = Calendar.getInstance();
		
		// 현재 날짜/시간 등의 각종 정보 얻기
		String currentDate = "";
		currentDate = String.valueOf(oCalendar.get(Calendar.YEAR)) + "-";
		currentDate += (oCalendar.get(Calendar.MONTH) + 1) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.MONTH) + 1) : '0' + String.valueOf(oCalendar.get(Calendar.MONTH) + 1);
		currentDate += "-" + ((oCalendar.get(Calendar.DAY_OF_MONTH)) > 9 ? "" + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)) : '0' + String.valueOf(oCalendar.get(Calendar.DAY_OF_MONTH)));
		
		model.addAttribute("currentDate",	currentDate);
		
		// 현황건수 조회 ////////////////
		String stateCnt = adminMainService.getMainCountList(map);
		String[] arrStateCnt = null;
		
		if(stateCnt != null && stateCnt.length() > 0) {
			arrStateCnt = stateCnt.split(":");
			
			model.addAttribute("offClassCnt",		arrStateCnt[0]);
			model.addAttribute("cancelClassCnt",	arrStateCnt[1]);
			model.addAttribute("absentClassCnt",	arrStateCnt[2]);
			model.addAttribute("allClassCnt",	arrStateCnt[3]);
			model.addAttribute("todayClassCnt",	arrStateCnt[4]);
			model.addAttribute("todayClassAbCnt",	arrStateCnt[5]);
			model.addAttribute("todayAttendAbCnt",	arrStateCnt[6]);
		} else {
			model.addAttribute("offClassCnt",		"0");
			model.addAttribute("cancelClassCnt",	"0");
			model.addAttribute("absentClassCnt",	"0");
		}
		/////////////////////////////////
		
		// 결강수 Top3 교수
		model.addAttribute("prof_top3", adminMainService.getMainTop3List1(map));
		
		// 결강수 Top3 과목명
		model.addAttribute("class_top3", adminMainService.getMainTop3List2(map));
		////////////////////////////
		
		// 문의사항 조회 ////////////////
		String board_type = "QNA";
		int currentPage = 1;
		
		map.put("board_type", board_type);
		map.put("currentPage", currentPage);

		model.addAttribute("board_type", board_type);
		//model.addAttribute("board", adminMainService.getMainBoardList(map));		
		/////////////////////////////////
	  
		return "admin/main/main";
	}
	
	@RequestMapping(value = "muniv/main/search")
	public String adminMainSearch(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									@RequestParam(value="searchType", defaultValue="") String searchType, 
                                    @RequestParam(value="item", defaultValue="") String item, 
                                    @RequestParam(value="value", defaultValue="") String searchValue,
                                    @RequestParam(value="sortField", defaultValue="") String sortField, 
                                    @RequestParam(value="sortOrder", defaultValue="") String sortOrder,
                                    @RequestParam(value="type", defaultValue="") String type,
                                    Model model, HttpSession session){
	  
		Map<String, Object> map = new HashMap<String, Object>();
		boolean bSearch = true;
      
		if(currentPage == null) {
			currentPage = 1;
		}
		
		if(searchType == null || searchType.equals("")) {
			bSearch = false;
			searchType = "PROF";
		}

		if(item == null || item.equals("")) {
			item = "name";
		}
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD").toString());		
		
		map.put("currentPage", currentPage);
		map.put("item", item);
		map.put("searchValue", searchValue);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);

		model.addAttribute("bSearch", bSearch);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("item", item);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/main/search_list_excel";
		} else {
			retValue = "admin/main/search_list";
		}
		
		if(bSearch) {
			if(searchType.equals("PROF")) {
				model.addAttribute(adminProfService.getProfList(map));
			} else if(searchType.equals("STUDENT")) {
				model.addAttribute(adminStudentService.getStudentList(map));				
			} else if(searchType.equals("CLASS")) {
				model.addAttribute(adminAttendService.getAdminAttendList(map));				
			}
		}
		
		return retValue;
	}

	@RequestMapping(value = "muniv/main/classoff_list")
	public String adminClassOffList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								@RequestParam(value = "curr_year", defaultValue = "") String year,
								@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
                                String searchItem,
                                @RequestParam(value="searchValue", defaultValue="") String searchValue, 
                                @RequestParam(value="procStatus", defaultValue="") String procStatus,
                                @RequestParam(value="sortField", defaultValue="") String sortField, 
                                @RequestParam(value="sortOrder", defaultValue="") String sortOrder, 
                                @RequestParam(value="type", defaultValue="") String type, 
                                @RequestParam(value="sdate", defaultValue="") String startDate, 
                                @RequestParam(value="edate", defaultValue="") String endDate,
                                @RequestParam(value="add_sdate", defaultValue="") String addStartDate, 
                                @RequestParam(value="add_edate", defaultValue="") String addEndDate,
                                Model model, HttpSession session){
	  
		Map<String, Object> map = new HashMap<String, Object>();

		String retValue = "";
		String userType = session.getAttribute("USER_TYPE").toString();

		if(userType != null && userType.equals("[ROLE_PROF]")) {
			map.put("prof_no", session.getAttribute("PROF_NO").toString());
		}    

		if (currentPage == null) {
			currentPage = 1;
		}
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		
		if (year.equals("")) {
			year = session.getAttribute("YEAR").toString();
	    }
	    
	    if (term_cd.equals("")) {
	    	term_cd = session.getAttribute("TERM_CD").toString();
	    }
	    
	    map.put("year", year);
		map.put("term_cd", term_cd);
		map.put("currentPage", currentPage);

		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("procStatus", procStatus);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("addStartDate", addStartDate);
		map.put("addEndDate", addEndDate);
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "prof/class/classoff_req_list_excel";
		} else {
			retValue = "prof/class/classoff_req_list";
		}
		
		model.addAttribute("year", year);
	    model.addAttribute("term_cd", term_cd);
	    model.addAttribute("termList", commonService.getProfTermList(map));
		model.addAttribute("procStatus", procStatus);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);	
		model.addAttribute("addStartDate", addStartDate);
		model.addAttribute("addEndDate", addEndDate);
		model.addAttribute("type", type);
		model.addAttribute(profClassService.getClassOffRequestList(map));   
	  
		return retValue;
	}
	
	@RequestMapping(value = "muniv/main/classoff_view")
	public String adminClassOffView(@RequestParam(value = "req_no", defaultValue = "") String req_no, 
			@RequestParam(value = "view_type", defaultValue = "") String view_type,
			@RequestParam(value = "print_flag", defaultValue = "") String print_flag,
			Model model, HttpSession session){
	  
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("req_no", req_no);

		model.addAttribute("view_type", view_type);
		model.addAttribute("print_flag", print_flag);
		model.addAttribute("classOffRequest", profClassService.getClassOffRequestView(map));  
      
		return "prof/class/classoff_req_view";
	}

	@RequestMapping(value = "muniv/main/classoff_approve_list", method = RequestMethod.GET)
	public String adminClassOffApproveList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									@RequestParam(value = "curr_year", defaultValue = "") String year,
									@RequestParam(value = "curr_term_cd", defaultValue = "") String term_cd,
            						String searchItem,
						            @RequestParam(value="searchValue", defaultValue="") String searchValue, 
						            @RequestParam(value="type", defaultValue="") String type, 
                                    Model model, HttpSession session){
	  
		Map<String, Object> map = new HashMap<String, Object>();

		String userType = session.getAttribute("USER_TYPE").toString();

		if(userType != null && userType.equals("[ROLE_PROF]")) {
			map.put("prof_no", session.getAttribute("PROF_NO").toString());
		}    
		
		if (currentPage == null) {
			currentPage = 1;
		}		

		/* 
		 * 휴보강 신청내역 
		 * - 중복되지 않는 휴보강 내역
		 * - 휴보강 내역 외 출결 내역
		 * 
		 * */
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		
		if (year.equals("")) {
			year = session.getAttribute("YEAR").toString();
	    }
	    
	    if (term_cd.equals("")) {
	    	term_cd = session.getAttribute("TERM_CD").toString();
	    }
	    
	    map.put("year", year);
		map.put("term_cd", term_cd);
		
		map.put("type", type);
		map.put("class_type_cd", "G019C002");
		map.put("currentPage", currentPage);
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);

		model.addAttribute(profClassService.getClassOffApproveList(map));   
	  
		if(type.equals("EXCEL2")){
			return "prof/class/classoff_approve_list2";
		} else {
			return "prof/class/classoff_approve_list";
		}
		
		//return "prof/class/classoff_approve_list";
	}
	
	/*
	 * 관리자 > 휴,보강 처리 > 휴강사유 변경
	 */
	@RequestMapping(value = "muniv/main/classoff_change_reason")
	public String adminClassOffChangeInfo(@RequestParam(value = "req_no", defaultValue = "") String req_no, 
									@RequestParam(value = "reqReason", defaultValue = "") String reqReason, 
									Model model, HttpSession session){
	  
	    String msg = "";
	    
	    try {
			Map<String, Object> map = new HashMap<String, Object>();
			
	    	map.put("req_no", req_no);
	    	map.put("reqReason", reqReason);

	    	profClassMapper.updateClassoffRequestReason(map);
	
	    	msg = "정상적으로 처리되었습니다.";
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	logger.error("\r\n [classoff_proc][error]reqNo : " + req_no);
	    	msg = "오류가 발생했습니다.";
	    }		
	    
		model.addAttribute("message", msg);
	    
	    return "msg";
	}
	
	/*
	 * 관리자 > 휴,보강 처리
	 */
	@RequestMapping(value = "muniv/main/classoff_proc")
	public String adminClassOffProc(@RequestParam(value = "req_no", defaultValue = "") String req_no, 
									@RequestParam(value = "proc_type", defaultValue = "") String proc_type, 
									@RequestParam(value = "reject_reason", defaultValue = "") String reject_reason, 
									Model model, HttpSession session){
	  
	    String msg = "";
	    
	    try {
	    	
	    	msg = adminClassOffProc(req_no, proc_type, reject_reason);
	    	
	    	msg = CommonUtil.msgProc(msg);
	    	
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	logger.error("\r\n [classoff_proc][error]reqNo : " + req_no);
	    	msg = "오류가 발생했습니다.";
	    }		
	    
		model.addAttribute("message", msg);
	    
	    return "msg";
	}
	
	/*
	 * 관리자 > 휴,보강 처리 > 보강실시여부 변경
	 */
	@RequestMapping(value = "muniv/main/classoff_change_flag")
	public String classoffChangeFlag(@RequestParam(value = "chk_no", defaultValue = "") String chk_no, 
									@RequestParam(value = "classoff_flag", defaultValue = "") String classoff_flag,
									@RequestParam(value = "sayu", defaultValue = "") String sayu, 
									Model model, HttpSession session){
			
	 	String msg = "";
	    
	    try {
	    	
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	
	    	map.put("classoff_flag", classoff_flag);
	    	map.put("sayu", sayu);
	    	
	    	String[] arrReqNo = null;
			
			if(chk_no != null) {
				System.out.println("chk_no != null");
				
				arrReqNo = chk_no.split(",");
			} else {
				System.out.println("chk_no == null");			
			}
			
			if(arrReqNo != null && arrReqNo.length > 0) {
				
				for(int i = 0; i < arrReqNo.length; i++) {
					
					map.put("req_no", arrReqNo[i]);
					
					profClassMapper.updateClassoffChangeFlag(map);
				}
			}
	    	
			msg = "정상처리 되었습니다.";
			
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	logger.error("\r\n [classoff_change_flag][error]reqNo : " + chk_no);
	    	msg = "오류가 발생했습니다.";
	    }		
	    
		model.addAttribute("message", msg);
	
		return "msg";
	}
	
	/*
	 * 관리자 > 휴,보강 처리 > 보강실시여부 팝업
	 */
	@RequestMapping(value = "muniv/main/classoff_change_flag_popup")
	public String classoffChangeFlagPopup(@RequestParam(value = "chk_no", defaultValue = "") String chk_no, 
									Model model, HttpSession session){
		
		model.addAttribute("chk_no", chk_no);
		
		return "prof/class/classoff_change_flag_popup";
	}
	
	/*
	 * 관리자 > 휴,보강 처리 메소드 처리
	 */
	public String adminClassOffProc(String req_no,String proc_type, String reject_reason){
	  
	    String msg = "";
	    
	    /*
	     * 처리 절차
	     * 1. 신청정보 조회
	     * 2. 신청정보의 상태 변경
	     * 	2.1. 승인일 경우
	     * 		2.1.1. 신청 또는 취소에 따른 코드값 지정
	     * 	2.2. 반려일 경우
	     * 		2.2.1. 신청 또는 취소에 따른 코드값 지정
	     * 3. 휴,보강 또는 취소 처리
	     * 	3.1. 승인일 경우
	     * 		3.1.1. 휴,보강 또는 취소 처리 
	     * 	3.2. 반려일 경우
	     * 		3.2.1. 강의정보의 class_prog_cd 값 초기화
	     */
	    
	    try {
			Map<String, Object> map = new HashMap<String, Object>();
			String proc_status = "";
			String proc_reason = "";
			
			// 신청정보 조회시에는 req_no만 사용함 
	    	map.put("req_no", req_no);

	    	ClassOffRequest objClassOffRequest = profClassService.getClassOffRequestView(map);
			
			if(objClassOffRequest != null) {
		    	// 신청정보 변경값 지정
		    	if(proc_type.equalsIgnoreCase("APPROVAL")) {
		    		// 휴강요청이면 휴강승인으로, 취소요청이면 취소승인으로 지정
		    		if(objClassOffRequest.getProc_status().equalsIgnoreCase("G030C001")) {
			    		proc_status = "G030C002";
			    		proc_reason = "요청승인";
		    		} else {
			    		proc_status = "G030C005";
			    		proc_reason = "취소요청승인";
		    		}
		    	} else {
		    		// 휴강요청이면 휴강반려로, 취소요청이면 취소반려로 지정
		    		if(objClassOffRequest.getProc_status().equalsIgnoreCase("G030C001")) {
			    		proc_status = "G030C003";
		    		} else {
			    		proc_status = "G030C006";
		    		}
		    		
		    		proc_reason = reject_reason;
		    	}

				map.put("proc_status", proc_status);
				map.put("proc_reason", proc_reason);

				// 신청정보의 상태 변경
				profClassMapper.updateClassoffRequestStatus(map);
				
				if(proc_type.equalsIgnoreCase("APPROVAL")) {
					if(objClassOffRequest.getProc_status().equalsIgnoreCase("G030C001")) {
						// 휴,보강 처리
						msg = profClassService.classOffConfirm(objClassOffRequest, map);
					} else {
						// 휴강 취소처리
						msg = profClassService.restoreClassConfirm(objClassOffRequest, map);
					}
				} else {
					// 강의정보의 상태 변경 (class_prog_cd값을 G018C003에서 G018C001로 변경) 
					map.put("prog_cd",				"G018C001");
					map.put("univ_cd",				objClassOffRequest.getUniv_cd());
					map.put("year",					objClassOffRequest.getYear());
					map.put("term_cd",				objClassOffRequest.getTerm_cd());
					map.put("class_cd",				objClassOffRequest.getClass_cd());
					map.put("classday",				objClassOffRequest.getClassday());
					map.put("classhour_start_time",	objClassOffRequest.getClasshour_start_time());
					map.put("prof_no",				objClassOffRequest.getProf_no());
					
					// 휴강정보의 class_prof_cd 값을 휴강취소신청(G018C004)으로 지정
					profClassMapper.updateClassoffRequestAttendmaster(map);
					
					// 보강정보의 class_prof_cd 값도 휴강취소신청(G018C004)으로 지정
					profClassMapper.updateClassoffRequestAddAttendmaster(map);		
					
					msg = "success";					
				}
				
				// 신청정보의 상태 변경
				if(msg != null && (msg.equalsIgnoreCase("success") || msg.equalsIgnoreCase("success request"))) {
					profClassMapper.updateClassoffRequestStatus(map);

					msg = "PROC_SUCCESS";
				}				
			} else {
				msg = "NO_REQUEST";
			}
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	logger.error("\r\n [classoff_proc][error]reqNo : " + req_no);
	    	msg = "ERROR";
	    }		
	    
	    return msg;
	}
	
	/*
	 * 관리자 > 휴,보강 다중처리
	 */
	@RequestMapping(value = "muniv/main/classoff_multi_proc")
	public String adminClassOffMultiProc(@RequestParam(value = "req_no", defaultValue = "") String req_no, 
									@RequestParam(value = "proc_type", defaultValue = "") String proc_type, 
									@RequestParam(value = "reject_reason", defaultValue = "") String reject_reason, 
									Model model, HttpSession session){
	  
	    String msg = "";
		
		try {
			String[] arrReqNo = null;
			
			if(req_no != null) {
				arrReqNo = req_no.split(",");
			}
			
			if(arrReqNo != null && arrReqNo.length > 0) {
				
				for(int i = 0; i < arrReqNo.length; i++) {
					msg = adminClassOffProc(arrReqNo[i], proc_type, "관리자처리");
						
					if(!msg.equalsIgnoreCase("PROC_SUCCESS")) {
						 throw new Exception();
					}
				}
			}			
			
			msg="정상 처리되었습니다.";
		}catch(Exception e){
			if(msg.equalsIgnoreCase("already exist")) {
				msg="강의가 이미 존재합니다.";
			} else {
				msg="오류가 발생했습니다.";				
			}
			
			e.printStackTrace();
		}	    
	    
		model.addAttribute("message", msg);
	    
	    return "msg";
	}	
}
