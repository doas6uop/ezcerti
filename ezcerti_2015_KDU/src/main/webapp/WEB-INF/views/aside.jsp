<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type="text/javascript">

	$(document).ready(function(){
		getid();
	});

	function checkLogin(oldInfo) {
		if (oldInfo != $("#hsuinfo option:selected").val()) {
			location.href = "${pageContext.request.contextPath}/accountChange?person_num=" + $("#hsuinfo option:selected").val();
		}
	}

	function checkForm() {
		/*
		if($('input:radio[name=input_rdo_user]:checked').length < 1){
			alert("선택해주세요.");
			return false;
		}
		 */
		if($("#i_username").val() == null || $("#i_username").val() == ''){
			alert("교번 / 사번을 입력해주세요.");
			$("#i_username").focus();
			return false;
		}
		if($("#i_password").val() == null || $("#i_password").val() == ''){
			alert("비밀번호를 입력해주세요.");
			$("#i_password").focus();
			return false;
		}

		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

		if( special_pattern.test($("#i_username").val()) == true ){
		    alert('특수문자는 사용할 수 없습니다.');
		    $("#j_username").focus();
		    return false;
		}

		if ($("input:checkbox[name='checksaveid']").prop("checked")) {
			saveid();
		}

		$("#j_username").val($("#i_username").val());
	 	$("#j_password").val($("#i_password").val());

		/*
		$("#j_username").val(decodeURIComponent($("#i_username").val()));
	 	$("#j_password").val(decodeURIComponent($("#i_password").val()));
	 	 */

		login_submit();

		/*
		var loginForm = document.getElementById("frm_login");
		//loginForm.action = "${pageContext.request.contextPath}/static/j_spring_security_check";
		loginForm.action = "${pageContext.request.contextPath}/login";
		loginForm.method = "POST";
		loginForm.submit;
		 */
	}

	function login_submit(){

		var form = $("#frm_login2");
		form.attr("action", "/login").attr("method", "POST");
		form.submit();
	}

	function findAcc() {
		window.open("https://www.hs.ac.kr/kor/member/findAcc.php");
	}

	function doBoardFileView(file_no) {
		document.location.replace('${pageContext.request.contextPath}/comm/board/board_file_download?file_no='+file_no);
	}

	function doOpenICIMS() {
		//window.open("http://icims2.inhatc.ac.kr/intra/login.jsp");
		window.open("https://ncs.inhatc.ac.kr//login");
	}

	function setCookie (name, value, expires) {
		document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
	}

	function getCookie(Name) {
		var search = Name + "=";

		if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
			offset = document.cookie.indexOf(search);

			if (offset != -1) { // 쿠키가 존재하면
				offset += search.length;
				// set index of beginning of value
				end = document.cookie.indexOf(";", offset);
				// 쿠키 값의 마지막 위치 인덱스 번호 설정
				if (end == -1)
					end = document.cookie.length;

				return unescape(document.cookie.substring(offset, end));
			}
		}

		return "";
	}

	function saveid() {

		var expdate = new Date();
		// 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨

		var tmpChk = $('input[name="checksaveid"]').is(":checked");

		if (tmpChk)
			expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
		else
			expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건

		setCookie("saveid", $("#i_username").val(), expdate);
	}

	function getid() {

		if(getCookie("saveid") != "") {
			$('input[name="checksaveid"]').attr("checked", true);
			$("#i_username").val(getCookie("saveid"));
		}
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

	function doPopupCreateClassData() {

	    var _width = 1200;
	    var _height = 1000;

	    // 팝업을 가운데 위치시키기 위해 아래와 같이 값 구하기
	    var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.height - (_height + 32) )/2);

		var targetURL = "${pageContext.request.contextPath}/muniv/class_manage/create_class_data_pop";
		window.open(targetURL,'classStatPop','width=' + _width + ', height=' + _height + ',top=' + _top + ',left=' + _left + ', toolbar=no, menubar=no, scrollbars=yes');
	}

</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
 <script>

	$(document).ready(function() {

		// 교수 - 메모, 이의신청 건수 표시
		$.ajax({

		       type: "POST",
		       url: "${pageContext.request.contextPath}/prof/prof_not_process_count",
		       dataType : "json",
		       success: function(data) {

		    	   // 메모, 이의신청 미처리 건수 표시
		    	   $("#claimCnt").text(""); // 초기화
		    	   $("#claimCnt").append(data.claimCnt);

		    	   // 결강건수 표시
		    	   $("#cancelClassCnt").text(""); // 초기화
		    	   $("#cancelClassCnt").append(data.cancelClassCnt);

		    	   /*
		    	   if(data.claimCnt != "0"){
		    		   $("#a_claimCnt").attr("href", "${pageContext.request.contextPath}/prof/claim/claim_list");
		    	   }
		    	    */
		       },
		       error: function(msg){
		    	   alert(msg);
		       }
		});

	});

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
			<%-- <img style="background-color: black;" src="${pageContext.request.contextPath}/resources/images/<spring:eval expression="@config['univ_main_img1']"/>"> --%>
		</a>
		</p>
		<div style="border-bottom:1px dashed #c5c5c5; margin-left:8px; margin-bottom:15px; width:235px; height:25px;">
			<p style="margin-left:5px; margin-top: 62px;"><img src="${pageContext.request.contextPath}/resources/images/aside/img_login.gif" /></p>
		</div>
		<!-- 로그인 이전 -->
		<%-- index 페이지로 이동 시킴
		<c:if test="${not empty param.error}">
		<script>
			alert('${error }');
		</script>
		</c:if>
		 --%>
		<!-- <form id="frm_login" action=""> -->
		<div class="login_area">
			<div class="login_left">
				<p class="float_left mg_t3"><img src="${pageContext.request.contextPath}/resources/images/aside/id.gif" class="float_left pd_r10 mg_t5" alt="아이디" />
				<input id="i_username" name="i_username" type="text" value="" class="login_text" maxlength="10"/>
				</p>
				<p class="float_left mg_t3"><img src="${pageContext.request.contextPath}/resources/images/aside/pw.gif" class="float_left pd_r10 mg_t5" alt="패스워드" />
				<input id="i_password" name="i_password" type="password" class="login_text" maxlength="30" onKeydown="javascript:if(event.keyCode == 13) checkForm();"/>
				</p>
			</div>
			<div class="login_btn">
				<button onclick="checkForm()"><img src="${pageContext.request.contextPath}/resources/images/aside/btn_login.gif" alt="로그인"/></button>
			</div>

			<!--
			<p class="float_right pd_r10">
			<img src="${pageContext.request.contextPath}/resources/images/aside/pw_search_button.png" onclick="$( '#lost_password' ).dialog('open')" style="cursor:pointer;" alt="비밀번호찾기">
			</p>
			-->

		</div>
		<p>
			<input type="checkbox" name="checksaveid" id="checksaveid" onClick="saveid()" style="margin-left:10px;" />
			<label for="checksaveid">아이디 저장</label>
		</p>
		<!-- </form> -->

		<form id="frm_login2" action="">
			<input id="j_username" name="j_username" type="hidden"/>
			<input id="j_password" name="j_password" type="hidden"/>
	    </form>

	</div>
	<div class="sub_01" style="margin-top:120px;">
		<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
		<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
		<!--
		<a href="/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/aside/prof_manual_icon.png"></a><br/>
		<a href="#"><img src="${pageContext.request.contextPath}/resources/images/aside/student_manual_icon.png"></a>
		-->
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
				<a href="${pageContext.request.contextPath}/muniv/main/classoff_list"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_03.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_03.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_03.gif'" alt="휴.보강처리" /></a>
				<div id='in_menu3' style='display:none'></div>
			</li>
		<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C001'}">
			<li class="menu4">
				<a href="#" onclick="javascript:showElement(4);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_04.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_04.gif'" alt="커뮤니티" /></a>
				<div id='in_menu4' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="공지사항"  />공지사항</a></li>
					<li style="padding:10px 0 10px 10px"><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="문의사항"  />문의사항</a></li>
					<%-- <li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=DEPT"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학과게시판"  />학과게시판</a></li> --%>
					<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=CLASS"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="과목별게시판"  />과목별게시판</a></li>
				</ul>
				</div>
			</li>
		</c:if>
		<li class="menu5">
			<a href="#" onclick="javascript:showElement(5);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_10.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_10.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_10.gif'" alt="정보관리" /></a>
			<div id='in_menu5' style='display:none' >
			<ul>
			<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C001'}">
				<li><a href="${pageContext.request.contextPath}/muniv/info/admin_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="관리자"  />관리자</a></li>
				<li style="padding:10px 0 10px 10px"><a href="${pageContext.request.contextPath}/muniv/info/reserved_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="강의실관리"  />강의실관리</a></li>
				<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/muniv/info/gonggyul_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="공결관리"  />공결관리</a></li>
				<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/muniv/info/classoff_manage_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="일괄휴강관리"  />일괄휴강관리</a></li>
				<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/muniv/info/delete_class_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="삭제강의자료복구"  />삭제강의자료복구</a></li>
			</c:if>
			<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C001' or sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C002'}">
				<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/prof/attendee/dept_student_list"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="반별학생명부" />반별학생명부</a></li>
				<li style="padding:0px 0 10px 10px"><a href="${pageContext.request.contextPath}/muniv/info/gonggyul_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="공결관리"  />공결관리</a></li>
			</c:if>
			</ul>
			</div>
		</li>
		<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C001'}">
			<li class="menu6">
				<a href="#" onclick="javascript:showElement(6);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_06.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif'" alt="통계" /></a>
				<div id='in_menu6' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="결강현황" />결강현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_classtime_check"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="강의출결시간현황" />강의출결시간현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_absence"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="결석현황" />결석현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_academic"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학기통계" />학기통계</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_prof_usage"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="교수별사용통계" />교수별사용통계</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_absent"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학과별결석률통계" />학과별결석률통계</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_attendance"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="출결현황" />출결현황</a></li>
				</ul>
				</div>
			</li>
		</c:if>
		<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C002'}">
			<li class="menu4">
				<div id='in_menu4' style='display:'></div>
			</li>
			<li class="menu5">
				<div id='in_menu5' style='display:'></div>
			</li>
			<li class="menu6">
				<a href="#" onclick="javascript:showElement(6);"><img src="${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif" class="admin_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_06.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/admin/admin_smenu_off_06.gif'" alt="통계" /></a>
				<div id='in_menu6' style='display:none' >
				<ul>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="결강현황" />결강현황</a></li>
					<li><a href="${pageContext.request.contextPath}/muniv/stats/stats_absence"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="결석현황" />결석현황</a></li>
				</ul>
				</div>
			</li>
		</c:if>
		</ul>

      <div class="sub_01">
		<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<c:if test="${ADMIN_INFO.admin_no eq 'system' or ADMIN_INFO.admin_no eq '2009071' or ADMIN_INFO.admin_no eq '2021099' }">
				<a href="#" onclick="javascript:doPopupCreateClassData();" style="cursor: pointer;">
					<img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon3.png" style="vertical-align: middle; width: 20px;" alt="학기데이터생성" />
					<label style="vertical-align: middle; margin-left: 5px; font-size: 14px; color: rgba(3, 97, 162, 1);">학기데이터생성</label><br/>
				</a>
			</c:if>
			<a href="${pageContext.request.contextPath }/center" style="cursor: pointer;">
				<img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon3.png" style="vertical-align: middle; width: 20px;" alt="고객센터1544-5105" />
				<label style="vertical-align: middle; margin-left: 5px; font-size: 14px; color: rgba(3, 97, 162, 1);">고객센터안내</label>
			</a>
			<%--
			<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
			</p>
			 --%>
		</p>
      </div>
	</div>
    </sec:authorize>
    <sec:authorize ifAnyGranted="ROLE_PROF">
   	<div class="right_menu">
		<p style="color:#4b4b4b; margin-bottom:5px;"><span class="b"><strong>${PROF_INFO.prof_name }<%--(<sec:authentication property="principal.username"/>)--%></strong>
		</span>님 &nbsp;
		<%-- <img title="메모" alt="메모" style="vertical-align: middle;" src="${pageContext.request.contextPath}/resources/images/admin/testmail.png" width="18px"> (0) &nbsp; --%>
		<a href="${pageContext.request.contextPath}/prof/claim/claim_list" id="a_claimCnt">
			<img title="이의신청" alt="이의신청" style="vertical-align: middle;" src="${pageContext.request.contextPath}/resources/images/admin/testcheck.png" width="18px"> (<span id="claimCnt">0</span>)
		</a>
		<a href="${pageContext.request.contextPath}/prof/class/stats_cancel_class" id="a_cancelClassCnt">
			<img title="결강현황" alt="결강현황" style="vertical-align: middle;" src="${pageContext.request.contextPath}/resources/images/admin/testCancelClass.png" width="18px"> (<span id="cancelClassCnt">0</span>)
		</a>
		</p>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a> &nbsp;
		<c:if test="${HSU_INFO_SIZE > 1 }">
		<select align="right" id="hsuinfo" onchange="javascript:checkLogin('${PROF_INFO.prof_no }');">
			<c:forEach var="list" items="${HSU_INFO }">
				<c:set var="userInfo" value="${fn:split(list,'|')}" />
				<c:set var="sosok" value="${userInfo[1]}" />
				<c:if test="${userInfo[1] eq '' or userInfo[1] eq null}">
					<c:set var="sosok" value="소속없음" />
				</c:if>
				<option value="${userInfo[0]}" <c:if test="${PROF_INFO.prof_no == userInfo[0]}">selected</c:if>>${sosok}</option>
			</c:forEach>
		</select>
		</c:if>
    </div>
	<div class="sub">
		<ul id="sub_menu">
			<li class="menu11"><a href="#" onclick="javascript:showElement(11);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_off.gif'" alt="마이페이지" /></a>
				<div id='in_menu11' style='display:'>
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/prof_mypage"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="마이페이지" />마이페이지</a></li>
						<li><a href="${pageContext.request.contextPath}/muniv/main/classoff_list?type=PLAN"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="보강계획서출력" />보강계획서출력</a></li>
						<li class="mg_b10"><a href="${pageContext.request.contextPath}/muniv/main/classoff_list?type=EXECUTE&procStatus=G030C002"><img src="${pageContext.request.contextPath}/resources/images/top/sub_menu_dot.gif" alt="보강실시확인서출력" />보강실시확인서출력</a></li>
					</ul>
				</div>
			</li>
			<li class="menu12"><a href="#" onclick="javascript:showElement(12);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attend_off.gif'" alt="강의출결" /></a>
				<div id='in_menu12' style='display:none'>
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/class/class_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="강의출결목록" />강의출결목록</a></li>
						<%-- <li><a href="${pageContext.request.contextPath}/prof/class/class_add"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_classadd.gif" alt="보강등록" /></a></li> --%>
						<li><a href="${pageContext.request.contextPath }/prof/class/attend_batch_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="출결일괄처리" />출결일괄처리</a></li>
						<li><a href="${pageContext.request.contextPath }/prof/class/long_term_absence_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="장기결석자관리" />장기결석자관리</a></li>
						<li class="mg_b10"><a href="${pageContext.request.contextPath }/prof/class/stats_cancel_class"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="결강현황" />결강현황</a></li>
					</ul>
				</div>
			</li>
			<li class="menu13"><a href="#" onclick="javascript:showElement(13);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_attendee_off.gif'" alt="수강생" /></a>
				<div id='in_menu13' style='display:none'>
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/attendee/attendee_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="수강생" />수강생</a></li>
						<li><a href="${pageContext.request.contextPath}/prof/attendee/dept_student_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="반별학생명부" />반별학생명부</a></li>
						<li class="mg_b10"><a href="${pageContext.request.contextPath}/prof/attendee/attend_class_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="과목별수강생생명부" />과목별수강생생명부</a></li>
					</ul>
				</div>
			</li>
			<li class="menu14"><a href="${pageContext.request.contextPath}/prof/info/prof_view_edit"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_info_off.gif'" alt="개인정보관리" /></a>
				<div id='in_menu14' style='display:none' ></div>
			</li>
			<li class="menu15"><a href="#" onclick="javascript:showElement(15);" ><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_stats_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_stats_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_stats_off.gif'" alt="통계관리" /></a>
				<div id='in_menu15' style='display:none' >
					<ul>
						<li><a href="${pageContext.request.contextPath}/prof/stats/stats_term_end"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학기마감" />학기마감</a></li>
						<li><a href="${pageContext.request.contextPath}/prof/stats/stats_term"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학기별 통계" />과목별 출결통계(인쇄)</a></li>
						<!--
						<li><a href="javascript:alert('본 기능은 개강 후 제공예정입니다.');"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학기별 통계" />과목별 출결통계</a></li>
						-->
						<!--
						<li class="mg_b10"><a href="${pageContext.request.contextPath}/prof/stats/prof_point_class_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="성적입력" />성적입력</a></li>
						-->
						<li class="mg_b10"><a href="javascript:doOpenICIMS()"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="성적입력" />성적입력</a></li>
					</ul>
				</div>
			</li>
			<li class="menu16"><a href="#" onclick="javascript:showElement(16);"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif" class="aside_menu_img" onmouseover="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_on.gif'" onmouseout="this.src='${pageContext.request.contextPath}/resources/images/aside/smenu_community_off.gif'" alt="공지사항" /></a>
				<div id='in_menu16' style='display:none' >
				    <ul>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="공지사항" />공지사항</a></li>
						<!--
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="문의사항" />문의사항</a></li>
						<li><a href="${pageContext.request.contextPath}/comm/memo/memo_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="메모" />메모</a></li>
						-->
						<%-- <li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=DEPT"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학과게시판" />학과게시판</a></li> --%>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=CLASS"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="과목별게시판" />과목별게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/prof/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="출결이의신청" />출결이의신청</a></li>
						<li><a href="${pageContext.request.contextPath}/prof/claim/improve_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="강의 Q&A" />강의 Q&A</a></li>
					</ul>
				</div>
			</li>
		</ul>
		<div class="sub_01">
			<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
			<!--
			<a href="/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/aside/prof_manual_icon.png"></a><br/>
			-->
			</p>
      </div>
	</div>
    </sec:authorize>
    <sec:authorize ifAnyGranted="ROLE_STUDENT">
   	<div class="right_menu">
		<p style="color:#4b4b4b; margin-bottom:5px;"><span class="b"><strong>${STUDENT_INFO.student_name }<%--(<sec:authentication property="principal.username"/>)--%></strong>
		</span>님</p>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a> &nbsp;
		<c:if test="${HSU_INFO_SIZE > 1 }">
		<select align="right" id="hsuinfo" onchange="javascript:checkLogin('${STUDENT_INFO.student_no }');">
			<c:forEach var="list" items="${HSU_INFO }">
				<c:set var="userInfo" value="${fn:split(list,'|')}" />
				<c:set var="sosok" value="${userInfo[1]}" />
				<c:if test="${userInfo[1] eq '' or userInfo[1] eq null}">
					<c:set var="sosok" value="소속없음" />
				</c:if>
				<option value="${userInfo[0]}" <c:if test="${STUDENT_INFO.student_no == userInfo[0]}">selected</c:if>>${sosok}</option>
			</c:forEach>
		</select>
		</c:if>
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
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=NOTICE"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="공지사항" />공지사항</a></li>
						<%--
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=QNA"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="문의사항" />문의사항</a></li>
						--%>
						<%-- <li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=DEPT"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="학과게시판" />학과게시판</a></li> --%>
						<li><a href="${pageContext.request.contextPath}/comm/board/board_list?board_type=CLASS"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="과목별게시판" />과목별게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/student/claim/claim_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="이의신청내역" />출결이의신청</a></li>
						<li><a href="${pageContext.request.contextPath}/student/claim/improve_list"><img src="${pageContext.request.contextPath}/resources/images/aside/smenu_dot.gif" alt="강의 Q&A" />강의 Q&A</a></li>
					</ul>
				</div>
			</li>
		</ul>

		<div class="sub_01">
			<p class="pd_t10 pd_l10" style="padding:10px 0 0 0; font-size:15px;font-weight:bold">
			<a href="${pageContext.request.contextPath }/center"><img src="${pageContext.request.contextPath}/resources/images/aside/customer_icon2.png" alt="고객센터1544-5105" /></a><br/>
			<!--
			<a href="#"><img src="${pageContext.request.contextPath}/resources/images/aside/student_manual_icon.png"></a>
			-->
			</p>
      </div>
	</div>
    </sec:authorize>
    </div>