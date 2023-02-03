package com.icerti.ezcerti.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icerti.ezcerti.admin.dao.AdminStandMapper;
import com.icerti.ezcerti.domain.Log;
import com.icerti.ezcerti.util.CommonUtil;
import com.icerti.ezcerti.util.PageBean;
import com.icerti.ezcerti.util.PageUtil;

@Service
public class AdminStandServiceImpl implements AdminStandService{

	@Autowired
	private AdminStandMapper adminStandMapper = null;

	@Autowired
	private CommonUtil commonUtil;

	@Override
	public int getAdminStandCodeCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCodeCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandCode(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCode(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandDetailCode(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailCode(map);
	}

	@Override
	public int getAdminStandProfCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandProfCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandProf(Map<String, Object> map) {
		return adminStandMapper.getAdminStandProf(map);
	}

	@Override
	public int getAdminStandStudentCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandStudentCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandStudent(Map<String, Object> map) {
		return adminStandMapper.getAdminStandStudent(map);
	}

	@Override
	public int getAdminStandYearCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandYearCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandYear(Map<String, Object> map) {
		return adminStandMapper.getAdminStandYear(map);
	}

	@Override
	public int getAdminStandClassdayCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClassdayCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandClassday(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClassday(map);
	}

	@Override
	public int getAdminStandOrganizationCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandOrganizationCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandOrganization(Map<String, Object> map) {
		return adminStandMapper.getAdminStandOrganization(map);
	}

	@Override
	public int getAdminStandDetailOrganizationCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailOrganizationCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandDetailOrganization(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailOrganization(map);
	}

	@Override
	public int getAdminStandClasshourCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClasshourCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandClasshour(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClasshour(map);
	}

	@Override
	public int getAdminStandClassroomCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClassroomCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandClassroom(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClassroom(map);
	}

	@Override
	public int getAdminStandDetailClassroomCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailClassroomCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandDetailClassroom(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailClassroom(map);
	}

	@Override
	public int getAdminStandSubjectCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandSubjectCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandSubject(Map<String, Object> map) {
		return adminStandMapper.getAdminStandSubject(map);
	}

	@Override
	public int getAdminStandClassCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClassCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandClass(Map<String, Object> map) {
		return adminStandMapper.getAdminStandClass(map);
	}

	@Override
	public int getAdminStandAddinfoCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandAddinfoCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandAddinfo(Map<String, Object> map) {
		return adminStandMapper.getAdminStandAddinfo(map);
	}

	@Override
	public int getAdminStandDetailAddinfoCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailAddinfoCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandDetailAddinfo(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailAddinfo(map);
	}

	@Override
	public int getAdminStandAttendeeCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandAttendeeCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandAttendee(Map<String, Object> map) {
		return adminStandMapper.getAdminStandAttendee(map);
	}

	@Override
	public int getAdminStandDetailAttendeeCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailAttendeeCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandDetailAttendee(Map<String, Object> map) {
		return adminStandMapper.getAdminStandDetailAttendee(map);
	}

	@Override
	public int getAdminStandTargetViewChkCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetViewChkCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandTargetViewChk(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetViewChk(map);
	}

	@Override
	public int getAdminStandTargetViewSelectCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetViewSelectCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandTargetViewSelect(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetViewSelect(map);
	}

	@Override
	public int getAdminStandTargetViewCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetViewCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandTargetView(Map<String, Object> map) {
		return adminStandMapper.getAdminStandTargetView(map);
	}

	@Override
	public int getAdminStandCopyDataCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCopyDataCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandCopyData(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCopyData(map);
	}

	@Override
	public int getAdminStandSyncDataCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandSyncDataCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandSyncData(Map<String, Object> map) {
		return adminStandMapper.getAdminStandSyncData(map);
	}

	@Override
	public int initSyncData(String param) {
		return adminStandMapper.initSyncData(param);
	}

	@Override
	public int backSyncData(Map<String, Object> map) {
		return adminStandMapper.backSyncData(map);
	}

	@Override
	public int getAdminStandCheckedDataCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCheckedDataCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandCheckedData(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCheckedData(map);
	}

	@Override
	public int getAdminStandCloseCheckProfCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCloseCheckProfCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandCloseCheckProf(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCloseCheckProf(map);
	}

	@Override
	public int getAdminStandCloseCheckClassCount(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCloseCheckClassCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminStandCloseCheckClass(Map<String, Object> map) {
		return adminStandMapper.getAdminStandCloseCheckClass(map);
	}

	@Override
	public int executeCloseDataChangeProf(Map<String, Object> map) {
		return adminStandMapper.executeCloseDataChangeProf(map);
	}

	@Override
	public int executeCloseDataChangeClass(Map<String, Object> map) {
		return adminStandMapper.executeCloseDataChangeClass(map);
	}

	@Override
	public PageBean<Log> getLogList(Map<String, Object> map) {
		PageBean<Log> pageBean = new PageBean<Log>();
		Integer currentPage = (Integer) map.get("currentPage");

		int temPage = commonUtil.getCntPerPage();

		String type = (String) map.get("type");

		int allCnt = adminStandMapper.getLogListCount(map);

		map.put("startRow", PageUtil.getStartRow(currentPage, temPage));
		//map.put("endRow", PageUtil.getEndRow(currentPage, PageBean.CNT_PER_PAGE));

		// Excel 로 다운로드시 전체 내용 조회
		if(type != null && type.equals("EXCEL")) {
			map.put("endRow", PageUtil.getEndRow(currentPage, allCnt));
		} else {
			map.put("endRow", PageUtil.getEndRow(currentPage, temPage));
		}

		int cntPerPage = temPage;
		int startPage = PageUtil.getStartPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int endPage = PageUtil.getEndPage(currentPage, PageBean.CNT_PER_PAGE_GROUP);
		int totalPage = (int)Math.ceil((double)allCnt / cntPerPage);
		if(endPage > totalPage){
			endPage = totalPage;
		}

		pageBean.setList(adminStandMapper.getLogList(map));
		pageBean.setAllCnt(allCnt);
		pageBean.setStartPage(startPage);
		pageBean.setEndPage(endPage);
		pageBean.setTotalPage(totalPage);
		pageBean.setCurrentPage(currentPage);

		return pageBean;
	}

	@Override
	public int getAdminTermEndManageCount(Map<String, Object> map) {
		return adminStandMapper.getAdminTermEndManageCount(map);
	}

	@Override
	public List<Map<String, Object>> getAdminTermEndManage(Map<String, Object> map) {
		return adminStandMapper.getAdminTermEndManage(map);
	}

	@Override
	public void executeEndProcAll() {
		adminStandMapper.executeEndProcAll();
	}

	@Override
	public void executeEndProcPart(Map<String, Object> map) {
		adminStandMapper.executeEndProcPart(map);
	}
	
	@Override
	public List<Map<String, Object>> getTransmitDataExcel(Map<String, Object> map) {
		return adminStandMapper.getTransmitDataExcel(map);
	}
}
