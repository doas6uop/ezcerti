package com.icerti.ezcerti.scheduler.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.icerti.ezcerti.scheduler.service.ScheduleService;

@Component
public class ScheduleController {
 
	@Autowired
	private ScheduleService scheduleService = null;
	
	/* 강의 시간별 강의 상태 변경 처리 */
    @Scheduled(cron = "5 * * * * *")
    public void checkClassStatus(){
		try {		
			scheduleService.checkClassStatus();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    @Scheduled(cron = "30 * * * * *")
    public void checkConseClassAttend(){
		try {		
			//scheduleService.checkConseClassAttend();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    /* 공결 처리 */
    @Scheduled(cron = "0 0 1 * * *")
    public void gonggyulProc(){
		try {		
			scheduleService.gonggyulProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }    

    /* 종료된 강의의 결석 및 출결 수 처리 */
    @Scheduled(cron = "0 0 2 * * *")
    public void endedClassAttendeeProc(){
		try {		
			scheduleService.endedClassAttendeeProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    /* 기준정보 동기화 처리 */
    @Scheduled(cron = "0 0 3 * * *")
    public void syncInitDataProc(){
		try {		
			scheduleService.syncInitDataProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }    

    /* 사용자정보 동기화 처리 */
    @Scheduled(cron = "0 0 4 * * *")
    public void syncUserInfoProc(){
		try {		
			scheduleService.syncUserInfoProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }    
    
    /* 강의정보 동기화 처리 */
    @Scheduled(cron = "0 0 5 * * *")
    public void syncClassInfoProc(){
		try {		
			scheduleService.syncClassInfoProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }    
    
    /* 휴,보강 정보 동기화 처리 */
    @Scheduled(cron = "0 0 6 * * *")
    public void syncHyuBogangInfoProc(){
		try {		
			scheduleService.syncHyuBogangInfoProc();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }    
}