package com.icerti.ezcerti.common.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icerti.ezcerti.common.app.dao.AppMapper;
import com.icerti.ezcerti.domain.Attendmaster;
import com.icerti.ezcerti.domain.AttendmasterApp;
import com.icerti.ezcerti.domain.UnivApp;

@Transactional
@Service
public class AppServiceImpl implements AppService {
	
	@Autowired
	private AppMapper appMapper = null;

	@Override
	public List<UnivApp> getUnivList(Map<String, Object> map) {
		return appMapper.getUnivList(map);
	}
	
	@Override
	public String checkStudentNo(Map<String, Object> map) {
		return appMapper.checkStudentNo(map);
	}
	
	@Override
	public List<AttendmasterApp> getCurrentClass(Map<String, Object> map) {
		return appMapper.getCurrentClass(map);
	}
	
	@Override
	public Attendmaster getAttendmaster(Map<String, Object> map) {
		return appMapper.getAttendmaster(map);
	}
	
	@Override
	public String getClassCertNo(Map<String, Object> map) {
		return appMapper.getClassCertNo(map);
	}

	@Override
	public int checkStudentAttend(Map<String, Object> map) {
		return appMapper.checkStudentAttend(map);
	}

	@Override
	public void insertAppExec(Map<String, Object> map) {
		appMapper.insertAppExec(map);
	}

	@Override
	public void updateAppStatus(Map<String, Object> map) {
		appMapper.updateAppStatus(map);
	}
	
	@Override
	public int selectAppExec(Map<String, Object> map) {
		return appMapper.selectAppExec(map);
	}
	
	@Override
	public int getEnableBeaconCount(String uuid, List<String> lstBeacon) {
		/*
		 * 강의실에 설치됟 비콘의 UUID와 수신된 UUID를 비교하여 맞는 비콘이 있는 경우 1을 리턴, 없으면 0을 리턴
		 */
		int retValue = 0;
		String strName = "";
		String[] arrUUID = null;

		if(uuid != null && uuid.length() > 0 && lstBeacon != null && lstBeacon.size() > 0) {
			arrUUID = uuid.split("\\|");
			
			if(arrUUID.length > 0) {
				for(int i = 0; i < arrUUID.length; i++) {
					String emp = null;
					try {
						strName = arrUUID[i].split("_")[0];
						emp = arrUUID[i].split("_")[1];
						int temp = Integer.parseInt(emp);
						emp = String.valueOf(temp);
					} catch (Exception e) {
						emp = "";
					}
					
					/*
					for(int j = 0; j < lstBeacon.size(); j++) {
						if(emp.equals(lstBeacon.get(j).toString())) {
							retValue++;
							break;
						}
					}
					*/
				}
			}
			
			// 임시로 UUID 값이 있으면 출결 가능하도록 처리 (2015.09.01)
			retValue++;
		}
		
		return retValue;
	}
	
	@Override
	public void insertCertBeaconInfo(Map<String, Object> map) {
		appMapper.insertCertBeaconInfo(map);
	}
	
	@Override
	public int selectCertBeaconInfo(Map<String, Object> map) {
		return appMapper.selectCertBeaconInfo(map);
	}
	
	@Override
	public void updateCertBeaconInfo(Map<String, Object> map) {
		appMapper.updateCertBeaconInfo(map);
	}	
	
}