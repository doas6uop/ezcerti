package com.icerti.ezcerti.prof.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.common.service.CommonService;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.prof.service.ProfInfoService;

@Controller
@RequestMapping({"/prof/info", "/m/prof/info"})
public class ProfInfoController {

  @Autowired
  private ProfInfoService profInfoService = null;
  
  @Autowired
  private CommonService commonService = null;
  
  @Autowired
  private CommonMapper commonMapper = null;
  

  @RequestMapping(value = "/prof_view_edit", method = RequestMethod.GET)
  public String profInfoView(Model model, HttpSession session) {
    String prof_no = session.getAttribute("PROF_NO").toString();

    Prof prof = new Prof();

    prof.setProf_no(prof_no);
    prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    prof.setTerm_cd(session.getAttribute("TERM_CD").toString());

    prof = commonService.getProfInfo(prof);

    model.addAttribute("prof", prof);
    
    return "prof/info/prof_view_edit";
  }

  @RequestMapping(value = "/prof_modify", method = RequestMethod.POST)
  public String profInfoEdit(Prof prof, Model model, HttpSession session) {
    String msg = "";
    prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    
    if(session.getAttribute("PROF_NO") != null && session.getAttribute("PROF_NO").toString().length() > 0) {
    	prof.setProf_no(session.getAttribute("PROF_NO").toString());
    }

    msg = profInfoService.updateProfInfo(prof);
    session.removeAttribute("PROF_INFO");
    prof.setTerm_cd(session.getAttribute("TERM_CD").toString());
    session.setAttribute("PROF_INFO", commonMapper.loginProfInfo(prof));

    model.addAttribute("message", msg);
    return "msg";
  }

}
