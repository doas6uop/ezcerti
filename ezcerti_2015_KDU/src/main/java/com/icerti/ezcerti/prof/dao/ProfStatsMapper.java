package com.icerti.ezcerti.prof.dao;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.icerti.ezcerti.domain.Attendmaster;

public interface ProfStatsMapper {

	Collection<Object> getProfStatsTerm(Map<String, Object> map);

	Collection<Attendmaster> getProfStatsTermEnd(Map<String, Object> map);

	Collection<Attendmaster> getTermRemainClass(Map<String, Object> map);

	int updateProfStatsTermEnd(Map<String, Object> map);

	int updateProfStatsTermEndClass(Map<String, Object> map);

	Collection<Attendmaster> getProfStatsDaily(Map<String, Object> map);

	Collection<Map<String, Object>> getProfStatsDailyAttendee(Map<String, Object> map);

	Map<String, Object> getProfStatsDailyLecture(Map<String, Object> map);

	Collection<Object> getProfStats(Map<String, Object> map);

	int getProfStatsCheckClaim(Map<String, Object> map);

	List<Object> getProfStatsTermExcel(Map<String, Object> map);

	List<Object> getProfStatsDailyExcel(Map<String, Object> map);

	List<Object> getStatsAttendeeExcel(Map<String, Object> map);

	List<Attendmaster> getLectureClassday(Map<String, Object> map);

	Attendmaster getAttendmaster(Map<String, Object> map);
	
	/* 학기마감 관련 */
	Map<String, Object> executeRefreshEndProc(Map<String, Object> map);
}
