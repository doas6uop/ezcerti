package com.icerti.ezcerti.prof.dao;

import com.icerti.ezcerti.domain.Prof;


public interface ProfInfoMapper {

 Prof getProfView(Prof prof);

 void updateProfInfo(Prof prof);

}
