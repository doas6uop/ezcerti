package com.icerti.ezcerti.admin.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.admin.dao.AdminInfoMapper;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Classroom;
import com.icerti.ezcerti.domain.Coll;
import com.icerti.ezcerti.domain.Dept;
import com.icerti.ezcerti.domain.Gonggyul;
import com.icerti.ezcerti.domain.ClassoffManage;
import com.icerti.ezcerti.domain.GonggyulSubject;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.scheduler.dao.ScheduleMapper;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Transactional
@Service
public class AdminInfoServiceImpl implements AdminInfoService{
	
	@Autowired
	private AdminInfoMapper adminInfoMapper = null;

	@Override
	public PageBean<Admin> getAdminList(Map<String, Object> map) {
		PageBean<Admin> pageBean = new PageBean<Admin>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		
		int allCnt = adminInfoMapper.getAdminListCount(map);
				
		int cntPerPage = PageBean.CNT_PER_PAGE;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminInfoMapper.getAdminList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	@Override
	public Map<String, Object> getAdminView(Map<String, Object> map) {
		
		Admin admin = adminInfoMapper.getAdminView(map);
		
		if(admin.getColl_cd()==null){
			admin.setColl_cd("");
		}
		map.put("coll_cd", admin.getColl_cd());
		
		System.out.println("admin_level:["+admin.getAdmin_level_cd()+"]["+admin.getAdmin_name()+"]");
		
		
		map.put("admin", admin);
		// 2015.01.08 //////////////////////////////
		// - 사용하지 않아서 주석 처리
		//map.put("collList", adminInfoMapper.getCollList(map));
		//map.put("deptList", adminInfoMapper.getDeptList(map));
		////////////////////////////////////////////
		
		return map;
	}
	
	@Override
	public Collection<Coll> getColl(Map<String, Object> map) {
		return adminInfoMapper.getCollList(map);
	}

	@Override
	public Collection<Dept> getDept(Map<String, Object> map) {
		return adminInfoMapper.getDeptList(map);
	}
	
	@Override
	public String getCollName(Map<String, Object> map) {
		return adminInfoMapper.getCollName(map);
	}
	
	@Override
	public String getDeptName(Map<String, Object> map) {
		return adminInfoMapper.getDeptName(map);
	}

	@Override
	public void updateAdminInfo(Admin admin) {
	  if(!admin.getAdmin_passwd().equals("")){
	    PasswordEncoder encoder = new ShaPasswordEncoder(256);
	    admin.setAdmin_passwd(encoder.encodePassword(admin.getAdmin_passwd(), null));
	  }
		adminInfoMapper.updateAdminInfo(admin);
	}

	@Override
	public void deleteAdminInfo(Admin admin) {
		adminInfoMapper.deleteAdminInfo(admin);
		// 2015.01.09 /////////////////
		// - 학사정보에 관리자 삭제 처리
		//	 : 학사정보에서 별도로 관리자 정보를 관리하지 않으면 주석 처리
		adminInfoMapper.deleteAdminInfoToInternal(admin);
		///////////////////////////////	 		
	}

	@Override
	public void insertAdminInfo(Admin admin) {
	  if(!admin.getAdmin_passwd().equals("")){
		PasswordEncoder encoder = new ShaPasswordEncoder(256);
		admin.setAdmin_passwd(encoder.encodePassword(admin.getAdmin_passwd(), null));
	  }
		adminInfoMapper.insertAdminInfo(admin);
		// 2015.01.09 /////////////////
		// - 학사정보에 관리자 등록 처리
		//	 : 학사정보에서 별도로 관리자 정보를 관리하지 않으면 주석 처리
		adminInfoMapper.insertAdminInfoToInternal(admin);
		///////////////////////////////	 
	}

	@Override
	public int getAdminChk(Map<String, Object> map) {
		return adminInfoMapper.getAdminChk(map);
	}

	/* 강의실관리 > 강의실예약시간목록 */
	@Override
	public PageBean<Classroom> getClassroomReservedList(Map<String, Object> map) {
		PageBean<Classroom> pageBean = new PageBean<Classroom>();
		
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");
		
		int allCnt = adminInfoMapper.getClassroomReservedListCount(map);
		
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
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
		
		pageBean.setList(adminInfoMapper.getClassroomReservedList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}	
	
	/* 강의실 관리 > 강의실예약시간 추가 */
	@Override
	public void insertClassroomReserveInfo(Map<String, Object> map) {
		adminInfoMapper.insertClassroomReserveInfo(map);
	}
	
	/* 강의실 관리 > 강의실예약시간 삭제 */
	@Override
	public void deleteClassroomReserveInfo(Map<String, Object> map) {
		adminInfoMapper.deleteClassroomReserveInfo(map);
	}	
	
	/* 정보관리 > 공결관리 리스트 */
	@Override
	public PageBean<Gonggyul> getGonggyulList(Map<String, Object> map) {
		
		// 페이징 관련 처리
		PageBean<Gonggyul> pageBean = new PageBean<Gonggyul>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");
		
		// 전체 리스트 cnt
		int allCnt = adminInfoMapper.getGonggyulListCount(map);
		
		// 검색 로우 계산 x번째 ~ x번째 까지
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		
		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
				
		int cntPerPage = PageBean.CNT_PER_PAGE; // 한 페이지에 보여줄 목록 수
		
		// start ~ end page 계산
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP); // 한 페이지에 보여줄 페이지 수
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP); // 한 페이지에 보여줄 페이지 수
		
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage); // 전체 페이지
		
		// 마지막 페이지가 전체 페이지보다 크게 되면 마지막페이지를 전체 페이지로 변경
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminInfoMapper.getGonggyulList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}

	/* 정보관리 > 공결중복검사 */
	public boolean duplicationGonggyul(Gonggyul gonggyul) {
		
		int flagCnt = 0;
		
		String strStudentNo = gonggyul.getStudent_no();
		String[] arrStudentNo = null;
		
		if(strStudentNo != null) {
			System.out.println("strStudentNo != null");
			
			arrStudentNo = strStudentNo.split(",");
		} else {
			System.out.println("strStudentNo == null");			
		}
		
		if(arrStudentNo != null && arrStudentNo.length > 0) {
			
			for(int i = 0; i < arrStudentNo.length; i++) {
				
				gonggyul.setStudent_no(arrStudentNo[i]);
				
				flagCnt = adminInfoMapper.duplicationGonggyul(gonggyul);
				
				if(flagCnt != 0){ // 중복일 경우
					break;
				}
			}
		}
		
		if(flagCnt == 0){ // 중복되지 않을때
			return true;
		} else {
			return false;
		}
	}
	
	/* 정보관리 > 공결등록 */
	@Override
	public void gonggyulInsertOk(Gonggyul gonggyul) {
		
		// 공결 테이블 insert
		adminInfoMapper.gonggyulInsertOk(gonggyul);
		
		// 공결 테이블 idx 조회
		String gonggyulNo = adminInfoMapper.getGonggyulNo(gonggyul);
		gonggyul.setGonggyul_no(gonggyulNo);
		
		// 선택된 공결처리 강의정보 
		String [] arrChkClassCd = gonggyul.getChk_classname();
		
		for(int i = 0; i < arrChkClassCd.length; i++) {
			
			String [] arrSubjectinfo = arrChkClassCd[i].split("\\_");

			gonggyul.setTmp_class_cd(arrSubjectinfo[0]);
			gonggyul.setClasshour_start_time(arrSubjectinfo[1]);
			
			// 공결 참조 테이블 insert
			adminInfoMapper.gonggyulSubjectInsertOk(gonggyul);
		}
	}

	@Override
	public Collection<Gonggyul> getGonggyulClassnameList(Map<String, Object> map) {
		return adminInfoMapper.getGonggyulClassnameList(map);
	}
	
	/* 정보관리 > 공결 상세보기 */
	@Override
	public Gonggyul gonggyulView(String gonggyul_no) {
		return adminInfoMapper.gonggyulView(gonggyul_no);
	}
	
	/* 정보관리 > 공결수정 */
	@Override
	public void gonggyulModifyOk(Gonggyul gonggyul) {
		
		/*
		 *  수정 기능 수행시 관련 작업 20160913
		 *  
		 *  - gonggyul_no를 통한 수정 대상 데이터 조회
		 *  - 수정대상 데이터 초기화 (CHUL_TB_ATTENDDEHIST)
		 *  
		 *  - 공결 테이블 수정 
		 *  - 공결 참조 테이블 삭제 (선택된 gonggyul_no 데이터)
		 *  - 공결 참조 테이블 insert (선택된 class_cd에 따른 데이터)
		 *  
		 *  - 변경된 데이터를 참조하여 프로시저 수행
		 *  
		 */
		
		// DB에 저장된 공결데이터 조회 CHUL_TB_ATTENDDEHIST (공결테이블과 조인하여 공결대상학생 데이터 조회)
		ArrayList<Gonggyul> gonggyulArr = adminInfoMapper.getSavedGonggyulDataList(gonggyul);
		
		// 조회된 모든 사람 출결전 상태로 변경 
		for(int i = 0; i < gonggyulArr.size(); i++) {
			// 공결 데이터 초기화
			adminInfoMapper.getSavedGonggyulInit(gonggyulArr.get(i));
		}
		
		// 공결 테이블 update
		adminInfoMapper.gonggyulModifyOk(gonggyul);
		
		// 공결 참조 테이블 해당 idx 데이터 전체 삭제
		adminInfoMapper.gonggyulSubjectAllDeleteOk(gonggyul);
		
		// 선택된 공결데이터 insert 수행
		String [] arrChkClassCd = gonggyul.getChk_classname();
		
		for(int i = 0; i < arrChkClassCd.length; i++) {
			
			String [] arrSubjectinfo = arrChkClassCd[i].split("\\_");

			gonggyul.setTmp_class_cd(arrSubjectinfo[0]);
			gonggyul.setClasshour_start_time(arrSubjectinfo[1]);
			
			//gonggyul.setTmp_class_cd(arrChkClassCd[i]);
			
			// 공결 참조 테이블 insert
			adminInfoMapper.gonggyulSubjectInsertOk(gonggyul);
		}
		
		// 변경된 공결 정보에 따른 공결 데이터 생성
		adminInfoMapper.gonggyulProc(gonggyul);
	}

	/* 정보관리 > 공결삭제 */
	@Override
	public void gonggyulDelete(String chk_no) {
		
		/*
		 *  삭제 기능 수행시 관련 작업 20160912
		 *  
		 *  - 선택된 chk_no(gonggyul_no) 번호에 따른 삭제 데이터 조회
		 *  - 선택된 chk_no(gonggyul_no) 번호의 모든 공결 데이터 초기화
		 *  
		 *  - 공결 테이블 삭제 처리 (gonggyul_no)
		 *  - 공결 참조테이블 삭제 처리 (gonggyul_no)
		 *  
		 */
		
		String[] arrGonggyulNo = null;
		Gonggyul gonggyul = new Gonggyul();
		ArrayList<Gonggyul> gonggyulArr = null;
		
		if(chk_no != null) {
			System.out.println("chk_no != null");
			
			arrGonggyulNo = chk_no.split(",");
		} else {
			System.out.println("chk_no == null");			
		}
		
		if(arrGonggyulNo != null && arrGonggyulNo.length > 0) {
			
			for(int i = 0; i < arrGonggyulNo.length; i++) {
				
				gonggyul.setGonggyul_no(arrGonggyulNo[i]);
				
				// DB에 저장된 공결데이터 조회 CHUL_TB_ATTENDDEHIST (변경 혹은 삭제 처리 예정인 데이터)
				gonggyulArr = adminInfoMapper.getSavedGonggyulDataList(gonggyul);
				
				// 조회된 모든 사람 출결전 상태로 변경 
				for(int j = 0; j < gonggyulArr.size(); j++) {
					// 공결 데이터 초기화
					adminInfoMapper.getSavedGonggyulInit(gonggyulArr.get(j));
				}
				
				// 공결 메인 테이블 삭제처리 (visible 변경)
				adminInfoMapper.gonggyulDelete(arrGonggyulNo[i]);
				
				// 공결 참조 테이블 해당 idx 데이터 전체 삭제
				adminInfoMapper.gonggyulSubjectAllDeleteOk(gonggyul);
			}
		}
	}

	/* 정보관리 > 일괄휴강관리 리스트 */
	@Override
	public PageBean<ClassoffManage> getClassoffManageList(Map<String, Object> map) {
		
		// 페이징 관련 처리
		PageBean<ClassoffManage> pageBean = new PageBean<ClassoffManage>();
		Integer currentPage = (Integer) map.get("currentPage");
		String type = (String) map.get("type");
		
		// 전체 리스트 cnt
		int allCnt = adminInfoMapper.getClassoffManageListCount(map);
		
		// 검색 로우 계산 x번째 ~ x번째 까지
		map.put("startRow", PageUtil.getStartRow(currentPage, PageBean.CNT_PER_PAGE));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));
		}
				
		int cntPerPage = PageBean.CNT_PER_PAGE; // 한 페이지에 보여줄 목록 수
		
		// start ~ end page 계산
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP); // 한 페이지에 보여줄 페이지 수
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP); // 한 페이지에 보여줄 페이지 수
		
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage); // 전체 페이지
		
		// 마지막 페이지가 전체 페이지보다 크게 되면 마지막페이지를 전체 페이지로 변경
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		pageBean.setList(adminInfoMapper.getClassoffManageList(map));
		
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);
		
		return pageBean;
	}
	
	/* 정보관리 > 일괄휴강관리 중복검사 */
	@Override
	public boolean duplicationClassoffManage(ClassoffManage classoffManage) {
		
		int flagCnt = 0;
		
		flagCnt = adminInfoMapper.duplicationClassoffManage(classoffManage);
		
		if(flagCnt == 0){ // 중복되지 않을때
			return true;
		} else {
			return false;
		}
	}

	/* 정보관리 > 일괄휴강관리 등록 */
	@Override
	public void classoffManageInsertOk(ClassoffManage classoffManage) {
		adminInfoMapper.classoffManageInsertOk(classoffManage);
	}
	
	/* 정보관리 > 일괄휴강관리 상세보기 */
	@Override
	public ClassoffManage classoffManageView(String classoffmanage_no) {
		return adminInfoMapper.classoffManageView(classoffmanage_no);
	}

	/* 정보관리 > 일괄휴강관리 수정 */
	@Override
	public void classoffManageModifyOk(ClassoffManage classoffManage) {
		adminInfoMapper.classoffManageModifyOk(classoffManage);
	}

	/* 정보관리 > 일괄휴강관리 삭제 */
	@Override
	public void classoffManageDelete(String chk_no) {
	
		String[] arrGonggyulNo = null;
		
		if(chk_no != null) {
			System.out.println("chk_no != null");
			
			arrGonggyulNo = chk_no.split(",");
		} else {
			System.out.println("chk_no == null");			
		}
		
		if(arrGonggyulNo != null && arrGonggyulNo.length > 0) {
			
			for(int i = 0; i < arrGonggyulNo.length; i++) {
				
				adminInfoMapper.classoffManageDelete(arrGonggyulNo[i]);
			}
		}
	}
	
	/* 정보관리 > 일괄휴강관리 프로시저 수행 */
	@Override
	public void classoffManagePerform(String chk_no) {
		
		// 전체 수행일 경우 ////////////
		// 프로시저 수행
		//adminInfoMapper.classoffManagePerform(chk_no);
		
		// 수행 flag 변경
		//adminInfoMapper.classoffManagePerformUpdateFlag();
		//////////////////////////
		
		String[] arrNo = null;
		
		if(chk_no != null) {
			arrNo = chk_no.split(",");
		}
		
		if(arrNo != null && arrNo.length > 0) {
			for(int i = 0; i < arrNo.length; i++) {
				adminInfoMapper.classoffManagePerform(arrNo[i]);
			}
		}
	}

	/* 학기관리 주차갯수 조회 */
	@Override
	public List< Map<String, Object>> univYearGetDayOfWeekCnt(Univ univ) {
		return adminInfoMapper.univYearGetDayOfWeekCnt(univ);
	}

	/* 학기관리 등록 */
	@Override
	public void univYearInsertOk(Univ univ) {
		adminInfoMapper.univYearInsertOk(univ);
	}

	/* 학기관리 상세보기 */
	@Override
	public Univ univYearView(Map<String, Object> map) {
		return adminInfoMapper.univYearView(map);
	}

	/* 학기관리 수정 */
	@Override
	public void univYearModifyOk(Univ univ) {
		adminInfoMapper.univYearModifyOk(univ);
	}

	@Override
	public void univYearStscd(Univ univ) {
		adminInfoMapper.univYearStscd(univ);
	}

	@Override
	public void univYearDeleteOkUnivTerm(Map<String, Object> map) {
		adminInfoMapper.univYearDeleteOkUnivTerm(map);
	}

	@Override
	public void univYearDeleteOkClassday(Map<String, Object> map) {
		adminInfoMapper.univYearDeleteOkClassday(map);
	}

	@Override
	public void createClassday(Univ univ) {
		adminInfoMapper.createClassday(univ);
	}
}
