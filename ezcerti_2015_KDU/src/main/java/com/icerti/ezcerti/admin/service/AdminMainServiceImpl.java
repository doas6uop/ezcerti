package com.icerti.ezcerti.admin.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.icerti.ezcerti.admin.dao.AdminMainMapper;
import com.icerti.ezcerti.domain.Board;
import com.icerti.ezcerti.domain.MainStats;

@Transactional
@Service
public class AdminMainServiceImpl implements AdminMainService {
	
	@Autowired
	private AdminMainMapper adminMainMapper = null;

	@Override
	public Collection<Board> getMainBoardList(Map<String, Object> map) {
		return adminMainMapper.getMainBoardList(map);
	}

	@Override
	public String getMainCountList(Map<String, Object> map) {
		return adminMainMapper.getMainCountList(map);
	}

	@Override
	public Collection<MainStats> getMainTop3List1(Map<String, Object> map) {
		return adminMainMapper.getMainTop3List1(map);
	}

	@Override
	public Collection<MainStats> getMainTop3List2(Map<String, Object> map) {
		return adminMainMapper.getMainTop3List2(map);
	}
}