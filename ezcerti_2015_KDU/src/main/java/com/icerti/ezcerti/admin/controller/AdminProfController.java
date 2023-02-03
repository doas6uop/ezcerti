package com.icerti.ezcerti.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.service.AdminProfService;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.UserInfo;
import com.icerti.ezcerti.prof.dao.ProfStatsMapper;
import com.icerti.ezcerti.prof.service.ProfClassService;
import com.icerti.ezcerti.prof.service.ProfInfoService;
import com.icerti.ezcerti.prof.service.ProfMypageService;

@Controller
public class AdminProfController {

	@Autowired
	private CommonMapper commonMapper = null;

	@Autowired
	private AdminProfService adminProfService = null;

	@Autowired
	private ProfMypageService profMypageService = null;

	@Autowired
	private CommonService commonService = null;

	@Autowired
	private ProfInfoService profInfoService = null;
	
	@Autowired
	private ProfStatsMapper profStatsMapper = null;	

	@RequestMapping(value = {"muniv/prof/prof_list", "m/admin/prof/prof_list"}, method = RequestMethod.GET)
	public String adminProfList(@RequestParam(value="currentPage", defaultValue="1") Integer currentPage,
			String item,
			@RequestParam(value="value", defaultValue="") String searchValue, 
			@RequestParam(value="coll_cd", defaultValue="") String coll_cd,
			@RequestParam(value="dept_cd", defaultValue="") String dept_cd,
			Model model, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();

		if(currentPage == null) currentPage = 1;

		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.13 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("coll_cd", coll_cd);
		map.put("dept_cd", dept_cd);
		map.put("currentPage", currentPage);

		map.put("item", item);
		map.put("searchValue", searchValue);
		map.put("collList", commonService.getColl(map));
		map.put("prof_status", "");

		model.addAttribute("coll_cd", coll_cd);
		model.addAttribute("dept_cd", dept_cd);
		model.addAttribute(adminProfService.getProfList(map));
		model.addAttribute(map.get("collList"));

		return "admin/prof/prof_list";
	}

	@RequestMapping(value = "muniv/prof/prof_view", method = RequestMethod.GET)
	public String adminProfView(@RequestParam(value="prof_no") String prof_no,
			Model model, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();
		Prof prof = new Prof();

		map.put("univ_cd", session.getAttribute("UNIV_CD").toString());
		// 2015.01.07 //////////////////////////////
		// - 년도 조건 추가
		map.put("year", session.getAttribute("YEAR").toString());
		////////////////////////////////////////////
		map.put("term_cd", session.getAttribute("TERM_CD").toString());
		map.put("prof_no", prof_no);

		prof.setUniv_cd(map.get("univ_cd").toString());
		prof.setTerm_cd(map.get("term_cd").toString());
		prof.setProf_no(prof_no);


		map.put("prof", commonService.getProfInfo(prof));
		map.put("lectureList", profMypageService.getLectureList(map));

		model.addAttribute("prof", map.get("prof"));      
		model.addAttribute("lectureList", map.get("lectureList"));      

		return "admin/prof/prof_view";
	}

	@RequestMapping(value = "muniv/prof/prof_edit", method = RequestMethod.GET)
	public String adminProfEdit(@RequestParam(value="prof_no") String prof_no,
			Model model, HttpSession session){
		Prof prof = new Prof();
		prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		prof.setTerm_cd(session.getAttribute("TERM_CD").toString());
		prof.setProf_no(prof_no);
		prof = commonService.getProfInfo(prof);

		model.addAttribute("prof", prof);
		return "admin/prof/prof_edit";
	}

	@RequestMapping(value = "muniv/prof/prof_edit_confirm", method = RequestMethod.POST)
	public String adminProfEditConfirm(Prof prof, Model model, HttpSession session){
		String msg = "";
		prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
		msg = profInfoService.updateProfInfo(prof);
		model.addAttribute("message", msg);
		return "msg";
	}

	@RequestMapping(value = "muniv/prof/prof_resetpassword", method = RequestMethod.POST)
	public String adminProfResetPassword(Prof prof, Model model, HttpSession session){

		String lost_id = prof.getProf_no();
		String lost_name = prof.getProf_name();
		String lost_email = prof.getEmail_addr();
		System.out.println(prof.toString());

		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "";
		map.put("lost_type", "prof");
		map.put("lost_id", lost_id);
		map.put("lost_name", lost_name);
		map.put("lost_email", lost_email);

		msg = commonService.passwordLost(map);
		model.addAttribute("message", msg);

		return "msg";
	}

	@RequestMapping(value = "muniv/prof/prof_initpassword", method = RequestMethod.POST)
	public String adminProfInitPassword(Prof prof, Model model, HttpSession session){

		String userId = "";
		String userPwd = "";
		String msg = "";
		UserInfo user = new UserInfo();

		if(prof != null && prof.getProf_no() != null && prof.getProf_no().length() > 0) {

			userId = prof.getProf_no();

			PasswordEncoder encoder = new ShaPasswordEncoder(256);
			userPwd = encoder.encodePassword(userId, null);

			user.setUser_no(userId);
			user.setUser_passwd(userPwd);

			commonMapper.updateUserPassword(user);

			msg = "비밀번호가 초기화되었습니다.";
		} else {
			msg = "오류가 발생했습니다.";
		}

		model.addAttribute("message", msg);

		return "msg";
	}	
 	
	@RequestMapping(value = "muniv/prof/prof_initTermEnd", method = RequestMethod.POST)
	public String adminProfInitTermEnd(Prof prof, Model model, HttpSession session){

		String userId = "";
		String msg = "";
		UserInfo user = new UserInfo();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(prof != null && prof.getProf_no() != null && prof.getProf_no().length() > 0) {
			map.put("univ_cd", session.getAttribute("UNIV_CD"));
			map.put("year", session.getAttribute("YEAR"));
			map.put("term_cd", session.getAttribute("TERM_CD"));
			map.put("prof_no", prof.getProf_no());
			map.put("prof_adm_cd", prof.getProf_adm_cd());
			
			int resultProf = profStatsMapper.updateProfStatsTermEnd(map);
			if(resultProf==0){
				msg = "오류가 발생했습니다.";
			}else if(resultProf == 1){
				msg = "정상처리되었습니다.";
				profStatsMapper.updateProfStatsTermEndClass(map);			
			}
		} else {
			msg = "오류가 발생했습니다.";
		}

		model.addAttribute("message", msg);

		return "msg";
	}		
}
