package com.icerti.ezcerti.prof.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.Lecture;
import com.icerti.ezcerti.prof.dao.ProfMypageMapper;


@Transactional
@Service
public class ProfMypageServiceImpl implements ProfMypageService{
	
	@Autowired
	private ProfMypageMapper profMypageMapper = null;

	@Override
	public Collection<Attendmaster> getTodayLectureList(Map<String, Object> map) {
		Collection<Attendmaster> list = profMypageMapper.getTodayLectureList(map); 
		return list;
	}

	@Override
	public Map<String, Object> getLectureDay(Map<String, Object> map) {
		return profMypageMapper.getLectureDay(map);
	}

	@Override
	public Collection<Lecture> getLectureList(Map<String, Object> map) {
		return profMypageMapper.getLectureList(map);
	}



}
