<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<c:if test="${empty PROF_INFO.passwd_mod_date }">
<script>
//alert("개인정보보호를 위해 비밀번호를 변경해주십시오.");
</script>
</c:if>	
<script>
$(document).ready(function(){
		$(".menu14 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_info_on.gif");
		$(".menu14 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_info_on.gif");
});

function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    //var regEmpPwd = /(?=([a-zA-Z0-9].*(\W))|((\W).*[a-zA-Z0-9])$).{6,20}/;
    //var regEmpPwd = /^[A-Za-z0-9]{8,20}$/;
	var regEmpPwd = /^[a-z]+[a-z0-9]{5,19}$/g;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#prof").serialize();
    var r = confirm("변경하시겠습니까?");

    if(!$("#hp_no").val()){
    	alert("전화번호를 입력하세요.");
    	$("#hp_no").focus();
    	return false;
    }else if(!regExp.test($("#hp_no").val())){
    	alert("잘못된 전화번호입니다.");
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

            alert('영문자로 시작하는 6~20자 영문자 또는 숫자만 사용가능합니다.');

            $("#prof_passwd1").val('');
            $("#prof_passwd2").val('');
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 개인정보관리 -->
<form:form commandName="prof" onsubmit="javascript:sendAjax(); return false;">
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/prof/professor_personal_title_01.png" alt="수강생목록 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;개인정보관리&nbsp;  <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 정보변경</td>
    </tr>
  </table>
</div>


<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">
  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
  <tr>
    <th>사번</th>
    <td >${prof.prof_no }</td>
  </tr>
  <tr>
    <th>단과대학</th>
    <td>${prof.coll_name }</td>
  </tr>
  <tr>
    <th>학과명</th>
    <td>${prof.dept_name }</td>
  </tr>
  <tr>
    <th>교수명</th>
    <td>${prof.prof_name }</td>
  </tr>
  <!-- 
  <tr>
    <th>비밀번호</th>
    <td><form:password path="prof_passwd" id="prof_passwd1" cssClass="searchtextbox"/></td>
  </tr>
  <tr>
    <th>비밀번호확인</th>
    <td><input type="password" id="prof_passwd2" class="searchtextbox"></td>
  </tr>
  <tr>
    <th>연락처</th>
    <td><form:input path="hp_no" cssClass="searchtextbox"/></td>
  </tr>
  <tr>
    <th>이메일</th>
    <td><form:input path="email_addr" cssClass="searchtextbox" /></td>
  </tr>
  -->  
  <tr>
    <th>연락처</th>
    <td>${prof.hp_no}</td>
  </tr>
  <tr>
    <th>이메일</th>
    <td>${prof.email_addr}</td>
  </tr>
  <tr>
    <th>상태</th>
    <td>${prof.prof_sts_cd }</td>
  </tr>
</table>
</div>
<div class="round_box_bottom float_left"></div>

<div class="alignright">
<!-- 
<a href="javascript:window.location.href=parent.document.referrer;"><img src="${pageContext.request.contextPath}/resources/images/prof/cancel_button.png" width="61" height="27" alt="취소버튼" /></a>&nbsp;&nbsp;
-->
<!-- 개인정보를 변경하지 못하도록 버튼 제거 (동기화 작업으로 대체 - 2016.10.13) 
<form:button>
	<img src="${pageContext.request.contextPath}/resources/images/prof/class_button_04.png" width="78" height="27" alt="변경완료버튼" />
</form:button>
-->
</div>
</form:form>
<!-- //교수 개인정보관리 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>