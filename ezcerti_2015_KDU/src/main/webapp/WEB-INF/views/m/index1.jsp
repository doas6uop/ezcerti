<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no" /> 

<link rel="shortcut icon"href="${pageContext.request.contextPath}/resources/images/kwu_icon16.ico"/> 
<link href="${pageContext.request.contextPath}/resources_m/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script type="text/javascript">
$(function() {
	$( "#dialog_popup" ).dialog({
		autoOpen: false,
		resizable: false,
		draggable: false,
		width:300,
		height:400,
		modal : true,
	    beforeClose : function(){
	    	location.reload();
	    },
		buttons : {
			"닫기" : function() {
				$(this).dialog("destroy");
				$("#dialog_popup").css("display","none");
			}
		}
	});
});
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
/*
$(function() {
$('#dialog_popup').dialog('open');
});
*/
$(function() {
  $( "#lost_password" ).dialog({
    autoOpen: false,
    resizable: false,
    draggable: false,
    width:260,
    height:230,
    modal: true,
    buttons: {
   	  "확인": function() {
   		var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
   		if($("input:radio[name='rdo_type']:checked").length < 1){
   			alert("회원유형을 선택해주세요.");
   			return false;
   		}else if($("#lost_id").val() == ""){
   			alert("학번 / 사번을 입력해주세요.");
   			$("#lost_id").focus();
   			return false;
   		}else if($("#lost_name").val() == ""){
   			alert("이름을 입력해주세요.");
   			$("#lost_name").focus();
   			return false;
   		}else if($("#lost_email").val() == ""){
   			alert("이메일을 입력해주세요.");
   			$("#lost_email").focus();
   			return false;
   	    }else if(!email_regx.test($("#lost_email").val())){
   	    	alert("잘못된 이메일 형식입니다.");
   	    	$("#lost_email").focus();
   	    	return false;
   	    }
   		var rdo_type = $("#lost_password :radio[name='rdo_type']:checked").val();
		var postString = {lost_type: rdo_type, lost_id: $("#lost_id").val(), lost_name: $("#lost_name").val(), lost_email: $("#lost_email").val()};
		
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath }/password_lost",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	alert(msg);
	        	window.location.reload(true);
	        	},
	        beforeSend: function() {
	            //통신을 시작할때 처리
	         jQuery('.ui-dialog button:nth-child(1)').button('disable');
	         $('#ajax_indicator').show().fadeIn('fast');
	        	}, 
	        complete: function() {
	            //통신이 완료된 후 처리
	            $('#ajax_indicator').fadeOut();
	           },
	        error: function(msg){
	        	alert(msg);
	        }
	
	    });
         },    	
      "취소": function() {
        $( this ).dialog( "close" );
      }
    }
  });
});

function findAcc() {
	window.open("https://www.hs.ac.kr/kor/member/findAcc.php");
}
</script>
</head>
<sec:authorize ifAnyGranted="ROLE_PROF">
<script>
	location.href='${pageContext.request.contextPath}/m/prof/prof_mypage';
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_STUDENT">
<script>
	location.href='${pageContext.request.contextPath}/m/student/student_mypage';
</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
<script>
	location.href='${pageContext.request.contextPath}/muniv/student/student_list';
</script>
</sec:authorize>
<body background="${pageContext.request.contextPath}/resources_m/images/home_bg.gif" leftmargin="0" topmargin="0">
<div class="hometoplogo">
<div class="visual">
<img src="${pageContext.request.contextPath}/resources_m/images/kdu_main_mobile_logo.png" style="max-width:174px;" alt="메인스쿨로고">
</div>
</div>
<c:if test="${not empty param.error}">
	<!-- <div align="center" class="error-text">${SPRING_SECURITY_LAST_EXCEPTION.message }</div>  -->
	<script>
		alert('${error }');
	</script>
</c:if>
<form id="frm_login"  autocomplete="off">
<table width="97%" height="146" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="16"><img src="${pageContext.request.contextPath}/resources_m/images/home_table_left.png" width="16" height="146" alt="왼쪽배경"></td>
    <td valign="bottom" class="hometablebg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="29%" height="32" align="center" valign="middle" class="blackboldfont">아 이 디</td>
        <td width="71%" height="32" align="left" valign="bottom">
          <input id="j_username" name="j_username" type="text" value="" class="textbluebox"></td>
      </tr>
      <tr>
        <td height="48" align="center" valign="middle" class="blackboldfont">비밀번호</td>
        <td height="48" align="left" valign="middle"><input id="j_password" name="j_password" type="password" class="textbluebox"></td>
      </tr>
      <tr>
        <td height="56"></td>
        <td height="56" align="left" valign="middle" ><input type="checkbox" name="check" id="check">
          <label for="check"> &nbsp;<span class="whitefont">아이디 저장</span></label></td>
        </tr>
    </table></td>
    <td width="16"><img src="${pageContext.request.contextPath}/resources_m/images/home_table_right.png" width="16" height="146" alt="오른쪽배경"></td>
  </tr>
</table>
<div class="homebutton">
<button onclick="checkForm()"><img src="${pageContext.request.contextPath}/resources_m/images/loginb_button.png" style="max-width:148px;" alt="로그인버튼"></button>&nbsp;
<a onclick="$( '#lost_password' ).dialog('open')"><img src="${pageContext.request.contextPath}/resources_m/images/pwb_button.png" style="max-width:148px;" alt="비밀번호찾기버튼"></a>
</div>
<div class="homefooter">
<div class="visual">
<img src="${pageContext.request.contextPath}/resources_m/images/ezcerti_homeb_logo.png" style="max-width:150px;" alt="이지서티로고">
</div>
</div>
<div id="dialog_popup">
<p>

</p>
</div>
</form>
<div id="lost_password" title="비밀번호 찾기">
<form>
<table>
<tr>
	<td>회원유형</td>
	<td>
		<label><input type="radio" name="rdo_type" value="student">학생</label>
		<label><input type="radio" name="rdo_type" value="prof">교수</label>
	</td>
</tr>
<tr>
	<td>학번/사번</td>
	<td><input type="text" id="lost_id"></td>
</tr>
<tr>
	<td>이름</td>
	<td><input type="text" id="lost_name"></td>
</tr>
<tr>
	<td>이메일</td>
	<td><input type="text" id="lost_email"></td>
</tr>
</table>
</form>
<div id="ajax_indicator" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>
</div>
</body>
</html>

