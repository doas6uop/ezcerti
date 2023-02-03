<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    var regEmpPwd = /^[A-Za-z0-9]{6,20}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#student").serialize();
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
    }else if($("#student_passwd1").val()!=$("#student_passwd2").val()){
    	alert("비밀번호가 일치하지 않습니다.");
    	$("#student_passwd1").focus();
    	return false;
    }else if($("#student_passwd1").val()){
    	if(!regEmpPwd.test($("#student_passwd1").val())){

    		alert('6 ~ 20자의 영문/숫자 혼용만 사용가능합니다.');

            $("#student_passwd1").val('');

            $("#student_passwd1").focus();

            return false;
        }
    }
	
	if(r==true){   
			
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/student/info/student_modify",
	
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
	
	        url: "${pageContext.request.contextPath}/muniv/student/student_edit_confirm",
	
	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
	
	        success: function(msg) {
	        	alert(msg);
	        	//window.location.reload(true);
	        	document.location.replace('${pageContext.request.contextPath}/muniv/student/student_view?student_no=${student.student_no}');	        	
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
		}else if($("#email_addr").val()!='${student.email_addr}'){
			alert("수정완료 후 사용가능합니다.");
			event.preventDefault();
		}
		var r = confirm("등록된 이메일주소로 비밀번호가 초기화되어 발송됩니다.\n\n정확한 정보를 입력하고 발송해주십시오. \n\n임시번호를 발송하시겠습니까?");
		var postString = $("#student").serialize();
		if(r==true){   
		    
		    $.ajax({
		        type: "POST",
		
		        url: "${pageContext.request.contextPath}/muniv/student/student_resetpassword",
		
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
		var r = confirm("학번으로 비밀번호가 초기화됩니다.\n\n비밀번호를 초기화하시겠습니까?");
		var postString = $("#student").serialize();
		if(r==true){   
		    
		    $.ajax({
		        type: "POST",
		
		        url: "${pageContext.request.contextPath}/muniv/student/student_initpassword",
		
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
 
function studentOff(student_no){
  var r = confirm("휴학상태로 변경하시겠습니까?");
  if(r == true){
	  $.ajax({
		  type: "POST",
		  url : "${pageContext.request.contextPath}/muniv/student/student_off",
		  data : {student_no : student_no},
      success: function(msg) {
     			alert(msg);
     			window.location.reload(true);
     	},
      beforeSend: function() {
          //통신을 시작할때 처리
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
  }
} 
function studentQuit(student_no){
  var r = confirm("퇴학상태로 변경하시겠습니까?");
  if(r == true){
	  $.ajax({
		  type: "POST",
		  url : "${pageContext.request.contextPath}/muniv/student/student_quit",
		  data : {student_no : student_no},
      success: function(msg) {
     			alert(msg);
     			window.location.reload(true);
     	},
      beforeSend: function() {
          //통신을 시작할때 처리
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
  }
} 
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 학생정보변경 -->
<form:form commandName="student" onsubmit="javascript:sendAjax(); return false;">
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_student_title_03.png"  alt="학생정보변경타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp; 학생 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;학생정보변경 </td>
    </tr>
  </table>
</div>
<div class="round_box_top mg_t30 float_left"></div>
<div class="round_box_center float_left">
<table width="699" border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
  <tr>
    <th>학번</th>
    <td >
    	${student.student_no}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%-- <a href="javascript:initPassword()"><img src="${pageContext.request.contextPath}/resources/images/admin/pw_insert_button.png" width="105" height="20" alt="비밀번호초기화" /></a> --%>    	
    </td>
  </tr>
  <tr>
    <th>단과대학</th>
    <td>${student.coll_name}</td>
  </tr>
  <tr>
    <th>학과명</th>
    <td>${student.dept_name}</td>
  </tr>
  <tr>
    <th>이름</th>
    <td>${student.student_name }</td>
  </tr>
  <%-- <tr>
    <th>비밀번호</th>
    <td><form:password path="student_passwd" id="student_passwd1" cssClass="searchtextbox"/></td>
  </tr>
  <tr>
    <th>비밀번호확인</th>
    <td><input type="password" id="student_passwd2" class="searchtextbox"></td>
  </tr> --%>
  <tr>
    <th>연락처</th>
    <td><%-- ${student.hp_no} --%><form:input path="hp_no" cssClass="searchtextbox" /></td>
  </tr>
  <tr>
    <th>이메일</th>
    <td><%-- ${student.email_addr} --%><form:input path="email_addr" cssClass="searchtextbox"  /></td>
  </tr>
  <%-- 
  <tr>
    <th>국적</th>
    <td>
		<form:select path="nation_cd" cssClass="searchlistbox">
        <c:forEach var="code" items="${codeListG011}" >
    		<form:option value="${code.code }" >${code.code_name }</form:option>
        </c:forEach>
        </form:select>    
	</td>
  </tr>
  <tr>
    <th>학년</th>
    <td>
        <form:select path="student_grade_cd" cssClass="searchlistbox">
        <c:forEach var="code" items="${codeListG010}" >
    		<form:option value="${code.code }" >${code.code_name }</form:option>
        </c:forEach>
        </form:select>    
	</td>
  </tr>
   --%>
  <tr>
    <th>상태</th>
    <td>${student.student_sts_name }/${student.student_grade_name}</td>
  </tr>
  <%-- 
  <tr>
    <th>등록일</th>
    <td>${student.reg_date}</td>
  </tr>
   --%>
</table>
</div>
<div class="round_box_bottom float_left"></div>

<div class="aligncenter">
	<a href="javascript:history.back(-1)">
		<img src="${pageContext.request.contextPath}/resources/images/admin/cancel_button.png" width="61" height="27" alt="목록버튼" />
	</a> &nbsp;
	<form:button><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button.png" alt="수정버튼" /></form:button>
	<!-- 
	<sec:authorize ifAnyGranted="ROLE_SYSTEM">
		<c:if test="${student.student_sts_cd !='G012C002'}">
			<img src="${pageContext.request.contextPath }/resources/images/admin/button_student_off.png" onclick="studentOff('${student.student_no }')" style="cursor: pointer" alt="휴학처리">&nbsp;
		</c:if>	
		<c:if test="${student.student_sts_cd !='G012C003'}">
			<img src="${pageContext.request.contextPath }/resources/images/admin/button_student_quit.png" onclick="studentQuit('${student.student_no }')" style="cursor: pointer" alt="퇴학처리">
		</c:if>
	</sec:authorize>
	-->
</div>
<%-- <form:hidden path="student_no"/> --%>
<form:hidden path="student_name"/>
<input type="hidden" id="student_no" name="student_no" value="${student.student_no}" />
</form:form>
<div id="ajax_indicator" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" /><br>
   	처리중입니다.
   </p>
</div>	
	<!-- //학생정보변경 -->
	
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

