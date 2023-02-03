<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<c:if test="${empty ADMIN_INFO.passwd_mod_date }">
<c:if test="${admin.admin_no == ADMIN_INFO.admin_no}">
<script>
//alert("개인정보보호를 위해 비밀번호를 변경해주십시오.");
</script>
</c:if>
</c:if>	
<script>
$(document).ready(function(){
	$(".menu5 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_05.gif");
	$(".menu5 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_05.gif");
	$("#in_topmenu5").css("display","block");
	$("#in_menu5").css("display","block");
});

function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var regEmpPwd = /(?=([a-zA-Z0-9].*(\W))|((\W).*[a-zA-Z0-9])$).{6,20}/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#admin").serialize();
    
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
    }else if($("#admin_passwd1").val()!=$("#admin_passwd2").val()){
    	alert("비밀번호가 일치하지 않습니다.");
    	$("#admin_passwd1").focus();
    	return false;
    }else if($("#admin_passwd1").val()){
    	if(!regEmpPwd.test($("#admin_passwd1").val())){

    		alert('6 ~ 20자의 영문/숫자/특수문자(<,>,\',\\ 제외) 혼용만 사용가능합니다.');

            $("#admin_passwd1").val('');

            $("#admin_passwd1").focus();

            return false;
        }
    }
	
    var r = confirm("변경하시겠습니까?");
	if(r==true){   
    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/info/admin_modify",
	
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
function adminDelete(){
	var postString = $("#admin").serialize();
	var r = confirm("삭제하시겠습니까?");
	if(r==true){
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/info/admin_delete",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	window.location.href=parent.document.referrer;
	        },
	        error: function(msg){
	        	alert("실패");
	        }
	
	    });
	}
	
	
	
} 

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 관리자 상세정보/수정 -->
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_02.png"  alt="강의일정보타이틀" /></td>
	      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;관리자상세정보</td>
	    </tr>
	  </table>
	</div>

<form:form commandName="admin" onsubmit="javascript:sendAjax(); return false;">	
<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">
  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
  <tr>
    <th>소속</th>
    <td >${admin.coll_name }&nbsp;&#47;&nbsp;${admin.dept_name }</td>
  </tr>
  <tr>
    <th>사번</th>
    <td><input type="hidden" name="user_no" value="${admin.admin_no }">${admin.admin_no }</td>
  </tr>
  <tr>
    <th>관리자명</th>
    <td>${admin.admin_name }</td>
  </tr>
  <tr>
    <th>휴대전화</th>
    <td>${admin.hp_no }<%-- <form:input path="hp_no" cssClass="searchtextbox" /> --%></td>
  </tr>
  <tr>
    <th>이메일</th>
    <td>${admin.email_addr }<%-- <form:input path="email_addr" cssClass="searchtextbox" /> --%></td>
  </tr>
  <tr>
    <th>권한</th>
    <td>${admin.admin_level_name }</td>
  </tr>
  <tr>
    <th>상태</th>
    <td>${admin.admin_sts_name }</td>
  </tr>
  <%-- <tr>
    <th>비밀번호</th>
    <td><form:password path="admin_passwd" id="admin_passwd1" cssClass="searchtextbox"/></td>
  </tr>
  <tr>
    <th>비밀번호확인</th>
    <td><input type="password" id="admin_passwd2" class="searchtextbox"></td>
  </tr> --%>
  <tr>
    <th>등록일</th>
    <td>${admin.reg_date }</td>
  </tr>
</table>
</div>
<div class="round_box_bottom float_left"></div>

<div class="aligncenter">
	<a href="${pageContext.request.contextPath}/muniv/info/admin_list"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a>&nbsp;
	<c:if test="${admin.admin_level_cd == 'G014C001'}">	  
		<%-- <form:button><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button.png" width="78" height="27" alt="수정완료버튼" /></form:button>&nbsp; --%>
	</c:if>	  	
	<sec:authorize ifAnyGranted="ROLE_SYSTEM">	   
		<%-- <a href="javascript:adminDelete()"><img src="${pageContext.request.contextPath}/resources/images/admin/delete_button.png" width="61" height="27" alt="삭제버튼" /></a> --%>
	</sec:authorize>	  	
</div>	
	
</form:form>
<!-- //관리자 상세정보/수정 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

