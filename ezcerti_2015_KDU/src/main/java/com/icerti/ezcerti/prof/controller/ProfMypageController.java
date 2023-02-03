package com.icerti.ezcerti.prof.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.prof.service.ProfMypageService;

@Controller
@RequestMapping({"/prof", "/m/prof"})
public class ProfMypageController {

  @Autowired
  private ProfMypageService profMyPageService = null;

  @Autowired
  private CommonService commonService = null;

  @Value("#{config['makeup_lesson']}") 
  String globalMakLesson;

  @Value("#{config['makeup_lesson_limit']}") 
  String globalMakLessonLimit;

  @RequestMapping(value = "/prof_mypage", method = RequestMethod.GET)
  public String profMyPage(@RequestParam(value = "classday", defaultValue = "") String classday,
                            Model model, HttpSession session) {

    Map<String, Object> map = new HashMap<String, Object>();
    map.put("univ_cd", session.getAttribute("UNIV_CD"));
    map.put("year", session.getAttribute("YEAR"));
    map.put("term_cd", session.getAttribute("TERM_CD"));
    map.put("prof_no", session.getAttribute("PROF_NO"));
    map.put("classday", classday);

    // 휴, 보강 처리 /////////////////////////////
    map.put("globalMakLesson", globalMakLesson);
    map.put("globalMakLessonLimit", globalMakLessonLimit);
    ////////////////////////////////////////    
    
    map.put("lectureDay", profMyPageService.getLectureDay(map));

    model.addAttribute("lectureDay", map.get("lectureDay"));
    model.addAttribute("attendList", profMyPageService.getTodayLectureList(map));
    model.addAttribute("lectureList", profMyPageService.getLectureList(map));
    model.addAttribute("classday", classday);
        
    return "prof/prof_mypage";
  }

}
