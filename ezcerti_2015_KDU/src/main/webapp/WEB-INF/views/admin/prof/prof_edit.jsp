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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu2 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif");
	$(".menu2 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_02.gif");
});
function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    //var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;
    var regEmpPwd = /^[a-z]+[a-z0-9]{5,19}$/g;
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
		/* 
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/prof/prof_edit_confirm",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	alert(msg);
	        	//window.location.reload(true);
	        	document.location.replace('${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${prof.prof_no}');
	        },
	        error: function(msg){
	        	alert(msg);
	        }
	
	    });
	     */
	}

 };
function resetPassword(){
	if(!$("#email_addr").val()){
    	alert("이메일 정보가 없습니다.");
    	$("#email_addr").focus();
    	event.preventDefault();
	}else if($("#email_addr").val()!='${prof.email_addr}'){
		alert("수정완료 후 사용가능합니다.");
		event.preventDefault();
	}
	var r = confirm("등록된 이메일주소로 비밀번호가 초기화되어 발송됩니다.\n\n정확한 정보를 입력하고 발송해주십시오. \n\n임시번호를 발송하시겠습니까?");
	var postString = $("#prof").serialize();
	if(r==true){   
	    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/prof/prof_resetpassword",
	
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
}

function initPassword(){

	var r = confirm("교수코드로 비밀번호가 초기화됩니다.\n\n비밀번호를 초기화하시겠습니까?");
	var postString = $("#prof").serialize();
	if(r==true){   
	    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/prof/prof_initpassword",
	
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
}

function initTermEnd(){

	var r = confirm("마감을 취소하시겠습니까?");
	var postString = $("#prof").serialize();
	if(r==true){   
	    
	    $.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/muniv/prof/prof_initTermEnd",
	
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
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 교수정보변경 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_professor_title_03.png"  alt="교수상세정보타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통합검색&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;교수정보변경 </td>
    </tr>
  </table>
</div>
<form:form commandName="prof" onsubmit="javascript:sendAjax(); return false;">
<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">

<c:set var="profAdmCd" value="" />
<c:if test="${prof.prof_adm_cd eq 'G026C002'}">
	<c:set var="profAdmCd" value="<font color='#0000FF'><a href='javascript:initTermEnd()'>[마감취소]</a></font>" />
	<form:hidden path="prof_adm_cd"/>
</c:if>


  <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
  <tr>
    <th>사번</th>
    <td >
    	${prof.prof_no }&nbsp;
    <!--<a href="javascript:resetPassword()"><img src="${pageContext.request.contextPath}/resources/images/admin/pw_insert_button.png" width="105" height="20" alt="비밀번호초기화" /></a>-->
    <!--<a href="javascript:initPassword()"><img src="${pageContext.request.contextPath}/resources/images/admin/pw_insert_button.png" width="105" height="20" alt="비밀번호초기화" /></a>-->    	
    <!-- <font color='#0000FF'><a href="javascript:initPassword()">[비밀번호 초기화]</a></font> -->  	
    </td>
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
  <%-- <tr>
    <th>비밀번호</th>
    <td><form:password path="prof_passwd" id="prof_passwd1" cssClass="searchtextbox"/></td>
  </tr>
  <tr>
    <th>비밀번호확인</th>
    <td><input type="password" id="prof_passwd2" class="searchtextbox"></td>
  </tr> --%>
  <tr>
    <th>연락처</th>
    <td><form:input path="hp_no" cssClass="searchtextbox" /></td>
  </tr>
  <tr>
    <th>이메일</th>
    <td><form:input path="email_addr" cssClass="searchtextbox"  /></td>
  </tr>
  <tr>
    <th>상태</th>
    <td>${prof.prof_sts_cd }&nbsp;${profAdmCd}</td>
  </tr>
  <tr>
    <th>등록일</th>
    <td>${prof.reg_date }</td>
  </tr>
</table>
</div>
<div class="round_box_bottom float_left"></div>

<div class="aligncenter">
	<a href="javascript:history.back(-1)"><img src="${pageContext.request.contextPath}/resources/images/admin/cancel_button.png" width="61" height="27" alt="목록버튼" /></a> &nbsp;
	<form:button><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button.png" alt="수정버튼" /></form:button>
</div>
<form:hidden path="prof_no"/>
<form:hidden path="prof_name"/>
</form:form>
	<!-- //교수정보변경 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

