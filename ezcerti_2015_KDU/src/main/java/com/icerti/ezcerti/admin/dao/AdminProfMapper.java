package com.icerti.ezcerti.admin.dao;

import java.util.Collection;
import java.util.Map;

import com.icerti.ezcerti.domain.Prof;

public interface AdminProfMapper {

	int getProfListCount(Map<String, Object> map);

	Collection<Prof> getProfList(Map<String, Object> map);

}
