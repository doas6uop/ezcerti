package com.icerti.ezcerti.common.memo.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Memo;

public interface MemoMapper {

	int getMemoListCount(Map<String, Object> map);
	Collection<Memo> getMemoList(Map<String, Object> map);
	Memo getMemoView(Map<String, Object> map);
	
	void updateMemoInfo(Map<String, Object> map);
	void deleteMemoInfo(Memo memo);
	void insertMemoInfo(Memo memo);
	
}
