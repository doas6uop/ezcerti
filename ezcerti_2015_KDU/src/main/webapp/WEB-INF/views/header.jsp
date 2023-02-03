<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<link rel="shortcut icon" href="/resources/images/favicon.ico">

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-83246998-1', 'auto');
  ga('send', 'pageview');
</script>

<script>
	document.title = '경동대학교 전자출결';
</script>

<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
<script>

    function showElementTop(nInx) {

        var menu1 = document.getElementById("in_topmenu1");
        var menu2 = document.getElementById("in_topmenu2");
        var menu3 = document.getElementById("in_topmenu3");
        var menu4 = document.getElementById("in_topmenu4");
        var menu5 = document.getElementById("in_topmenu5");
        var menu6 = document.getElementById("in_topmenu6");
        if (nInx == 1) {
            menu1.style.display = "";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
        }
        else if (nInx == 2) {
            menu1.style.display = "none";
            menu2.style.display = "";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
        }
        else if (nInx == 3) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
        }
        else if (nInx == 4) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "";
            menu5.style.display = "none";
            menu6.style.display = "none";
        }
        else if (nInx == 5) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "";
            menu6.style.display = "none";
        }
        else if (nInx == 6) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "";
        }
    }
    
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
<script>

    function showElementTop(nInx) {

        var menu11 = document.getElementById("in_topmenu11");
        var menu12 = document.getElementById("in_topmenu12");
        var menu13 = document.getElementById("in_topmenu13");
        var menu14 = document.getElementById("in_topmenu14");
        var menu15 = document.getElementById("in_topmenu15");
        var menu16 = document.getElementById("in_topmenu16");
        
        if (nInx == 11) {
            menu11.style.display = "";
            menu12.style.display = "none";
            menu13.style.display = "none";
            menu14.style.display = "none";
            menu15.style.display = "none";
            menu16.style.display = "none";
        }
        else if (nInx == 12) {
            menu11.style.display = "none";
            menu12.style.display = "";
            menu13.style.display = "none";
            menu14.style.display = "none";
            menu15.style.display = "none";
            menu16.style.display = "none";
        }
        else if (nInx == 13) {
            menu11.style.display = "none";
            menu12.style.display = "none";
            menu13.style.display = "";
            menu14.style.display = "none";
            menu15.style.display = "none";
            menu16.style.display = "none";
        }
        else if (nInx == 14) {
            menu11.style.display = "none";
            menu12.style.display = "none";
            menu13.style.display = "none";
            menu14.style.display = "";
            menu15.style.display = "none";
            menu16.style.display = "none";
        }
        else if (nInx == 15) {
            menu11.style.display = "none";
            menu12.style.display = "none";
            menu13.style.display = "none";
            menu14.style.display = "none";
            menu15.style.display = "";
            menu16.style.display = "none";
        }
        else if (nInx == 16) {
            menu11.style.display = "none";
            menu12.style.display = "none";
            menu13.style.display = "none";
            menu14.style.display = "none";
            menu15.style.display = "none";
            menu16.style.display = "";
        }
    }
    
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_STUDENT">
<script>

    function showElementTop(nInx) {

        var menu21 = document.getElementById("in_topmenu21");
        var menu22 = document.getElementById("in_topmenu22");
        var menu23 = document.getElementById("in_topmenu23");
        var menu24 = document.getElementById("in_topmenu24");
        if (nInx == 21) {
            menu21.style.display = "";
            menu22.style.display = "none";
            menu23.style.display = "none";
            menu24.style.display = "none";
        }
        else if (nInx == 22) {
            menu21.style.display = "none";
            menu22.style.display = "";
            menu23.style.display = "none";
            menu24.style.display = "none";
        }
        else if (nInx == 23) {
            menu21.style.display = "none";
            menu22.style.display = "none";
            menu23.style.display = "";
            menu24.style.display = "none";
        }
        else if (nInx == 24) {
            menu21.style.display = "none";
            menu22.style.display = "none";
            menu23.style.display = "none";
            menu24.style.display = "";
        }
    }
    
</script>
</sec:authorize>

<div id="top_logo">
	<h1><a href="/">
		<!-- UNIV_IMAGE -->
		<img src="${pageContext.request.contextPath}/resources/images/top/sub_top_kdu_logo.jpg" alt="전자출결시스템 EZCERTI" />
		</a></h1>
</div>
<div id="lnb">
	<ul>
		<sec:authorize ifNotGranted="ROLE_ANONYMOUS">
		<li><a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/top/lnb_01.gif" alt="HOME" /></a></li>
		<li><a href="${pageContext.request.contextPath}/static/j_spring_security_logout"><img src="${pageContext.request.contextPath}/resources/images/top/lnb_03.gif" alt="LOGOUT" /></a></li>
		</sec:authorize>
	</ul>
</div>
<sec:authorize ifAnyGranted="ROLE_ANONYMOUS">

</sec:authorize>

<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
<div id="top">
	<ul id="top_menu">
		<li class="menu1"><a href="${pageContext.request.contextPath}/muniv/main"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_01.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_01.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_01.gif'" alt="홈으로 이동" /></a>
			<div id='in_topmenu1' style='display:none'></div>
		</li>
		<li class="menu2"><a href="${pageContext.request.contextPath}/muniv/main/search"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_02.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_02.gif'" alt="통합검색" /></a>
			<div id='in_topmenu2' style='display:none'></div>
		</li>
		<li class="menu3">
			<!-- 
			<a href="${pageContext.request.contextPath}/muniv/main/classoff_list"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_03.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_03.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_03.gif'" alt="휴.보강처리" /></a>
			-->
			<div id='in_topmenu3' style='display:none'></div>
		</li>
		<li class="menu4"><a href="#" onclick="javascript:showElementTop(4);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_04.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_04.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_04.gif'" alt="커뮤니티" /></a>
			<div id='in_topmenu4' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="공지사항" />공지사항</a></li>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="문의사항" />문의사항</a></li>
				</ul>
			</div>
		</li>
		<li class="menu5"><a href="#" onclick="javascript:showElementTop(5);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_10.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_10.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_10.gif'" alt="정보관리" /></a>
			<div id='in_topmenu5' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/muniv/info/admin_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="관리자" />관리자</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/info/reserved_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="강의실관리" />강의실관리</a></li>
					<!-- 
					<li><a href="${pageContext.request.contextPath}/muniv/info/gonggyul_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="공결관리" />공결관리</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/info/classoff_manage_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="일괄휴강관리" />일괄휴강관리</a></li>
					-->
				</ul>
			</div>
		</li>
		<li class="menu6_admin"><a href="#" onclick="javascript:showElementTop(6);""><img src="${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_06.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_06.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_menu_off_06.gif'" alt="통계관리" /></a>
			<div id='in_topmenu6' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="결강현황" />결강현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_absence"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="결석현황" />결석현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_academic"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="학기통계" />학기통계</a></li>          
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_prof_usage"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="교수별사용통계" />교수별사용통계</a></li>          
				</ul>
			</div>
		</li>
	</ul>
</div>
<!-- 
<div id="top">
      <ul id="top_menu">
        <li class="menu1"><a href="${pageContext.request.contextPath}/muniv/prof/prof_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_prof_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_prof_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_prof_off.gif'" alt="교수관리" /></a>
          <div id='in_topmenu1' style='display:none'>
          </div>
        </li>
        <li class="menu2"><a href="${pageContext.request.contextPath}/muniv/student/student_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_student_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_student_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_student_off.gif'" alt="출결관리" /></a>
          <div id='in_topmenu2' style='display:none'>
          </div>
        </li>
        <li class="menu3"><a href="${pageContext.request.contextPath}/muniv/attendee/attendee_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_off.gif'" alt="기초코드관리" /></a>
          <div id='in_topmenu3' style='display:none'>
          </div>
        </li>
        <li class="menu4"><a href="${pageContext.request.contextPath}/muniv/attend/class_attend_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif'" alt="학교관리" /></a>
          <div id='in_topmenu4' style='display:none' >
          </div>
        </li>
        <li class="menu5"><a href="#" onclick="javascript:showElementTop(5);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_basic_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_basic_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_basic_off.gif'" alt="학교관리" /></a>
          <div id='in_topmenu5' style='display:none' >
          <ul>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/univ_info"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_univ.gif" alt="" /></a></li>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/college_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_college.gif" alt="" /></a></li>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/department_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dept.gif" alt="" /></a></li>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/subject_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_subject.gif" alt="" /></a></li>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/classday_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_classday.gif" alt="" /></a></li>
            <li><a href="${pageContext.request.contextPath}/muniv/basic/classhour_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_classhour.gif" alt="" /></a></li>
          </ul>        
          </div>
        </li>
        <li class="menu6"><a href="#" onclick="javascript:showElementTop(6);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_admin_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_admin_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_admin_off.gif'" alt="학교관리" /></a>
          <div id='in_topmenu6' style='display:none' >
          <ul>
			<li><a href="${pageContext.request.contextPath}/muniv/info/admin_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_adminlist.gif" alt="" /></a></li>
          	<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_notice.gif" alt="공지사항" /></a></li>
            <li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_qna.gif" alt="문의사항" /></a></li>
            <li><a href="${pageContext.request.contextPath}/comm/memo/memo_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_memo.gif" alt="메모" /></a></li>			                      
          </ul>
          </div>
        </li>
        <li class="menu7"><a href="#" onclick="javascript:showElementTop(7);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_stats_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_stats_off.gif'" alt="학교관리" /></a>
          <div id='in_topmenu7' style='display:none' >
	          <ul>
				<li><a href="${pageContext.request.contextPath }/muniv/stats/stats_attendstatus"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_attendstatus.gif" alt="" /></a></li>
				<li><a href="${pageContext.request.contextPath }/muniv/stats/stats_studentstatus"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_studentstatus.gif" alt="" /></a></li>
	            <li><a href="${pageContext.request.contextPath }/muniv/stats/stats_academic"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_statsprof.gif" alt="" /></a></li>          
	            <li><a href="${pageContext.request.contextPath }/muniv/stats/stats_term"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_statsterm.gif" alt="" /></a></li>          
	          </ul>          
          </div>
        </li>
      </ul>
</div>
-->
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
<div id="top">
	<ul id="top_menu">
		<li class="menu11"><a href="${pageContext.request.contextPath}/prof/prof_mypage"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_off.gif'" alt="마이페이지" /></a>
			<div id='in_topmenu11' style='display:none'></div>
		</li>
		<li class="menu12"><a href="#" onclick="javascript:showElementTop(12);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif'" alt="강의출결" /></a>
			<div id='in_topmenu12' style='display:none'>
				<ul>
					<li><a href="${pageContext.request.contextPath}/prof/class/class_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="강의출결목록" />강의출결목록</a></li>
					<%-- <li><a href="${pageContext.request.contextPath}/prof/class/class_add"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_classadd.gif" alt="보강등록" /></a></li> --%>
					<li><a href="${pageContext.request.contextPath}/prof/class/attend_batch_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="출결일괄처리" />출결일괄처리</a></li>
				</ul>
			</div>
		</li>
		<li class="menu13"><a href="${pageContext.request.contextPath}/prof/attendee/attendee_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attendee_off.gif'" alt="수강생" /></a>
			<div id='in_topmenu13' style='display:none'></div>
		</li>
		<li class="menu14"><a href="${pageContext.request.contextPath}/prof/info/prof_view_edit"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_info_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_info_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_info_off.gif'" alt="개인정보관리" /></a>
			<div id='in_topmenu14' style='display:none' ></div>
		</li>
		<li class="menu15">
			<a href="#" onclick="showElementTop(15);">
			<img src="${pageContext.request.contextPath}/resources/images/top/topmenu_stats_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_stats_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_stats_off.gif'" alt="통계" /></a>
			<div id='in_topmenu15' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/prof/stats/stats_term_end"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="학기마감" />학기마감</a></li>
					<li><a href="${pageContext.request.contextPath}/prof/stats/stats_term"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="학기별 통계" />과목별 출결통계</a></li>
				</ul>          
			</div>
		</li>
		<li class="menu16"><a href="#" onclick="javascript:showElementTop(16);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_community_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_community_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_community_off.gif'" alt="커뮤니티" /></a>
			<div id='in_topmenu16' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="공지사항" />공지사항</a></li>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="문의사항" />문의사항</a></li>
					<li><a href="${pageContext.request.contextPath}/comm/memo/memo_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="메모" />메모</a></li>			
					<li><a href="${pageContext.request.contextPath}/prof/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="이의신청내역" />이의신청내역</a></li>
					<li><a href="${pageContext.request.contextPath}/prof/claim/improve_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="이의신청내역" />강의개선요청</a></li>
				</ul>
			</div>
		</li>
	</ul>
</div>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_STUDENT">
<div id="top">
	<ul id="top_menu">
		<li class="menu21"><a href="${pageContext.request.contextPath}/student/student_mypage"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_off.gif'" alt="마이페이지" /></a>
			<div id='in_topmenu21' style='display:none'></div>
		</li>
		<li class="menu22"><a href="${pageContext.request.contextPath}/student/attend/attend_list"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_attend_off.gif'" alt="강의출결" /></a>
			<div id='in_topmenu22' style='display:none'></div>
		</li>
		<li class="menu23"><a href="${pageContext.request.contextPath}/student/info/student_view_edit"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_info_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_info_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_info_off.gif'" alt="개인정보관리" /></a>
			<div id='in_topmenu23' style='display:none' ></div>
		</li>
		<li class="menu24"><a href="#" onclick="javascript:showElementTop(24);"><img src="${pageContext.request.contextPath}/resources/images/top/topmenu_community_off.gif" class="top_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_community_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/top/topmenu_community_off.gif'" alt="커뮤니티" /></a>
			<div id='in_topmenu24' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="공지사항" />공지사항</a></li>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="문의사항" />문의사항</a></li>
					<li><a href="${pageContext.request.contextPath}/student/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="이의신청내역" />이의신청내역</a></li>
					<li><a href="${pageContext.request.contextPath}/student/claim/improve_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="이의신청내역" />강의개선요청</a></li>
				</ul>           
			</div>
		</li>
	</ul>
</div>

</sec:authorize>
