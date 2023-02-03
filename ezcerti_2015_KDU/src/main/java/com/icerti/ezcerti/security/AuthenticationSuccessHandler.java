package com.icerti.ezcerti.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.beans.factory.annotation.Value;

import com.icerti.ezcerti.common.dao.CommonMapper;
import com.icerti.ezcerti.domain.Admin;
import com.icerti.ezcerti.domain.Prof;
import com.icerti.ezcerti.domain.Student;
import com.icerti.ezcerti.domain.Univ;

public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

  @Value("#{config['univ_code']}") 
  String globalUnivCode;

  @Autowired
  private CommonMapper commonMapper = null;

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
      Authentication authentication) throws ServletException, IOException {
    // TODO Auto-generated method stub	
	  System.out.println("======================================================");
	  System.out.println("======================================================");
	  System.out.println("======================================================");
	  System.out.println("======================================================");
	  System.out.println("======================================================");
    HttpSession session = request.getSession();
    String reg_type_cd = authentication.getAuthorities().toString();
    String user_type = reg_type_cd;

    if (reg_type_cd.equals("[ROLE_SYSTEM]")) {
      reg_type_cd = "G017C001";
    } else if (reg_type_cd.equals("[ROLE_ADMIN]")) {
      reg_type_cd = "G017C002";
    } else if (reg_type_cd.equals("[ROLE_USER]")) {
      reg_type_cd = "G017C003";
    } 
    
    //session.setAttribute("TERM_CD", "G002C002");	//현재 학기를 입력한다.
    session.setAttribute("ROLE_ANONYMOUS", "ROLE_ANONYMOUS");
    session.setAttribute("UNIV_CD", globalUnivCode);	//학교정보 입력

    //System.out.println("globalUnivCode:["+globalUnivCode+"]");
    
    // 2014.12.30 ///////////////////
    // - 현재의 학기 조회
    // - session 정보에 년도 추가
    Univ univ = new Univ();
    String strCurrTerm = "";
    
    univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());
    univ.setUniv_sts_cd("G004C001");
    
    univ = commonMapper.getCurrentTerm(univ);
    
    if(univ != null) {
    	strCurrTerm = univ.getTerm_cd();
    	session.setAttribute("TERM_CD", strCurrTerm);	//현재 학기를 입력한다.
    	session.setAttribute("YEAR", univ.getYear());	//현재 학기를 입력한다.
    } else {
    	univ = new Univ();
        univ.setUniv_cd(session.getAttribute("UNIV_CD").toString());

        univ = commonMapper.getLastTerm(univ);    	
    	strCurrTerm = univ.getTerm_cd();
    	session.setAttribute("TERM_CD", strCurrTerm);	//현재 학기를 입력한다.
    	session.setAttribute("YEAR", univ.getYear());	//현재 학기를 입력한다.
    }
    session.setAttribute("UNIV_INFO", univ);
    /////////////////////////////////    
    
	  /*<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
	  <script>location.href="${pageContext.request.contextPath }/muniv/main";</script>
	  </sec:authorize>
	  <sec:authorize ifAnyGranted="ROLE_PROF">
	  <script>location.href="${pageContext.request.contextPath }/prof/prof_mypage";</script>
	  </sec:authorize>
	  <sec:authorize ifAnyGranted="ROLE_STUDENT">
	  <script>location.href="${pageContext.request.contextPath }/student/student_mypage";</script>
	  </sec:authorize>*/
    
    //로그인 성공 후 관리자 정보 session 등록
    if(reg_type_cd.equals("G017C001")||reg_type_cd.equals("G017C002")||reg_type_cd.equals("G017C003")){
      session.setAttribute("ADMIN_NO", authentication.getName());
      Admin admin = new Admin();
      admin.setAdmin_no(authentication.getName());
      admin.setUniv_cd(session.getAttribute("UNIV_CD").toString());
      session.setAttribute("ADMIN_INFO", commonMapper.loginAdminInfo(admin));
      session.setAttribute("USER_INFO", commonMapper.loginAdminInfo(admin));
      
      //패스워드를 변경해야 할 경우
      // - 항상 마이페이지로 이동 처리 (2015.02.03) 
      //if(admin.getPasswd_mod_date()==null){
      //  response.sendRedirect(request.getContextPath()+"/muniv/info/admin_view?user_no="+admin.getAdmin_no());
      //}else{
        response.sendRedirect(request.getContextPath()+"/muniv/main");
      //}
    //로그인 성공 후 교수 정보 session 등록
    }else if(reg_type_cd.equals("[ROLE_PROF]")){
      session.setAttribute("PROF_NO", authentication.getName());
      Prof prof = new Prof();
      prof.setUniv_cd(session.getAttribute("UNIV_CD").toString());
      prof.setTerm_cd(session.getAttribute("TERM_CD").toString());
      prof.setProf_no(authentication.getName());
      session.setAttribute("PROF_INFO", commonMapper.loginProfInfo(prof));
      session.setAttribute("USER_INFO", commonMapper.loginProfInfo(prof));
      //List<String> hsuInfoList = commonMapper.loginHsuInfo(prof.getProf_no());
      //session.setAttribute("HSU_INFO", hsuInfoList);
      //session.setAttribute("HSU_INFO_SIZE", hsuInfoList.size());
      
      //패스워드를 변경해야 할 경우
      // - 항상 마이페이지로 이동 처리 (2015.02.03) 
      //if(prof.getPasswd_mod_date()==null){
      //  response.sendRedirect(request.getContextPath()+"/prof/info/prof_view_edit");
      //}else{
        response.sendRedirect(request.getContextPath()+"/prof/prof_mypage");
      //}
    //로그인 성공 후 학생 정보 session 등록
    }else if(reg_type_cd.equals("[ROLE_STUDENT]")){
      session.setAttribute("STUDENT_NO", authentication.getName());
      Student student = new Student();
      student.setUniv_cd(session.getAttribute("UNIV_CD").toString());
      student.setTerm_cd(session.getAttribute("TERM_CD").toString());
      student.setStudent_no(authentication.getName());
      session.setAttribute("STUDENT_INFO", commonMapper.loginStudentInfo(student));
      session.setAttribute("USER_INFO", commonMapper.loginStudentInfo(student));
      //List<String> hsuInfoList = commonMapper.loginHsuInfo(student.getStudent_no());
      //session.setAttribute("HSU_INFO", hsuInfoList);
      //session.setAttribute("HSU_INFO_SIZE", hsuInfoList.size());
      
      //패스워드를 변경해야 할 경우      
      // - 항상 마이페이지로 이동 처리 (2015.02.03) 
      //if(student.getPasswd_mod_date()==null){
      //  response.sendRedirect(request.getContextPath()+"/student/info/student_view_edit");
      //}else{
        response.sendRedirect(request.getContextPath()+"/student/student_mypage");
      //}
    }

    session.setAttribute("REG_TYPE_CD", reg_type_cd);
    session.setAttribute("USER_TYPE", user_type);

    //System.out.println(authentication.getAuthorities());
    //System.out.println(authentication.getPrincipal());
  }


}
