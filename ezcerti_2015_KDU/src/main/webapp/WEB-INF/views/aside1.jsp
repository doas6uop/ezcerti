<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript">
function checkForm() {
	/* 
	if($('input:radio[name=input_rdo_user]:checked').length < 1){
		alert("선택해주세요.");
		return false;
	}
	 */
	if($("#j_username").val() == null || $("#j_username").val() == ''){
		alert("교번 / 사번을 입력해주세요.");
		$("#j_username").focus();
		return false;
	}
	if($("#j_password").val() == null || $("#j_password").val() == ''){
		alert("비밀번호를 입력해주세요.");
		$("#j_password").focus();
		return false;
	}
	
	var loginForm = document.getElementById("frm_login");
	loginForm.action = "${pageContext.request.contextPath}/login";
	loginForm.method = "POST";
	loginForm.submit;
}

function findAcc() {
	window.open("https://www.hs.ac.kr/kor/member/findAcc.php");
}

function doBoardFileView(file_no) {
	document.location.replace('${pageContext.request.contextPath}/comm/board/board_file_download?file_no='+file_no);
}

</script>
<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
 <script>
    function showElement(nInx) {

        var menu1 = document.getElementById("in_menu1");
        var menu2 = document.getElementById("in_menu2");
        var menu3 = document.getElementById("in_menu3");
        var menu4 = document.getElementById("in_menu4");
        var menu5 = document.getElementById("in_menu5");
        var menu6 = document.getElementById("in_menu6");
        //var menu7 = document.getElementById("in_menu7");
        
        if (nInx == 1) {
            menu1.style.display = "";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
            //menu7.style.display = "none";            
        }
        else if (nInx == 2) {
            menu1.style.display = "none";
            menu2.style.display = "";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
            //menu7.style.display = "none";            
        }
        else if (nInx == 3) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
            //menu7.style.display = "none";            
        }
        else if (nInx == 4) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "";
            menu5.style.display = "none";
            menu6.style.display = "none";
            //menu7.style.display = "none";
        }
        else if (nInx == 5) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "";
            menu6.style.display = "none";
            //menu7.style.display = "none";
        }
        else if (nInx == 6) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "";
            //menu7.style.display = "none";
        }
        /*
        else if (nInx == 7) {
            menu1.style.display = "none";
            menu2.style.display = "none";
            menu3.style.display = "none";
            menu4.style.display = "none";
            menu5.style.display = "none";
            menu6.style.display = "none";
            menu7.style.display = "";
        } 
        */
    }
    
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
 <script>
    function showElement(nInx) {

        var menu11 = document.getElementById("in_menu11");
        var menu12 = document.getElementById("in_menu12");
        var menu13 = document.getElementById("in_menu13");
        var menu14 = document.getElementById("in_menu14");
        var menu15 = document.getElementById("in_menu15");
        var menu16 = document.getElementById("in_menu16");
        
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
    function showElement(nInx) {

        var menu21 = document.getElementById("in_menu21");
        var menu22 = document.getElementById("in_menu22");
        var menu23 = document.getElementById("in_menu23");
        var menu24 = document.getElementById("in_menu24");
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
<div id="sub_content_right" >
	<sec:authorize access="isAnonymous()">
	<div id="login_sub">
		<p style="margin:5px 0 10px 15px;">
		<a href="${pageContext.request.contextPath }/">
			<!-- UNIV_IMAGE -->
			<img style="background-color: black;" src="${pageContext.request.contextPath}/resources/images/<spring:eval expression="@config['univ_main_img1']"/>">
		</a>
		</p>
		<div style="border-bottom:1px dashed #c5c5c5; margin-left:8px; margin-bottom:15px; width:235px; height:25px;">
			<p style="margin-left:5px;"><img src="${pageContext.request.contextPath}/resources/images/aside/img_login.gif" /></p>
		</div>
		<!-- 로그인 이전 -->
		<%-- index 페이지로 이동 시킴
		<c:if test="${not empty param.error}">
		<script>
			alert('${error }');
		</script>
		</c:if>
		 --%>
		<form id="frm_login">
		<div class="login_area">
			<div class="login_left">
				<p class="float_left mg_t3"><img src="${pageContext.request.contextPath}/resources/images/aside/id.gif" class="float_left pd_r10 mg_t5" alt="아이디" />
				<input id="j_username" name="j_username" type="text" value="" class="login_text" />
				</p>
				<p class="float_left mg_t3"><img src="${pageContext.request.contextPath}/resources/images/aside/pw.gif" class="float_left pd_r10 mg_t5" alt="패스워드" />
				<input id="j_password" name="j_password" type="password" class="login_text" />
				</p>
			</div>
			<div class="login_btn" style="padding:0 0 0 0">
				<button onclick="checkForm()"><img src="${pageContext.request.contextPath}/resources/images/aside/btn_login.gif" alt="로그인"/></button>
			</div>

			<p class="float_right pd_r10">
			<img src="${pageContext.request.contextPath}/resources/images/aside/pw_search_button.png" onclick="$( '#lost_password' ).dialog('open')" style="cursor:pointer;" alt="비밀번호찾기">
			</p>
		</div>
		<!--<p class="pd_l50"> 
		<input type="checkbox" name="name" style="margin-left:10px;" /> 아이디 기억하기
		</p> -->
		</form>
	</div>
	<div class="sub_01" style="margin-top:120px;">
		<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
		<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
		<a href="/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/aside/prof_manual_icon.png"></a><br/>      		
		<a href="/resources/doc/student_manual.pdf"><img src="${pageContext.request.contextPath}/resources/images/aside/student_manual_icon.png"></a>      		
		</p>		
	</div>       
	</sec:authorize>
	<!-- //로그인 이전 -->
	<!-- 로그인 이후 -->
	<sec:authorize access="isAuthenticated()">
	</sec:authorize>
	<!-- //로그인 이후 -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
   	<div class="right_menu">
		<p style="color:#4b4b4b; margin-bottom:5px;"><span class="b"><strong>${ADMIN_INFO.admin_name }(<sec:authentication property="principal.username"/>)</strong>
		</span>님</p>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a>
    </div>    	
	<div class="sub">
		<ul id="sub_menu">
			<li class="menu1">
				<a href="${pageContext.request.contextPath}/muniv/main" onclick="javascript:showElement(1);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_01.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_01.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_01.gif'" alt="홈으로 이동" /></a>
				<div id='in_menu1' style='display:'></div>
			</li>
			<li class="menu2">
				<a href="${pageContext.request.contextPath}/muniv/main/search"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_02.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_02.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_02.gif'" alt="통합검색" /></a>
				<div id='in_menu2' style='display:none'></div>
			</li>
			<li class="menu3">
		        <!-- 경운대는 휴보강 처리를 하지 않기 때문에 주석 처리 (2015.04.16) 
				<a href="${pageContext.request.contextPath}/muniv/main/classoff_list"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_03.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_03.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_03.gif'" alt="휴.보강처리" /></a>
				-->
				<div id='in_menu3' style='display:none'></div>
			</li>
			<li class="menu4">
				<a href="#" onclick="javascript:showElement(4);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_04.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_04.gif'" alt="커뮤니티" /></a>
				<div id='in_menu4' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_ssubmenu_04_01.gif" alt="공지사항"  /></a></li>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_ssubmenu_04_02.gif" alt="문의사항"  /></a></li>
				</ul>
				</div>
			</li>
			<li class="menu5">
				<a href="${pageContext.request.contextPath}/muniv/info/admin_list"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_05.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_05.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_05.gif'" alt="사용자관리" /></a>
				<div id='in_menu5' style='display:none' ></div>
			</li>
			<li class="menu6">
				<a href="#" onclick="javascript:showElement(6);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_06.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif'" alt="통계" /></a>
				<div id='in_menu6' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_ssubmenu_06_01.gif" alt="휴강통계" /></a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_absence"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_ssubmenu_06_02.gif" alt="결석통계" /></a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_academic"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_ssubmenu_06_03.gif" alt="학기통계" /></a></li>
				</ul>
				</div>
			</li>
		</ul>          
      
      <div class="sub_01">
		<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
		<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
		<a href="/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/aside/prof_manual_icon.png"></a><br/>      		
		<a href="/resources/doc/student_manual.pdf"><img src="${pageContext.request.contextPath}/resources/images/aside/student_manual_icon.png"></a>      		
		</p>		
      </div> 
	</div>
    </sec:authorize>
    <sec:authorize ifAnyGranted="ROLE_PROF">
   	<div class="right_menu">
		<p style="color:#4b4b4b; margin-bottom:5px;"><span class="b"><strong>${PROF_INFO.prof_name }<%--(<sec:authentication property="principal.username"/>)--%></strong>
		</span>님</p>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a>
    </div>    
	<div class="sub">
		<ul id="sub_menu">
			<li class="menu11"><a href="${pageContext.request.contextPath}/prof/prof_mypage"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif'" alt="마이페이지" /></a>
				<div id='in_menu11' style='display:'></div>
			</li>
			<li class="menu12"><a href="${pageContext.request.contextPath}/prof/class/class_list" onclick="javascript:showElement(2);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif'" alt="강의출결" /></a>
				<div id='in_menu12' style='display:none'>
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/class/class_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_classlist.gif" alt="강의출결목록" /></a></li>
						<!-- li><a href="${pageContext.request.contextPath}/prof/class/class_add"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_classadd.gif" alt="보강등록" /></a></li>
						<li class="mg_b10"><a href="${pageContext.request.contextPath }/prof/class/attend_batch_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_allattend.gif" alt="일괄처리" /></a></li-->
					</ul>
				</div>
			</li>
			<li class="menu13"><a href="${pageContext.request.contextPath}/prof/attendee/attendee_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_off.gif'" alt="수강생" /></a>
				<div id='in_menu13' style='display:none'></div>
			</li>
			<li class="menu14"><a href="${pageContext.request.contextPath}/prof/info/prof_view_edit"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif'" alt="개인정보관리" /></a>
				<div id='in_menu14' style='display:none' ></div>
			</li>
			<li class="menu15"><a href="#" onclick="javascript:showElement(15);" ><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_stats_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_stats_off.gif'" alt="통계관리" /></a>
				<div id='in_menu15' style='display:none' >
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/stats/stats_term_end"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_stats_termend.gif" alt="학기마감" /></a></li>
						<li class="mg_b10"><a href="${pageContext.request.contextPath}/prof/stats/stats_term"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_stats_term.gif" alt="학기별 통계" /></a></li>
					</ul>      	          
				</div>
			</li>
			<li class="menu16"><a href="#" onclick="javascript:showElement(16);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif'" alt="공지사항" /></a>
				<div id='in_menu16' style='display:none' >
					<ul>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_notice.gif" alt="공지사항" /></a></li>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_qna.gif" alt="문의사항" /></a></li>
						<li><a href="${pageContext.request.contextPath}/comm/memo/memo_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_memo.gif" alt="메모" /></a></li>
						<li><a href="${pageContext.request.contextPath}/prof/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_claim.gif" alt="이의신청내역" /></a></li>
					</ul>          
				</div>
			</li>
		</ul>
		<div class="sub_01">
			<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
			<a href="/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/aside/prof_manual_icon.png"></a><br/>      		
			</p>		
      </div>
	</div>    
    </sec:authorize>
    <sec:authorize ifAnyGranted="ROLE_STUDENT">
   	<div class="right_menu">
		<p style="color:#4b4b4b; margin-bottom:5px;"><span class="b"><strong>${STUDENT_INFO.student_name }<%--(<sec:authentication property="principal.username"/>)--%></strong>
		</span>님</p>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a>
    </div>      
	<div class="sub">
		<ul id="sub_menu">
			<li class="menu21"><a href="${pageContext.request.contextPath}/student/student_mypage"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif'" alt="마이페이지" /></a>
				<div id='in_menu21' style='display:'></div>
			</li>
			<li class="menu22"><a href="${pageContext.request.contextPath}/student/attend/attend_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif'" alt="강의출결" /></a>
				<div id='in_menu22' style='display:none'></div>
			</li>
			<li class="menu23"><a href="${pageContext.request.contextPath}/student/info/student_view_edit"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif'" alt="개인정보관리" /></a>
				<div id='in_menu23' style='display:none' ></div>
			</li>
			<li class="menu24"><a href="#" onclick="javascript:showElement(24);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif'" alt="커뮤니티" /></a>
				<div id='in_menu24' style='display:none' >
					<ul>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_notice.gif" alt="공지사항" /></a></li>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_qna.gif" alt="문의사항" /></a></li>
						<li><a href="${pageContext.request.contextPath}/student/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_claim.gif" alt="이의신청내역" /></a></li>
					</ul>
				</div>
			</li>
		</ul>
      
		<div class="sub_01">
			<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
			<a href="/resources/doc/student_manual.pdf"><img src="${pageContext.request.contextPath}/resources/images/aside/student_manual_icon.png"></a>      		
			</p>		
      </div>
	</div>    
    </sec:authorize>
    </div>