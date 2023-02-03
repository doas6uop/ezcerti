package com.icerti.ezcerti.admin.service;

import java.util.Map;

import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.util.PageBean;

public interface AdminProfService {

	PageBean<Prof> getProfList(Map<String, Object> map);
}
