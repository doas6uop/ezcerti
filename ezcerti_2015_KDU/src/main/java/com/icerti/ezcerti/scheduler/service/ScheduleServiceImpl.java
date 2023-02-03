package com.icerti.ezcerti.scheduler.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Univ;
import com.icerti.ezcerti.scheduler.dao.ScheduleMapper;

@Transactional
@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Value("#{config['univ_code']}")
	String globalUnivCode;
	
	@Autowired
	private ScheduleMapper scheduleMapper = null;

	@Autowired
	private CommonMapper commonMapper = null;
	
	// 현재 SYSDATE +18일을 기준으로
	// 등록된 학기 시작일 종료일(+19일)에 속한 학기 정보를 가져온다
	// (종료일은 학기종료 날짜의 새벽에도 동기화 프로시저가 돌아야 하기 때문에 +1을 해준다)
	// 해당 세팅을 통해 학기 시작일 18일 이전에 동기화 프로세스가 동작됨
	public Map<String, Object> getCurrentTerm() {
		// 학교정보 조회 /////////////////
		Map<String, Object> map = null;
		Univ objUniv = new Univ();

	    objUniv.setUniv_cd(globalUnivCode);
	    objUniv.setUniv_sts_cd("G004C001");

	    objUniv = commonMapper.getCurrentTerm(objUniv);

		if(objUniv != null) {
			map = new HashMap<String, Object>();

			map.put("univ_cd", objUniv.getUniv_cd());
			map.put("year", objUniv.getYear());
			map.put("term_cd", objUniv.getTerm_cd());

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
		////////////////////////////

		return map;
	}
	
	@Override
	public void checkClassStatus() {
		scheduleMapper.checkClassStatus();
	}

	@Override
	public void checkConseClassAttend() {
		scheduleMapper.checkConseClassAttend();
	}

	@Override
	public void endedClassAttendeeProc() {
		scheduleMapper.endedClassAttendeeProc();
	}

	@Override
	public void gonghuilProc() {
		scheduleMapper.gonghuilProc();
	}

	@Override
	public void gonggyulProc() {
		scheduleMapper.gonggyulProc();
	}
	
	@Override
	public void syncInitDataProc() {
		scheduleMapper.syncInitDataProc();
	}

	@Override
	public void syncUserInfoProc() {
		scheduleMapper.syncUserInfoProc();
	}
	
	@Override
	public void syncClassInfoProc() {
		scheduleMapper.syncClassInfoProc();
	}	

	@Override
	public void syncHyuBogangInfoProc() {
		scheduleMapper.syncHyuBogangInfoProc();
	}

	@Override
	public void dataSyncProc(String syncType) {

		Map<String, Object> map = getCurrentTerm();

		if(map != null) {
			if(syncType.equalsIgnoreCase("COPYDATA")) {
				scheduleMapper.copyDataProc();
			} else if(syncType.equalsIgnoreCase("SYNC")) {
				scheduleMapper.syncProc();
			}
		}
	}
}
