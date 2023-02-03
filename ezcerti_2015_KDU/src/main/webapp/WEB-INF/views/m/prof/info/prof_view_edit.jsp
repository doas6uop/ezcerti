<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no" /> 

<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>

<link href="${pageContext.request.contextPath}/resources_m/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/categorylayer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<c:if test="${empty PROF_INFO.passwd_mod_date }">
<script>
//alert("개인정보보호를 위해 비밀번호를 변경해주십시오.");
</script>
</c:if>	
<script>
$(document).ready(function(){
	$("#topmenu_04").removeClass('submenugrayfont').addClass('menubluefont');
});
function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var regEmpPwd = /(?=([a-zA-Z0-9].*(\W))|((\W).*[a-zA-Z0-9])$).{6,20}/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#prof").serialize();
    var r = confirm("변경하시겠습니까?");

    

    
    
    
    if(!$("#hp_no").val()){
    	alert("전화번호를 입력하세요.");
    	$("#hp_no").focus();
    	return false;
    }else if(!regExp.test($("#hp_no").val())){
    	alert("잘못된 전화번호입니다. 숫자, - 를 포함한 숫자만 입력하세요. 예) 010-XXXX-XXXX");
    	$("#hp_no").focus();
    	return false;
    }else if(!$("#email_addr").val()){
    	alert("이메일을 입력하세요.");
    	$("#email_addr").focus();
    	return false;
    }else if(!email_regx.test($("#email_addr").val())){
    	alert("잘못된 이메일 형식입니다.");
    	$("#email_addr").focus();
    	return false;
    }else if($("#prof_passwd1").val()!=$("#prof_passwd2").val()){
    	alert("비밀번호가 일치하지 않습니다.");
    	$("#prof_passwd1").focus();
    	return false;
    }else if($("#prof_passwd1").val()){
    	if(!regEmpPwd.test($("#prof_passwd1").val())){

    		 alert('6 ~ 20자의 영문/숫자/특수문자(<,>,\',\\ 제외) 혼용만 사용가능합니다.');

            $("#prof_passwd1").val('');

            $("#prof_passwd1").focus();

            return false;
        }
    }
	
	if(r==true){   
    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/prof/info/prof_modify",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	alert(msg);
	        	window.location.reload(true);
	        },
	        error: function(msg){
	        	alert(msg);
	        }
	
	    });
	}

 };
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 교수 개인정보관리 -->
<form:form commandName="prof" onsubmit="javascript:sendAjax(); return false;">
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘"> &nbsp; 개인정보변경</div>
<div class="biginfobg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="30%" height="30" align="center" class="graytd"><strong>사번</strong></td>
      <td width="70%" class="deepgraytd">${prof.prof_no }</td>
    </tr>
    <tr>
      <td height="30" align="center" class="deepgraytd"><strong>단과대학</strong></td>
      <td class="graytd">${prof.coll_name }</td>
    </tr>
    <tr>
      <td height="30" align="center" class="graytd"><strong>학과명</strong></td>
      <td class="deepgraytd">${prof.dept_name }</td>
    </tr>
    <tr>
      <td height="30" align="center" class="deepgraytd"><strong>교수명</strong></td>
      <td class="graytd">${prof.prof_name }</td>
    </tr>
    <%-- <tr>
      <td height="30" align="center" class="graytd"><strong>비밀번호</strong></td>
      <td class="deepgraytd">
      	<form:password path="prof_passwd" id="prof_passwd1" cssClass="searchtextbox"/>
      </td>
    </tr>
    <tr>
      <td height="30" align="center" class="deepgraytd"><strong>비밀번호확인</strong></td>
      <td class="graytd">
      	<input type="password" id="prof_passwd2" class="searchtextbox">
      </td>
    </tr> --%>
    <tr>
      <td height="30" align="center" class="graytd"><strong>연락처</strong></td>
      <td class="deepgraytd">
      	${prof.hp_no }<%-- <form:input path="hp_no" cssClass="searchtextbox" /> --%>
      </td>
    </tr>
    <tr>
      <td height="30" align="center" class="deepgraytd"><strong>e-mail</strong></td>
      <td class="graytd">
      	${prof.email_addr }<%-- <form:input path="email_addr" cssClass="searchtextbox"  /> --%>
      </td>
    </tr>
    <tr>
      <td height="30" align="center" class="graytd"><strong>상태</strong></td>
      <td class="deepgraytd">${prof.prof_sts_cd }</td>
    </tr>
  </table>
</div>
<div class="photobutton">
	<%-- <form:button>
	<img src="${pageContext.request.contextPath}/resources_m/images/attendee_button_05.png"style="max-width:60px;" alt="변경완료 버튼"></form:button>&nbsp; --%>
	<!--  
	<a href="javascript:window.location.href=parent.document.referrer;"><img src="${pageContext.request.contextPath}/resources_m/images/cancel_button.png" style="max-width:48px;" alt="목록버튼"></a>
	-->
</div>
</form:form>
<!-- //교수 개인정보관리 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
