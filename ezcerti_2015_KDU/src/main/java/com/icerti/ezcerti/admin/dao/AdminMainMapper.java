package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.MainStats;

public interface AdminMainMapper {

	Collection<Board> getMainBoardList(Map<String, Object> map);
	String getMainCountList(Map<String, Object> map);
	
	Collection<MainStats> getMainTop3List1(Map<String, Object> map);
	Collection<MainStats> getMainTop3List2(Map<String, Object> map);
}
