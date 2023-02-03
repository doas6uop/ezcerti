package com.icerti.ezcerti.admin.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.admin.service.AdminStandService;
import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.util.CommonUtil;
import com.icerti.ezcerti.util.PageUtil;

@Controller
public class AdminClassManageController {

	private static final Logger logger = LoggerFactory.getLogger(AdminClassManageController.class);

	@Value("#{config['univ_code']}")
	String globalUnivCode;

	@Autowired
	private CommonMapper commonMapper = null;

	@Autowired
	private CommonUtil commonUtil;

	@Autowired
	private AdminStandService adminStandService = null;

	public Map<String, Object> getActivityTerm() {
		// 학교정보 조회 /////////////////
		Map<String, Object> map = null;
		Univ objUniv = new Univ();

	    objUniv.setUniv_cd(globalUnivCode);
	    objUniv.setUniv_sts_cd("G004C001");

	    objUniv = commonMapper.getActivityTerm(objUniv);

		if(objUniv != null) {
			map = new HashMap<String, Object>();

			map.put("univ_cd", objUniv.getUniv_cd());
			map.put("year", objUniv.getYear());
			map.put("term_cd", objUniv.getTerm_cd());
			map.put("term_name", objUniv.getTerm_name());
			map.put("targetParam", String.format("%s%s%s", objUniv.getUniv_cd(), objUniv.getYear(), objUniv.getTerm_cd()));

			if(objUniv.getTerm_cd().equalsIgnoreCase("G002C001")) {
				map.put("univ_term_cd", "1");
			} else if(objUniv.getTerm_cd().equalsIgnoreCase("G002C002")) {
				map.put("univ_term_cd", "2");
			} else if(objUniv.getTerm_cd().equalsIgnoreCase("G002C003")) {
				map.put("univ_term_cd", "3");
			} else if(objUniv.getTerm_cd().equalsIgnoreCase("G002C004")) {
				map.put("univ_term_cd", "4");
			}
		}

		return map;
	}

	/* 권한체크 */
	public boolean getAuthCheck(HttpSession session) {

		String user_type = session.getAttribute("USER_TYPE").toString();
		boolean bAuth = false;

		if(user_type.equals("[ROLE_SYSTEM]") || user_type.equals("[ROLE_ADMIN]")){
			bAuth = true;
		}

		// System.out.println("bAuth:["+bAuth+"]");
		return bAuth;
	}

	// 학기생성 팝업
	@RequestMapping(value = "muniv/class_manage/create_class_data_pop")
	public String adminCreateClassDataPop(Model model, HttpServletRequest request, HttpServletResponse response,
											HttpSession session){
		return "admin/class_manage/create_class_data_pop";
	}

	// 신규학기생성(탭1)
	// 연도학기관리조회
	@RequestMapping(value = "muniv/class_manage/class_manage_univ_term_list")
	public void adminClassManageUnivTermList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("univ_cd", globalUnivCode);
		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandYearCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandYear(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭1)
	// 강의일자관리조회
	@RequestMapping(value = "muniv/class_manage/class_manage_classday_list", method = RequestMethod.POST)
	public void adminClassManageClassdayList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session){

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandClassdayCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandClassday(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭2)
	// 학교뷰데이터조회
	@RequestMapping(value = "muniv/class_manage/class_manage_target_view_chk_list", method = RequestMethod.POST)
	public void adminClassManageTargetViewChkList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = getActivityTerm();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt;
		List<Map<String, Object>> datas;

		totalCnt = adminStandService.getAdminStandTargetViewChkCount(map);
		datas = adminStandService.getAdminStandTargetViewChk(map);

/*
		if(!commonUtil.checkProcedureUse()) {
			totalCnt = syncOtherDSMapper.getAdminStandTargetViewChkCount(map);
			datas = syncOtherDSMapper.getAdminStandTargetViewChk(map);
		} else {
			totalCnt = adminStandService.getAdminStandTargetViewChkCount(map);
			datas = adminStandService.getAdminStandTargetViewChk(map);
		}
*/

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭2)
	// 학교뷰데이터조회(선택데이터)
	@RequestMapping(value = "muniv/class_manage/class_manage_target_view_select_list", method = RequestMethod.POST)
	public void adminClassManageTargetViewSelectList(@RequestParam(value="tbl", defaultValue="") String tbl,
												Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = getActivityTerm();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("tbl", tbl);

		int totalCnt;
		List<Map<String, Object>> datas;

		totalCnt = adminStandService.getAdminStandTargetViewSelectCount(map);
		datas = adminStandService.getAdminStandTargetViewSelect(map);

/*
		if(!commonUtil.checkProcedureUse()) {
			totalCnt = syncOtherDSMapper.getAdminStandTargetViewSelectCount(map);
			datas = syncOtherDSMapper.getAdminStandTargetViewSelect(map);
		} else {
			totalCnt = adminStandService.getAdminStandTargetViewSelectCount(map);
			datas = adminStandService.getAdminStandTargetViewSelect(map);
		}
*/

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭3)
	// 학교뷰데이터조회
	@RequestMapping(value = "muniv/class_manage/class_manage_target_view_list", method = RequestMethod.POST)
	public void adminClassManageTargetViewList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = getActivityTerm();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt;
		List<Map<String, Object>> datas;

		totalCnt = adminStandService.getAdminStandTargetViewCount(map);
		datas = adminStandService.getAdminStandTargetView(map);

/*
		if(!commonUtil.checkProcedureUse()) {
			totalCnt = syncOtherDSMapper.getAdminStandTargetViewCount(map);
			datas = syncOtherDSMapper.getAdminStandTargetView(map);
		} else {
			totalCnt = adminStandService.getAdminStandTargetViewCount(map);
			datas = adminStandService.getAdminStandTargetView(map);
		}
*/

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭3)
	// 이관테이블조회
	@RequestMapping(value = "muniv/class_manage/class_manage_copy_data_list", method = RequestMethod.POST)
	public void adminClassManageCopyDataList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("univ_cd", session.getAttribute("UNIV_CD"));
		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandCopyDataCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandCopyData(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭3)
	// 출결시스템데이터조회
	@RequestMapping(value = "muniv/class_manage/class_manage_sync_data_list", method = RequestMethod.POST)
	public void adminClassManageSyncDataList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("univ_cd", globalUnivCode);
		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandSyncDataCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandSyncData(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭3)
	// 강의테이블 데이터 초기화
	@RequestMapping(value = "muniv/class_manage/initSyncData", method = RequestMethod.POST)
	public String initSyncData(Model model, HttpServletRequest request,
								HttpServletResponse response, HttpSession session) {

		String msg = "";
		boolean bModEnable = false;

		// 초기화 대상 테이블
		String[] delArr = {"CHUL_TB_ATTENDMASTER_ADDINFO", "CHUL_TB_ATTENDDETHIST"
						   , "CHUL_TB_CLASSOFFMANAGE", "CHUL_TB_CLASSOFF_REQUEST"
						   , "CHUL_TB_ATTEND_APPINFO", "CHUL_TB_IMPROVE"
						   , "CHUL_TB_CLAIM"};

		// 백업 대상 테이블
		String[] backArr = {"CHUL_TB_ATTENDMASTER_ADDINFO", "CHUL_TB_ATTENDDETHIST"
							, "CHUL_TB_CLASSOFFMANAGE", "CHUL_TB_CLASSOFF_REQUEST"};

		// 권한 체크 //////
		bModEnable = getAuthCheck(session);

		if(bModEnable) {

			try {

				Map<String, Object> map = new HashMap<String, Object>();
				String tmpText = "";

				for(int i=0; i < delArr.length; i++) {

					// 초기화 전 백업 처리(백업대상테이블)
					if(Arrays.asList(backArr).contains(delArr[i])) {

						tmpText = delArr[i].replaceAll("CHUL_TB_", "INIT_");
						map.put("mainTable", delArr[i]);
						map.put("targetTable", tmpText);

						adminStandService.backSyncData(map);
					}

					// 싱크관련 테이블 초기화 처리
					adminStandService.initSyncData(delArr[i]);
				}

				msg="success";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		}

		model.addAttribute("message", msg);

		return "msg";
	}

	// 신규학기생성(탭4)
	// 이상강의조회
	@RequestMapping(value = "muniv/class_manage/class_manage_checked_data_list", method = RequestMethod.POST)
	public void adminClassManageCheckedDataList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandCheckedDataCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandCheckedData(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭5)
	// 교수마감상태조회
	@RequestMapping(value = "muniv/class_manage/class_manage_close_check_prof_list", method = RequestMethod.POST)
	public void adminClassManageCloseCheckProfList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandCloseCheckProfCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandCloseCheckProf(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭5)
	// 강의마감상태조회
	@RequestMapping(value = "muniv/class_manage/class_manage_close_check_class_list", method = RequestMethod.POST)
	public void adminClassManageCloseCheckClassList(@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startRow", PageUtil.getStartRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("endRow", PageUtil.getEndRow(Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows"))));
		map.put("searchValue", searchValue);

		int totalCnt = adminStandService.getAdminStandCloseCheckClassCount(map);
		List<Map<String, Object>> datas = adminStandService.getAdminStandCloseCheckClass(map);

		String jSonString = null;
		String total = Integer.toString((int)Math.ceil(totalCnt / Double.parseDouble(request.getParameter("rows"))));
		JSONObject jsonData = new JSONObject();
        jsonData.put("ITEM",  (Object)datas);
        jsonData.put("page", request.getParameter("page"));
        jsonData.put("rowsize", request.getParameter("rows"));
        jsonData.put("total", total);

        jSonString = jsonData.toString();

		try {
			if(jSonString != null){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jSonString);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// 신규학기생성(탭5)
	// 강의테이블 데이터 초기화
	@RequestMapping(value = "muniv/class_manage/executeCloseDataChange", method = RequestMethod.POST)
	public String executeCloseDataChange(@RequestParam(value="type1", defaultValue="") String type1,
									@RequestParam(value="type2", defaultValue="") String type2,
									@RequestParam(value="year", defaultValue="") String year,
									@RequestParam(value="term_cd", defaultValue="") String term_cd,
									Model model, HttpServletRequest request,
									HttpServletResponse response, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();
		String msg = "";
		boolean bModEnable = false;

		map.put("type1", type1);
		map.put("type2", type2);
		map.put("year", year);
		map.put("term_cd", term_cd);

		// 권한 체크 //////
		bModEnable = getAuthCheck(session);

		if(bModEnable) {

			try {

				if(type1.equals("prof")) {

					// 교수 마감 및 해제처리
					adminStandService.executeCloseDataChangeProf(map);

				} else if(type1.equals("class")) {

					// 강의 마감 및 해제처리
					adminStandService.executeCloseDataChangeClass(map);
				}

				msg="success";
			}catch(Exception e){
				msg="오류가 발생했습니다.";
				e.printStackTrace();
			}
		}

		model.addAttribute("message", msg);

		return "msg";
	}

}






