package com.icerti.ezcerti.prof.service;

import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.prof.dao.ProfStatsMapper;

@Service
public class ProfStatsServiceImpl implements ProfStatsService{
	
	private static final Logger logger = LoggerFactory.getLogger(ProfStatsService.class);

	@Autowired
	private ProfStatsMapper profStatsMapper = null;
	
	@Autowired
	private CommonMapper commonMapper = null;

	@Override
	public Collection<Object> getProfStatsTerm(Map<String, Object> map) {
		return profStatsMapper.getProfStatsTerm(map);
	}

	@Override
	public Collection<Attendmaster> getProfStatsTermEnd(Map<String, Object> map) {
		return profStatsMapper.getProfStatsTermEnd(map);
	}

	@Override
	public Collection<Attendmaster> getTermRemainClass(Map<String, Object> map) {
		return profStatsMapper.getTermRemainClass(map);
	}

	@Transactional
	@Override
	public String updateProfStatsTermEnd(Map<String, Object> map) {
		String msg = "";
		Prof prof = new Prof();
		prof.setUniv_cd(map.get("univ_cd").toString());
		prof.setTerm_cd(map.get("term_cd").toString());
		prof.setProf_no(map.get("prof_no").toString());
		prof = commonMapper.getProfInfo(prof);
		map.put("prof_adm_cd", prof.getProf_adm_cd());
		
		int resultProf = profStatsMapper.updateProfStatsTermEnd(map);
		if(resultProf==0){
			msg = "마감에 실패하였습니다. 정보가 올바르지 않습니다.";
			logger.info("TERM END FAILED -- prof_no : " + prof.getProf_no() + "Prof_adm_cd : " + prof.getProf_adm_cd());
		}else if(resultProf == 1){
			msg = "정상처리되었습니다.";
			int resultClass = profStatsMapper.updateProfStatsTermEndClass(map);
			logger.info("TERM END -- prof_no : " + prof.getProf_no() + " resultClass : " + resultClass + " Prof_adm_cd : " + prof.getProf_adm_cd());
			prof = commonMapper.getProfInfo(prof);
			ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
			HttpSession session = attr.getRequest().getSession();
			session.setAttribute("PROF_INFO", prof);
		}
		
		return msg;
	}

	@Override
	public Collection<Attendmaster> getProfStatsDaily(Map<String, Object> map) {
		return profStatsMapper.getProfStatsDaily(map);
	}

	@Override
	public Collection<Map<String, Object>> getProfStatsDailyAttendee(
			Map<String, Object> map) {
		return profStatsMapper.getProfStatsDailyAttendee(map);
	}

	@Override
	public Map<String, Object> getProfStatsDailyLecture(Map<String, Object> map) {
		return profStatsMapper.getProfStatsDailyLecture(map);
	}

	@Override
	public Collection<Object> getProfStats(Map<String, Object> map) {
		return profStatsMapper.getProfStats(map);
	}

	@Override
	public int getProfStatsCheckClaim(Map<String, Object> map) {
		return profStatsMapper.getProfStatsCheckClaim(map);
	}

	@Override
	public Attendmaster getAttendmaster(Map<String, Object> map) {
		return profStatsMapper.getAttendmaster(map);
	}
	
	@Override
	public Map<String, Object> executeRefreshEndProc(Map<String, Object> map) {
		return profStatsMapper.executeRefreshEndProc(map);
	}
}
