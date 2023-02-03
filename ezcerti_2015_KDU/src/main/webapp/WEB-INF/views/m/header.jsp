<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-83599318-2', 'auto');
  ga('send', 'pageview');
</script>

<div class="subtoplogobg">
  <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="5%" height="45" align="left" valign="middle"> 
      <div class="visual" style="display:inline-block" id="category-open">
      <img src="${pageContext.request.contextPath}/resources_m/images/listb_button.png" style="max-width:40px;" alt="리스트버튼">
      </div>
      </td>
      <td width="95%" align="center" valign="middle">
      <div class="visual">
      <img src="${pageContext.request.contextPath}/resources_m/images/kdu_main_mobile_logo.png" style="max-width:138px;" alt="로고">
      </div>
      </td>
    </tr>
  </table>
</div>
<sec:authorize ifAnyGranted="ROLE_SYSTEM,ROLE_ADMIN">
<div id="wrapper">
<div id="scroller" style="width:780px; height:100%; float:left; padding:0;">
 <ul>
   <li id="topmenu_01" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/muniv/main'">홈</li>
   <li id="topmenu_02" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/muniv/main/search'">통합검색</li>
   <li id="topmenu_05" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE'">공지사항</li>
   <li id="topmenu_07" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/muniv/info/admin_list'">정보관리</li>
   <li id="topmenu_08" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/muniv/stats/stats_cancel_class'">통계관리</li>
 </ul>
</div>
</div>
<!-- category layer S -->
<div class="sviewer" style="display:none; position:absolute ; left:0px; top:0px; width:100%; height:100%; z-index:100; background-color:#000;filter:alpha(opacity=40);opacity:0.4;-moz-opacity:0.4;"></div>
<div class="slidelm">
	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" id="category-close"><span>닫 기</span></button></div>
	</div>
	
	<div class="cateist">
	<ul>
		<li><a href="${pageContext.request.contextPath}/muniv/main"><span>홈</span></a></li>
		<li><a href="${pageContext.request.contextPath}/muniv/main/search"><span>통합검색</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><span>공지사항</span></a></li>
		<li><a href="${pageContext.request.contextPath}/muniv/info/admin_list"><span>정보관리</span></a></li>
		<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class"><span>통계관리</span></a></li>
	</ul>
	</div>

	<div style="height:10px;"></div>

	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" onclick="location.href='${pageContext.request.contextPath}/static/j_spring_security_logout'"><span>로그아웃</span></button></div>
	</div>

	<div style="height:5px;"></div>

	<div style="text-align:center;"><a href="#" class="folinker">&copy; ::<spring:eval expression="@config['univ_title']"/>::</a></div>

</div>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
<div id="wrapper">
<div id="scroller" style="width:780px; height:100%; float:left; padding:0;">
 <ul>
   <li id="topmenu_01" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/prof_mypage'">마이페이지</li>
   <li id="topmenu_02" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/class/class_list'">강의출결</li>
   <li id="topmenu_03" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/attendee/attendee_list'">수강생</li>
   <li id="topmenu_04" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/info/prof_view_edit'">개인정보관리</li>
   <li id="topmenu_05" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/claim/claim_list'">이의신청내역</li>
   <li id="topmenu_06" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE'">공지사항</li>
   <li id="topmenu_07" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA'">문의게시판</li>
   <li id="topmenu_08" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/memo/memo_list'">메모</li>
   <li id="topmenu_09" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/prof/claim/improve_list'">강의개선내역</li>
 </ul>
</div>
</div>
<!-- category layer S -->
<div class="sviewer" style="display:none; position:absolute ; left:0px; top:0px; width:100%; height:100%; z-index:100; background-color:#000;filter:alpha(opacity=40);opacity:0.4;-moz-opacity:0.4;"></div>
<div class="slidelm">
	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" id="category-close"><span>닫 기</span></button></div>
	</div>
	
	<div class="cateist">
	<ul>
		<li><a href="${pageContext.request.contextPath}/m/prof/prof_mypage"><span>마이페이지</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/prof/class/class_list"><span>강의출결</span></a></li>
		<%-- <li><a href="${pageContext.request.contextPath}/m/prof/class/class_add"><span>보강등록</span></a></li> --%>
		<li><a href="${pageContext.request.contextPath}/m/prof/attendee/attendee_list"><span>수강생</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/prof/info/prof_view_edit"><span>개인정보관리</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/prof/claim/claim_list"><span>이의신청내역</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><span>공지사항</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><span>문의게시판</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/memo/memo_list"><span>메모</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/prof/claim/improve_list"><span>강의개선내역</span></a></li>
	</ul>
	</div>

	<div style="height:10px;"></div>

	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" onclick="location.href='${pageContext.request.contextPath}/static/j_spring_security_logout'"><span>로그아웃</span></button></div>
	</div>

	<div style="height:5px;"></div>

	<div style="text-align:center;"><a href="#" class="folinker">&copy; ::<spring:eval expression="@config['univ_title']"/>::</a></div>

</div>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_STUDENT">
<div id="wrapper">
<div id="scroller" style="width:520px; height:100%; float:left; padding:0;">
 <ul>
      <li id="topmenu_01" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/student/student_mypage'">마이페이지</li>
      <li id="topmenu_02" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/student/attend/attend_list'">강의출결</li>
      <li id="topmenu_03" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/student/info/student_view_edit'">개인정보관리</li>
      <li id="topmenu_04" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/m/student/claim/claim_list'">이의신청내역</li>
	  <li id="topmenu_05" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE'">공지사항</li>
	  <li id="topmenu_06" class="submenugrayfont" onclick="location.href='${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA'">문의게시판</li>
 </ul>
</div>
</div>
<!-- category layer S -->
<div class="sviewer" style="display:none; position:absolute ; left:0px; top:0px; width:100%; height:100%; z-index:100; background-color:#000;filter:alpha(opacity=40);opacity:0.4;-moz-opacity:0.4;"></div>
<div class="slidelm">
	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" id="category-close"><span>닫 기</span></button></div>
	</div>
	
	<div class="cateist">
	<ul>
		<li><a href="${pageContext.request.contextPath}/m/student/student_mypage"><span>마이페이지</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/student/attend/attend_list"><span>강의출결</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/student/info/student_view_edit"><span>개인정보관리</span></a></li>
		<li><a href="${pageContext.request.contextPath}/m/student/claim/claim_list"><span>이의신청내역</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><span>공지사항</span></a></li>
		<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><span>문의게시판</span></a></li>
	</ul>
	</div>

	<div style="height:10px;"></div>

	<div class="wz_btn_wide" style="margin:4px;">
		<div class="wz_btn_wide_box" style="width:100%;"><button type="button" onclick="location.href='${pageContext.request.contextPath}/static/j_spring_security_logout'"><span>로그아웃</span></button></div>
	</div>

	<div style="height:5px;"></div>

	<div style="text-align:center;"><a href="#" class="folinker">&copy; ::<spring:eval expression="@config['univ_title']"/>::</a></div>

</div>
</sec:authorize>
<!-- category layer E -->