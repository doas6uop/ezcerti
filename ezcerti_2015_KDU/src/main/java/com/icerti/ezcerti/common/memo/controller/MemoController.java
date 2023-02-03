package com.icerti.ezcerti.common.memo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.common.memo.service.MemoService;
import com.icerti.ezcerti.admin.service.AdminProfService;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Memo;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.UserInfo;

@Controller
public class MemoController {
	
	@Autowired
	private MemoService memoService;

	@Autowired
	private AdminProfService adminProfService;
	
	@RequestMapping(value = "comm/memo/memo_list")
	public String memoList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								@RequestParam(value="searchItem", defaultValue="") String searchItem, 
								@RequestParam(value="searchValue", defaultValue="") String searchValue, 
								Model model, HttpSession session){
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		System.out.println("currentPage:["+currentPage+"],searchItem:["+searchItem+"],searchValue:["+searchValue+"]");
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("currentPage", currentPage);
		
		UserInfo userInfo = getUserInfo(session);
		String user_type = session.getAttribute("USER_TYPE").toString();
		
		if(user_type != null) {
			if(user_type.equals("[ROLE_ADMIN]") || user_type.equals("[ROLE_SYSTEM]")) {
				map.put("to_user_no", "");
			} else if(user_type.equals("[ROLE_PROF]")) {
				map.put("to_user_no", userInfo.getUser_no());
			}			
		} else {
			// 사용자 정보가 없을 경우 검색이 되지 않도록
			map.put("to_user_no", "ANONYMOUS");
		}

	    model.addAttribute("cPage", currentPage);
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		model.addAttribute(memoService.getMemoList(map));
		
		return "common/memo/memo_list";
	}
	
	@RequestMapping(value = "comm/memo/memo_view")
	public String memoInfoView(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
									@RequestParam(value="searchItem", defaultValue="") String searchItem, 
									@RequestParam(value="searchValue", defaultValue="") String searchValue,
									String memo_no, 
									Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("currentPage:["+currentPage+"],searchItem:["+searchItem+"],searchValue:["+searchValue+"]");
		System.out.println("memo_no:["+memo_no+"]");
		
		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("memo_no", memo_no);
		
		map.put("searchItem", searchItem);
		map.put("searchValue", searchValue);
		map.put("currentPage", currentPage);

		UserInfo userInfo = getUserInfo(session);

		map.put("user_no", userInfo.getUser_no());

		map = memoService.getMemoView(map);

		model.addAttribute("user_no", userInfo.getUser_no());
		model.addAttribute("user_type", session.getAttribute("USER_TYPE").toString());
		model.addAttribute("memo", map.get("memo"));
				
		return "common/memo/memo_view";
	}
	
	@RequestMapping(value = "comm/memo/memo_form")
	public String memoInfoForm(Memo memo, Model model, HttpSession session){
		
		model.addAttribute("user_type", session.getAttribute("USER_TYPE"));
		model.addAttribute("memo", memo);
		
		return "common/memo/memo_form";
	}
	
	@RequestMapping(value = "comm/memo/memo_form_submit")
	public String memoInfoFormSubmit(Memo memo, Model model, HttpSession session){

		String msg = "";
		boolean bModEnable = false;

		System.out.println("memo:["+memo.getMessage()+"]");
		System.out.println("to_user:["+memo.getTo_user_no()+"]["+memo.getTo_user_name()+"]");

		// 권한 체크 //////
		bModEnable = getAuthCheck(session);
		///////////////////
		
		if(bModEnable){
			try {
				UserInfo userInfo = getUserInfo(session);
				
				memo.setUniv_cd(session.getAttribute("UNIV_CD").toString());
				
				memo.setFrom_user_no(userInfo.getUser_no());
				memo.setFrom_user_name(userInfo.getUser_name());

				memoService.insertMemoInfo(memo);
				msg="정상 처리되었습니다.";
			} catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}			
		} else {
			msg = "등록권한이 없습니다.";
		}
			
		model.addAttribute("message", msg);
		return "msg";
	}
	
	@RequestMapping(value = "comm/memo/memo_delete")
	public String memoInfoDelete(Memo memo, Model model, HttpSession session){
	  
		String msg = "";
		boolean bModEnable = false;
		
		// 권한 체크 //////
		bModEnable = getAuthCheck(session);
		///////////////////
		
		if(bModEnable) {
			memo.setUniv_cd(session.getAttribute("UNIV_CD").toString());
	    
			try {
				memoService.deleteMemoInfo(memo);
				msg="정상 처리되었습니다.";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		} else {
			msg = "권한이 없습니다.";
		}
		
		model.addAttribute("message", msg);
		return "msg";
	}

	@RequestMapping(value = {"comm/memo/prof_list"}, method = RequestMethod.GET)
	public String memoProfList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
								@RequestParam(value="item", defaultValue="") String searchItem,
							    @RequestParam(value="value", defaultValue="") String searchValue,
							    Model model, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(currentPage == null) currentPage = 1;
		
		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("currentPage", currentPage);
		
		map.put("item", searchItem);
		map.put("searchValue", searchValue);
		map.put("coll_cd", "");
		map.put("dept_cd", "");
		
		model.addAttribute(adminProfService.getProfList(map));
				
		return "common/memo/popup_prof_list";
	}

	public UserInfo getUserInfo(HttpSession session) {
		
		String user_type = session.getAttribute("USER_TYPE").toString();
		UserInfo userInfo = new UserInfo();
		
		if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]")) {
			Admin admin = (Admin)session.getAttribute("ADMIN_INFO");
			
			userInfo.setUser_no(admin.getAdmin_no());
			userInfo.setUser_name(admin.getAdmin_name());
		} else if(user_type.equals("[ROLE_PROF]")) {
			Prof prof = (Prof)session.getAttribute("PROF_INFO");
			
			userInfo.setUser_no(prof.getProf_no());
			userInfo.setUser_name(prof.getProf_name());
		} else if(user_type.equals("[ROLE_STUDENT]")) {
			Student student = (Student)session.getAttribute("STUDENT_INFO");
			
			userInfo.setUser_no(student.getStudent_no());
			userInfo.setUser_name(student.getStudent_name());
		}
	
		System.out.println("user_type:["+user_type+"],user_no:["+userInfo.getUser_no()+"]["+userInfo.getUser_name()+"]");		
		
		return userInfo;
	}
	
	public boolean getAuthCheck(HttpSession session) {
		
		String user_type = session.getAttribute("USER_TYPE").toString();
		boolean bAuth = false;
		
		if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]") || user_type.equals("[ROLE_PROF]")){
			bAuth = true;
		}
		
		System.out.println("bAuth:["+bAuth+"]");		
	
		return bAuth;
	}	
}
