package com.icerti.ezcerti.common.memo.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Memo;
import com.icerti.ezcerti.util.PageBean;

public interface MemoService {
	
	PageBean<Memo> getMemoList(Map<String, Object> map);
	Map<String, Object> getMemoView(Map<String, Object> map);
	
	void updateMemoInfo(Map<String, Object> map);
	void deleteMemoInfo(Memo memo);
	void insertMemoInfo(Memo memo);

}
