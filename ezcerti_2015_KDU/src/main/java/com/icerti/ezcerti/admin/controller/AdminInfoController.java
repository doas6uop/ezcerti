package com.icerti.ezcerti.admin.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icerti.ezcerti.admin.service.AdminInfoService;
import com.icerti.ezcerti.admin.service.AdminStudentService;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Classhour;
import com.icerti.ezcerti.domain.ClassoffManage;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Gonggyul;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.prof.dao.ProfClassMapper;


@Controller
public class AdminInfoController {

	@Autowired
	private AdminInfoService adminInfoService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private CommonMapper commonMapper;

	@Autowired
	private ProfClassMapper profClassMapper;
	
	@Autowired
	private AdminStudentService adminStudentService = null;
	
	@RequestMapping(value = "muniv/info/admin_list", method = RequestMethod.GET)
	public String adminList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
						   String item,
						   @RequestParam(value="value", defaultValue="") String searchValue, 
						   Model model, HttpSession session){
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("admin_no", session.getAttribute("ADMIN_NO").toString());		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		
		model.addAttribute(adminInfoService.getAdminList(map));
		
		return "admin/info/admin_list";
	}
	
	@RequestMapping(value = "muniv/info/admin_view", method = RequestMethod.GET)
	public String adminInfoView(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
							 String item,
							 @RequestParam(value="value", defaultValue="") String searchValue,
							 String user_no, 
							 Model model, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("admin_no", user_no);
		map = adminInfoService.getAdminView(map);
		
		model.addAttribute("admin", map.get("admin"));
				
		return "admin/info/admin_view";
	}
	
	@RequestMapping(value = "muniv/info/admin_modify", method = RequestMethod.POST)
	public String adminInfoModify(@RequestParam(value="user_no") String admin_no, 
								   Admin admin, Model model, HttpSession session){
	  
		String reg_type_cd = session.getAttribute("REG_TYPE_CD").toString();
		String msg = "";
		String user_no = session.getAttribute("ADMIN_NO").toString();
		if(reg_type_cd.equals("G017C001")||user_no.equals(admin_no)){
			admin.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			admin.setAdmin_no(admin_no);
	    
			try {
				adminInfoService.updateAdminInfo(admin);
				session.removeAttribute("ADMIN_INFO");
				session.setAttribute("ADMIN_INFO", commonMapper.loginAdminInfo(admin));
				msg="?????? ?????????????????????.";
			} catch(Exception e) {
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		} else {
			msg = "??????????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		
		return "msg";
	}
	
	@RequestMapping(value = "muniv/info/admin_delete", method = RequestMethod.POST)
	public String adminInfoDelete(@RequestParam(value="user_no") String admin_no, Model model, HttpSession session){
		String reg_type_cd = session.getAttribute("REG_TYPE_CD").toString();
		String msg = "";
		
		if(reg_type_cd.equals("G017C001")){
			Admin admin = new Admin();
			admin.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			admin.setAdmin_no(admin_no);
	    
			try {
				adminInfoService.deleteAdminInfo(admin);
				msg="?????? ?????????????????????.";
			} catch(Exception e) {
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		} else {
			msg = "????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		
		return "msg";
	}
	
	/**
	 * ??????????????? ????????????
	 * ?????? view : student_list, admin_member_join, prof_list
	 * @param coll_cd
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/muniv/info/getdept", method = RequestMethod.GET)
	public @ResponseBody Collection<Dept> getDept(String coll_cd, Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("coll_cd", coll_cd);
		
		Collection<Dept> dept = adminInfoService.getDept(map);
		
		model.addAttribute("deptList", dept);
		
		for (Dept dept2 : dept) {
			System.out.println(dept2.toString());
		}
		
		return dept;
	}
	
	@RequestMapping(value = "muniv/info/admin_member_join", method = RequestMethod.GET)
	public String adminMemberJoinView(Admin admin, Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("collList", adminInfoService.getColl(map));
		
		model.addAttribute("admin", admin);
		model.addAttribute(map.get("collList"));
		
		return "admin/info/admin_member_join";
	}
	
	@RequestMapping(value = "muniv/info/admin_member_join", method = RequestMethod.POST)
	public String adminMemberJoin(Admin admin, Model model, HttpSession session){
		String reg_type_cd = session.getAttribute("REG_TYPE_CD").toString();
		String msg = "";
		
		if(reg_type_cd.equals("G017C001")){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("univ_cd", session.getAttribute("UNIV_CD"));
			map.put("year", session.getAttribute("YEAR").toString());
			map.put("term_cd", session.getAttribute("TERM_CD"));
			map.put("coll_cd", admin.getColl_cd());
			map.put("dept_cd", admin.getDept_cd());
		
			admin.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			admin.setReg_type_cd(session.getAttribute("REG_TYPE_CD").toString());
			admin.setColl_name(adminInfoService.getCollName(map));
			admin.setDept_name(adminInfoService.getDeptName(map));
		
			adminInfoService.insertAdminInfo(admin);
			
			msg = "?????? ?????????????????????.";
		} else {
			msg = "??????????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		
		return "msg";
	}
	
	@RequestMapping(value = "muniv/info/admin_member_chk", method = RequestMethod.POST)
	public String adminMemberCheck(@RequestParam(value="user_no") String admin_no, Model model,HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "";
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("admin_no", admin_no);
		
		System.out.println(session.getAttribute("UNIV_CD").toString());
		System.out.println(admin_no);
		
		int memberChk;
		memberChk = adminInfoService.getAdminChk(map);
		
		if(memberChk==1){
			msg="no";
		}else if(memberChk==0){
			msg="ok";
		}else{
			msg="error";
		}
		
		model.addAttribute("message", msg);
		System.out.println(msg);
		
		return "msg";
	}
	
	@RequestMapping(value = "muniv/info/classroom_hour", method = RequestMethod.POST)
	public String classroomHour(@RequestParam(value = "year") String year,
			  						@RequestParam(value = "term_cd") String term_cd,
			  						@RequestParam(value = "reserve_date") String reserve_date,
			  						@RequestParam(value = "classroom_no") String classroom_no,
			  						Model model, HttpSession session) {	  
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());		
		map.put("year", year);
		map.put("term_cd", term_cd);
		map.put("reserve_date", reserve_date);
		map.put("classroom_no", classroom_no);

		// ???????????? ?????? ?????? ??????
		List<Classhour> list = profClassMapper.getClassroomhour(map);
		model.addAttribute("list", list);
		
		return "admin/info/classroom_hour";
	}  	
	
	/* ????????? ?????? > ??????????????????????????? */
	@RequestMapping(value = "muniv/info/reserved_list")
	public String classroomReservedList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
					      @RequestParam(value = "year", defaultValue = "") String year,		      
					      @RequestParam(value = "term_cd", defaultValue = "") String term_cd,
					      @RequestParam(value = "classroom_no", defaultValue = "") String classroom_no,
					      @RequestParam(value = "sdate", defaultValue = "") String classday_start, 
					      @RequestParam(value = "edate", defaultValue = "") String classday_end,
					      @RequestParam(value="sortField", defaultValue="") String sortField, 
                          @RequestParam(value="sortOrder", defaultValue="") String sortOrder, 
                          @RequestParam(value="type", defaultValue="") String type,
					      Model model, HttpSession session){
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		
		/*
		 * ?????? ???????????? ?????? ?????? ??????
		 * - year??? null ????????? session?????? ?????? ????????????.
		 *   year??? null??? ??????????????? ????????? ??????????????? ?????? ?????? paging?????? ?????? 
		 */
		if(year == null || year.equals("") ) {
			year = session.getAttribute("YEAR").toString();
		} 
		map.put("year", year);

		// ???????????? ??????
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		map.put("currentPage", currentPage);
		map.put("classroom_no", classroom_no);
		map.put("classday_start", classday_start);
		map.put("classday_end", classday_end);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		// requset??? ???????????? ????????? ???????????? ???????????? ??????
		if(term_cd != null && term_cd.length() > 0) {
			map.put("term_cd", term_cd);
		}

		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/info/reserved_list_excel";
		} else {
			retValue = "admin/info/reserved_list";
		}
		
		model.addAttribute("univ_cd", map.get("univ_cd").toString());
		model.addAttribute("year", map.get("year").toString());
		model.addAttribute("term_cd", map.get("term_cd").toString());
		model.addAttribute("classroom_no", classroom_no);
		model.addAttribute("sdate", classday_start);
		model.addAttribute("edate", classday_end);
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		
		// ?????? ??????
		model.addAttribute("termList", commonService.getProfTermList(map));
		// ????????? ?????? 
		model.addAttribute("classroomList", profClassMapper.getClassroomList(map)); 
		// ????????????????????? ??????
		model.addAttribute(adminInfoService.getClassroomReservedList(map));
		
		return retValue;
	}	
	
	/* ????????? ?????? > ??????????????????????????? */
	@RequestMapping(value = "muniv/info/classroom_reserve", method = RequestMethod.POST)
	public String classroomReserve(@RequestParam(value="term_cd", defaultValue="") String term_cd,
							      @RequestParam(value = "reserve_date", defaultValue = "") String reserve_date,
							      @RequestParam(value = "classroom_no", defaultValue = "") String classroom_no,
							      Model model, HttpSession session){
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		
		if(term_cd != null && term_cd.length() > 0) {
			map.put("term_cd", term_cd);
		}

		map.put("reserve_date", reserve_date);
		map.put("classroom_no", classroom_no);
		
		// ????????? ?????? 
		model.addAttribute("classroomList", profClassMapper.getClassroomList(map)); 

		model.addAttribute("univ_cd",		map.get("univ_cd").toString()); 
		model.addAttribute("year",			map.get("year").toString()); 
		model.addAttribute("term_cd",		map.get("term_cd").toString()); 
		model.addAttribute("reserve_date",	map.get("reserve_date").toString()); 
		model.addAttribute("classroom_no",	map.get("classroom_no").toString()); 
		
		return "admin/info/classroom_reserve";
	}
	
	/* ????????? ?????? > ????????????????????? ?????? */
	@RequestMapping(value = "muniv/info/reserve_confirm", method = RequestMethod.POST)
	public String insertClassroomReserveInfo(@RequestParam(value="year", defaultValue="") String year,
										@RequestParam(value="term_cd", defaultValue="") String term_cd,			
										@RequestParam(value="reserve_date", defaultValue="") String reserve_date,			
										@RequestParam(value="classroom_no", defaultValue="") String classroom_no,			
										@RequestParam(value="reserve_time", defaultValue="") String reserve_time,			
										@RequestParam(value="reason", defaultValue="") String reason,			
										Model model, HttpSession session){

		boolean isCheck = true;
		String msg = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd",	session.getAttribute("UNIV_CD").toString());
		map.put("year",		(year != null && year.length() > 0) ? year : session.getAttribute("YEAR").toString());
		map.put("term_cd",	(term_cd != null && term_cd.length() > 0) ? term_cd : session.getAttribute("TERM_CD").toString());
		
		map.put("reserve_date", reserve_date);
		map.put("classroom_no", classroom_no);
		map.put("reserve_time", reserve_time);
		map.put("reason", reason);		
		
		if(reserve_date == null || reserve_date.equals("") || 
			classroom_no == null || classroom_no.equals("") ||
			reserve_time == null || reserve_time.equals("")) {
			isCheck = false;
		}
		
		if(isCheck) {
		    try {
				map.put("start_time", reserve_time.split("\\|")[0]);
				map.put("end_time", reserve_time.split("\\|")[1]);
		    	
		    	adminInfoService.insertClassroomReserveInfo(map);
		    	msg="?????? ?????????????????????.";
		    } catch(Exception e) {
		    	msg="????????? ??????????????????.";
		    	e.printStackTrace();
		    }
		} else {
			msg = "????????? ???????????????.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ????????? ?????? > ????????????????????? ?????? */
	@RequestMapping(value = "muniv/info/reserve_delete", method = RequestMethod.POST)
	public String deleteClassroomReserveInfo(@RequestParam(value="reserve_info", defaultValue="") String reserve_info,
									Model model, HttpSession session){
		
		boolean isCheck = true;
		String msg = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(reserve_info == null || reserve_info.equals("")) {
			isCheck = false;
		}
		
		if(isCheck) {
		    try {
				map.put("univ_cd",		reserve_info.split("\\|")[0]);
				map.put("year",			reserve_info.split("\\|")[1]);
				map.put("term_cd",		reserve_info.split("\\|")[2]);
				
				map.put("classroom_no", reserve_info.split("\\|")[3]);
				map.put("reserve_date",	reserve_info.split("\\|")[4]);
				map.put("start_time",	reserve_info.split("\\|")[5]);
				map.put("end_time",		reserve_info.split("\\|")[6]);
		    	
		    	adminInfoService.deleteClassroomReserveInfo(map);
		    	msg="?????? ?????????????????????.";
		    } catch(Exception e) {
		    	msg="????????? ??????????????????.";
		    	e.printStackTrace();
		    }
		} else {
			msg = "????????? ???????????????.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ???????????? */
	public boolean getAuthCheck(HttpSession session) {
		
		String user_type = session.getAttribute("USER_TYPE").toString();
		boolean bAuth = false;
		
		if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]")){
			bAuth = true;
		}
		
		System.out.println("bAuth:["+bAuth+"]");		
	
		return bAuth;
	}	
	
	/* ???????????? > ???????????? ????????? */
	@RequestMapping(value = "muniv/info/gonggyul_list")
	public String gonggyulList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
					      @RequestParam(value = "term_cd", defaultValue = "all") String term_cd,
					      @RequestParam(value="sortField", defaultValue="") String sortField, 
                          @RequestParam(value="sortOrder", defaultValue="") String sortOrder, 
                          @RequestParam(value="type", defaultValue="") String type,
					      @RequestParam(value = "search_type", defaultValue = "") String search_type,
					      @RequestParam(value = "search_value", defaultValue = "") String search_value,
					      @RequestParam(value = "sdate", defaultValue = "") String gong_ilja_start, 
					      @RequestParam(value = "edate", defaultValue = "") String gong_ilja_end, 
					      Model model, HttpSession session){
		
		// ???????????? ????????? ?????? (CHUL_TB_GONGGYUL)
		Map<String, Object> map = new HashMap<String, Object>();
		
		/*
		 * ????????? ?????? ??????.
		 * ??????, ??????, ???????????? ??????
		 */
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", term_cd);
		map.put("currentPage", currentPage);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		map.put("search_type", search_type);
		map.put("search_value", search_value);
		
		map.put("gong_ilja_start", gong_ilja_start);
		map.put("gong_ilja_end", gong_ilja_end);

		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/info/gonggyul_list_excel";
		} else {
			retValue = "admin/info/gonggyul_list";
		}
		
		model.addAttribute("univ_cd", map.get("univ_cd").toString());
		model.addAttribute("year", map.get("year").toString());
		model.addAttribute("term_cd", map.get("term_cd").toString());
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("type", type);
		
		model.addAttribute("search_type", search_type);
		model.addAttribute("search_value", search_value);
		model.addAttribute("sdate", gong_ilja_start);
		model.addAttribute("edate", gong_ilja_end);

		// ?????? ?????????
		model.addAttribute(adminInfoService.getGonggyulList(map));
		
		return retValue;
	}	
	
	/* ????????????  > ??????????????? */
	@RequestMapping(value = "muniv/info/gonggyul_insert_form", method = RequestMethod.GET)
	public String gonggyulInsertForm(Model model, HttpSession session){
		model.addAttribute("year", session.getAttribute("YEAR").toString());
		model.addAttribute("term_cd", session.getAttribute("TERM_CD").toString());
		return "admin/info/gonggyul_insert_form";
	}	
	
	/* ???????????? > ??????????????? > ??????????????? */
	@RequestMapping(value = "muniv/info/gonggyul_classname_list")
	public @ResponseBody Map<String , Object> gonggyulClassnameList(@RequestParam(value = "student_no", defaultValue = "") String student_no,
								@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
								@RequestParam(value = "startDate", defaultValue = "") String gong_ilja_start,
								@RequestParam(value = "endDate", defaultValue = "") String gong_ilja_end,
								@RequestParam(value = "gonggyul_no", defaultValue = "") String gonggyul_no,
								Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		
		if(term_cd == null || term_cd.equals("")) { 
			term_cd = session.getAttribute("TERM_CD").toString();
		}
		
		map.put("student_no", student_no);
		map.put("term_cd", term_cd);
		map.put("gong_ilja_start", gong_ilja_start);
		map.put("gong_ilja_end", gong_ilja_end);
		map.put("gonggyul_no", gonggyul_no);
		
		Map<String, Object> jsonObject = new HashMap<String, Object>();
	    jsonObject.put("list", adminInfoService.getGonggyulClassnameList(map));
	         
	    return jsonObject; 
	}
	
	/* ???????????? > ???????????? */
	@RequestMapping(value = "muniv/info/gonggyul_insert_ok")
	public String gonggyulInsertOk(Gonggyul gonggyul, Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		boolean duplicationFlag = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		String arrYear[] = null; 
		
		if(bModEnable) {
			
			arrYear = gonggyul.getGong_ilja_start().split("-");
			gonggyul.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			gonggyul.setTerm_cd(session.getAttribute("TERM_CD").toString());
			gonggyul.setYear(arrYear[0]);
			
			// ?????? ????????????
			duplicationFlag = adminInfoService.duplicationGonggyul(gonggyul);
			
			if(duplicationFlag){
				
				try {
					//???????????? ????????????
					adminInfoService.gonggyulInsertOk(gonggyul);
					
					msg = "success";
				}catch(Exception e){
					msg = "????????? ??????????????????.";
					e.printStackTrace();
				}
				
			} else {
				msg = "dup";
			}
			
		} else {
			msg = "fail";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ???????????? > ?????? ???????????? */
	@RequestMapping(value = "muniv/info/gonggyul_view", method = RequestMethod.GET)
	public String gonggyulView(@RequestParam(value = "gonggyul_no", defaultValue = "") String gonggyul_no,
					Model model, HttpSession session){
		// ????????????
		model.addAttribute("gonggyul", adminInfoService.gonggyulView(gonggyul_no));
		
		return "admin/info/gonggyul_view";
	}
	
	/* ???????????? > ??????????????? */
	@RequestMapping(value = "muniv/info/gonggyul_modify_form", method = RequestMethod.GET)
	public String gonggyulModifyForm(@RequestParam(value = "gonggyul_no", defaultValue = "") String gonggyul_no,
					Model model, HttpSession session){
		// ????????????
		model.addAttribute("gonggyul", adminInfoService.gonggyulView(gonggyul_no));
		
		return "admin/info/gonggyul_modify_form";
	}
	
	/* ???????????? > ???????????? */
	@RequestMapping(value = "muniv/info/gonggyul_modify_ok")
	public String gonggyulModifyOk(Gonggyul gonggyul, Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		boolean duplicationFlag = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		String arrYear[] = null;
		
		if(bModEnable) {
			
			arrYear = gonggyul.getGong_ilja_start().split("-");
			gonggyul.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			gonggyul.setTerm_cd(session.getAttribute("TERM_CD").toString());
			gonggyul.setYear(arrYear[0]);
			
			// ?????? ????????????
			duplicationFlag = adminInfoService.duplicationGonggyul(gonggyul);
			
			if(duplicationFlag){
				
				try {
					//???????????? ????????????
					adminInfoService.gonggyulModifyOk(gonggyul);
					
					msg="success";
				}catch(Exception e){
					msg="????????? ??????????????????.";
					e.printStackTrace();
				}
				
			} else {
				msg = "dup";
			}
			
		} else {
			msg = "fail";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ???????????? > ????????????(??????) */
	@RequestMapping(value = "muniv/info/gonggyul_search_popup", method = RequestMethod.GET)
	public String gonggyulSearchPopup(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								@RequestParam(value="item", defaultValue="") String item,
							    @RequestParam(value="value", defaultValue="") String searchValue,
								Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) {
			currentPage = 1;
		}
		
		if(item == null || item.equals("")) {
			item = "name";
		}
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		map.put("currentPage", currentPage);
		
		map.put("item", item);
		map.put("searchValue", searchValue);
		map.put("coll_cd", "");
		map.put("dept_cd", "");
		
		// ??????????????????
		model.addAttribute(adminStudentService.getStudentList(map));
		
		return "admin/info/gonggyul_search_popup";
	}
	
	/* ???????????? > ???????????? */
	@RequestMapping(value = "muniv/info/gonggyul_delete")
	public String gonggyulDelete(@RequestParam(value = "chk_no", defaultValue = "") String chk_no,
					Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		
		if(bModEnable) {
			
			try {
				// ????????????
				adminInfoService.gonggyulDelete(chk_no);
				
				msg="?????? ?????????????????????.";
			}catch(Exception e){
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		} else {
			msg = "????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ????????????  > ?????????????????? ????????? */
	@RequestMapping(value = "muniv/info/classoff_manage_list")
	public String classoffManageList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
					      @RequestParam(value = "term_cd", defaultValue = "all") String term_cd,
					      @RequestParam(value="sortField", defaultValue="") String sortField, 
                          @RequestParam(value="sortOrder", defaultValue="") String sortOrder, 
                          @RequestParam(value="type", defaultValue="") String type,
					      @RequestParam(value = "sdate", defaultValue = "") String sdate, 
					      @RequestParam(value = "edate", defaultValue = "") String edate,
					      @RequestParam(value = "perform_flag", defaultValue = "all") String perform_flag,
					      Model model, HttpSession session){
		
		// ?????????????????? ?????? ?????????(CHUL_TB_CLASSOFFMANAGE)
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", term_cd);
		map.put("currentPage", currentPage);
		map.put("sortField", sortField);
		map.put("sortOrder", sortOrder);
		map.put("type", type);
		
		map.put("sdate", sdate);
		map.put("edate", edate);
		map.put("perform_flag", perform_flag);
		
		String retValue = "";
		
		if(type != null && type.equals("EXCEL")) {
			retValue = "admin/info/classoff_manage_list_excel";
		} else {
			retValue = "admin/info/classoff_manage_list";
		}
		
		model.addAttribute("univ_cd", map.get("univ_cd").toString());
		model.addAttribute("year", map.get("year").toString());
		model.addAttribute("term_cd", map.get("term_cd").toString());
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortOrder", sortOrder);
		model.addAttribute("type", type);
		
		model.addAttribute("sdate", sdate);
		model.addAttribute("edate", edate);
		model.addAttribute("perform_flag", perform_flag);
		
		// ?????????????????? ?????????
		model.addAttribute(adminInfoService.getClassoffManageList(map));
		
		return retValue;
	}
	
	/* ????????????  > ?????????????????? ????????? */
	@RequestMapping(value = "muniv/info/classoff_manage_insert_form", method = RequestMethod.GET)
	public String holidayInsertForm(Model model, HttpSession session){
		return "admin/info/classoff_manage_insert_form";
	}	
	
	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/classoff_manage_insert_ok")
	public String classoffManageInsertOk(ClassoffManage classoffManage, Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		boolean duplicationFlag = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		String arrYear[] = null; 
		
		if(bModEnable) {
			
			arrYear = classoffManage.getClassday().split("-");
			classoffManage.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			classoffManage.setTerm_cd(session.getAttribute("TERM_CD").toString());
			classoffManage.setYear(arrYear[0]);
			
			// ?????? ????????????
			duplicationFlag = adminInfoService.duplicationClassoffManage(classoffManage);
			
			if(duplicationFlag){
				
				try {
					//???????????? ????????????
					adminInfoService.classoffManageInsertOk(classoffManage);
					
					msg = "success";
				}catch(Exception e){
					msg = "????????? ??????????????????.";
					e.printStackTrace();
				}
				
			} else {
				msg = "dup";
			}
			
		} else {
			msg = "fail";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ???????????? > ?????????????????? ???????????? */
	@RequestMapping(value = "muniv/info/classoff_manage_view", method = RequestMethod.GET)
	public String classoffManageView(@RequestParam(value = "classoffmanage_no", defaultValue = "") String classoffmanage_no,
					Model model, HttpSession session){
		// ????????????
		model.addAttribute("classoffmanage", adminInfoService.classoffManageView(classoffmanage_no));
		
		return "admin/info/classoff_manage_view";
	}
	
	/* ????????????  > ?????????????????? ????????? */
	@RequestMapping(value = "muniv/info/classoff_manage_modify_form", method = RequestMethod.GET)
	public String classoffManageModifyForm(@RequestParam(value = "classoffmanage_no", defaultValue = "") String classoffmanage_no,
					Model model, HttpSession session){
		// ????????????
		model.addAttribute("classoffmanage", adminInfoService.classoffManageView(classoffmanage_no));
		
		return "admin/info/classoff_manage_modify_form";
	}
	
	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/classoff_manage_modify_ok")
	public String classoffManageModifyOk(ClassoffManage classoffManage, Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		boolean duplicationFlag = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		String arrYear[] = null;
		
		if(bModEnable) {
			
			arrYear = classoffManage.getClassday().split("-");
			classoffManage.setUniv_cd(session.getAttribute("UNIV_CD").toString());
			classoffManage.setTerm_cd(session.getAttribute("TERM_CD").toString());
			classoffManage.setYear(arrYear[0]);
			
			// ?????? ????????????
			duplicationFlag = adminInfoService.duplicationClassoffManage(classoffManage);
			
			if(duplicationFlag){
				
				try {
					//???????????? ????????????
					adminInfoService.classoffManageModifyOk(classoffManage);
					
					msg="success";
				}catch(Exception e){
					msg="????????? ??????????????????.";
					e.printStackTrace();
				}
				
			} else {
				msg = "dup";
			}
			
		} else {
			msg = "fail";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/classoff_manage_delete")
	public String classoffManageDelete(@RequestParam(value = "chk_no", defaultValue = "") String chk_no,
					Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		
		if(bModEnable) {
			
			try {
				// ????????????
				adminInfoService.classoffManageDelete(chk_no);
				
				msg="?????? ?????????????????????.";
			}catch(Exception e){
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		} else {
			msg = "????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}
	
	/* ????????????  > ?????????????????? ???????????? ?????? */
	@RequestMapping(value = "muniv/info/classoff_manage_perform")
	public String classoffManagePerform(@RequestParam(value = "chk_no", defaultValue = "") String chk_no,
					Model model, HttpSession session){
		
		String msg = "";
		boolean bModEnable = false;
		
		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		
		if(bModEnable) {
			
			try {
				// ???????????? ??????
				adminInfoService.classoffManagePerform(chk_no);
				
				msg="?????? ?????????????????????.";
			}catch(Exception e){
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		} else {
			msg = "????????? ????????????.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}

	/* ????????????  > ?????????????????? ????????? */
	@RequestMapping(value = "muniv/info/univyear_insert_form", method = RequestMethod.GET)
	public String univYearInsertForm(Model model, HttpSession session){
		// ???????????? ??????
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		map.put("year", session.getAttribute("YEAR").toString());
		map.put("term_cd", session.getAttribute("TERM_CD"));
		model.addAttribute("univyear", commonService.getClasshourInfo(map));

		return "admin/info/univyear_insert_form";
	}

	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/univyear_get_day_of_week_cnt")
	public @ResponseBody Map<String , Object> univYearGetDayOfWeekCnt(Univ univ, Model model, HttpSession session){

		Map<String, Object> jsonObject = new HashMap<String, Object>();

		if(univ.getTerm_start_date().toString().equals("0001-01-01")) univ.setTerm_start_date(null);
		if(univ.getTerm_end_date().toString().equals("0001-01-01")) univ.setTerm_end_date(null);
		if(univ.getBogang_start().toString().equals("0001-01-01")) univ.setBogang_start(null);
		if(univ.getBogang_end().toString().equals("0001-01-01")) univ.setBogang_end(null);
		if(univ.getNoclass_start().toString().equals("0001-01-01")) univ.setNoclass_start(null);
		if(univ.getNoclass_end().toString().equals("0001-01-01")) univ.setNoclass_end(null);

	    jsonObject.put("dayOfWeekList", adminInfoService.univYearGetDayOfWeekCnt(univ));

	    return jsonObject;
	}

	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/univyear_insert_ok")
	public String univYearInsertOk(Univ univ, Model model, HttpSession session){

		String msg = "";
		String sts = "";
		boolean bModEnable = false;

		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);
		String term = "";
		sts = univ.getUniv_sts_cd();

		if(univ.getTerm_start_date().toString().equals("0001-01-01")) univ.setTerm_start_date(null);
		if(univ.getTerm_end_date().toString().equals("0001-01-01")) univ.setTerm_end_date(null);
		if(univ.getBogang_start().toString().equals("0001-01-01")) univ.setBogang_start(null);
		if(univ.getBogang_end().toString().equals("0001-01-01")) univ.setBogang_end(null);
		if(univ.getNoclass_start().toString().equals("0001-01-01")) univ.setNoclass_start(null);
		if(univ.getNoclass_end().toString().equals("0001-01-01")) univ.setNoclass_end(null);
		if(univ.getLssn_admt_dt().toString().equals("0001-01-01")) univ.setLssn_admt_dt(null);
/*
		if(univ.getChul_start_dt().toString().equals("0001-01-01")) univ.setChul_start_dt(null);
		if(univ.getChul_end_dt().toString().equals("0001-01-01")) univ.setChul_end_dt(null);
		if(univ.getChul_term().toString().equals("")) univ.setChul_term(null);
*/
		if(bModEnable) {

			univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());

			if(univ.getTerm_cd().equals("G002C001"))
			{
				term = "1??????";
			}
			else if(univ.getTerm_cd().equals("G002C002"))
			{
				term = "2??????";
			}
			else if(univ.getTerm_cd().equals("G002C003"))
			{
				term = "??????";
			}
			else if(univ.getTerm_cd().equals("G002C004"))
			{
				term = "??????";
			}

			univ.setTerm_name(univ.getYear()+"??? "+term);

			try {

				//?????????????????? ????????????
				adminInfoService.univYearInsertOk(univ);

				if(sts.equals("G004C001")) {
					adminInfoService.univYearStscd(univ);
				}

				// ?????????????????? ???????????? ??????
				adminInfoService.createClassday(univ);

				msg = "????????? ?????? ???????????????.";
			}catch(Exception e){
				msg = "????????? ??????????????????.";
				e.printStackTrace();
			}

		} else {
			msg = "fail";
		}

		model.addAttribute("message", msg);
		return "msg";
	}

	/* ???????????? > ?????????????????? ???????????? */
	@RequestMapping(value = "muniv/info/univyear_view", method = RequestMethod.GET)
	public String univYearView(@RequestParam(value = "univ_cd", defaultValue = "") String univ_cd,
					@RequestParam(value = "year", defaultValue = "") String year,
					@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
					Model model, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("univ_cd", univ_cd);
		map.put("year", year);
		map.put("term_cd", term_cd);

		// ????????????
		model.addAttribute("univyear", adminInfoService.univYearView(map));

		return "admin/info/univyear_view";
	}

	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/univyear_modify_ok")
	public String univYearModifyOk(Univ univ, Model model, HttpSession session){

		String msg = "";
		String sts = "";
		boolean bModEnable = false;

		if(univ.getTerm_start_date().toString().equals("0001-01-01")) univ.setTerm_start_date(null);
		if(univ.getTerm_end_date().toString().equals("0001-01-01")) univ.setTerm_end_date(null);
		if(univ.getBogang_start().toString().equals("0001-01-01")) univ.setBogang_start(null);
		if(univ.getBogang_end().toString().equals("0001-01-01")) univ.setBogang_end(null);
		if(univ.getNoclass_start().toString().equals("0001-01-01")) univ.setNoclass_start(null);
		if(univ.getNoclass_end().toString().equals("0001-01-01")) univ.setNoclass_end(null);
		if(univ.getLssn_admt_dt().toString().equals("0001-01-01")) univ.setLssn_admt_dt(null);
/*
		if(univ.getChul_start_dt().toString().equals("0001-01-01")) univ.setChul_start_dt(null);
		if(univ.getChul_end_dt().toString().equals("0001-01-01")) univ.setChul_end_dt(null);
		if(univ.getChul_term().toString().equals("")) univ.setChul_term(null);
*/

		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);

		sts = univ.getUniv_sts_cd();

		if(bModEnable) {

			univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());

				try {

					//???????????? ????????????
					adminInfoService.univYearModifyOk(univ);

					if(sts.equals("G004C001")) {
						adminInfoService.univYearStscd(univ);
					}

					// ?????????????????? ???????????? ??????
					adminInfoService.createClassday(univ);

					msg="success";
				}catch(Exception e){
					msg="????????? ??????????????????.";
					e.printStackTrace();
				}
		}

		model.addAttribute("message", msg);
		return "msg";
	}

	/* ????????????  > ?????????????????? ?????? */
	@RequestMapping(value = "muniv/info/univyear_delete_ok", method = RequestMethod.GET)
	public String univYearDeleteOk(@RequestParam(value = "year", defaultValue = "") String year,
								@RequestParam(value = "term_cd", defaultValue = "") String term_cd,
								Model model, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "";
		boolean bModEnable = false;

		map.put("year", year);
		map.put("term_cd", term_cd);

		// ?????? ?????? //////
		bModEnable = getAuthCheck(session);

		if(bModEnable) {
			try {
				// ????????????????????? ??????
				adminInfoService.univYearDeleteOkUnivTerm(map);

				// ????????????????????? ??????
				adminInfoService.univYearDeleteOkClassday(map);

				msg="success";
			}catch (Exception e) {
				// TODO: handle exception
				msg="????????? ??????????????????.";
				e.printStackTrace();
			}
		}

		model.addAttribute("message", msg);
		return "msg";
	}
}
