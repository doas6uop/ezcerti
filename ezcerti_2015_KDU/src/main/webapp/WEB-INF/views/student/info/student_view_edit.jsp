<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/student_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<c:if test="${empty sessionScope.STUDENT_INFO.passwd_mod_date }">
<script>
//alert("개인정보보호를 위해 비밀번호를 변경해주십시오.");
</script>
</c:if>	
<script>
$(document).ready(function(){
	$(".menu23 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_info_on.gif");
	$(".menu23 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_info_on.gif");
	
	var otherImg = "";
	$('.photo_area img').error(function() {
		otherImg = $(this).attr('src');
		
		if(otherImg.indexOf(".JPG") < 0) {
			otherImg = otherImg.replace(".jpg", ".JPG");
		} else {
			otherImg = '${pageContext.request.contextPath}/resources/images/noimage.jpg';
		}

		$(this).attr('src', otherImg);		
	    //$(this).attr('src', '${pageContext.request.contextPath}/resources/images/noimage.jpg');
	 }).each(function(n) {
	   $(this).attr('src', $(this).attr('src'));
	});
	
});
function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	//var regEmpPwd = /(?=([a-zA-Z0-9].*(\W))|((\W).*[a-zA-Z0-9])$).{6,20}/;
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
	}

 };
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 학생 개인정보관리 -->
<spring:eval expression="@config['user_image_path']" var="user_image_path"/>

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/student/professor_personal_title_01.png" alt="수강생목록 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;개인정보관리&nbsp;  <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 정보변경</td>
    </tr>
  </table>
  </div>
  <form:form commandName="student" onsubmit="javascript:sendAjax(); return false;">
    <div class="round_box_top mg_t30 float_left"></div>
    <div class="round_box_center float_left">
    
		<c:set var="varStudentYear" value="${student.iphak_year}" />
    	
    	<c:choose>
	    	<c:when test="${student.student_img eq null}">
	    		<c:set var="student_photo" value="${pageContext.request.contextPath}/resources/images/noimage.jpg" />
	    	</c:when>
	    	<c:otherwise>
	    		<c:set var="student_photo" value="${user_image_path}?platformType=nexacro&method=view&f0=${student.student_img}" />
	    	</c:otherwise>
    	</c:choose>
    	
        <div class="photo_area"><img src="${student_photo}" width="115" height="140" alt="사진이미지" /></div>
        <div class="info_area">
            <table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1">
              <tr>
                <th>학 번</th>
                <td >${student.student_no}</td>
              </tr>
              <tr>
                <th>단과대학</th>
                <td>${student.coll_name }</td>
              </tr>
              <tr>
                <th>학과명</th>
                <td>${student.dept_name}</td>
              </tr>
              <tr>
                <th>이름</th>
                <td>${student.student_name}</td>
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
                <td>${student.hp_no}<%-- <form:input path="hp_no" cssClass="searchtextbox" /> --%></td>
              </tr>
              <tr>
                <th>이메일</th>
                <td>${student.email_addr}<%-- <form:input path="email_addr" cssClass="searchtextbox"  /> --%></td>
              </tr>
              <%-- 
              <tr>
                <th>국적</th>
                <td>${student.nation_name}</td>
              </tr>
              --%>
              <tr>
                <th>상태</th>
                <td>${student.student_sts_name}/${student.student_grade_name}</td>
              </tr>
            </table>
        </div>
      </div>
      <div class="round_box_bottom float_left"></div>

  



<div class="alignright float_left">
	<%-- <form:button><img src="${pageContext.request.contextPath}/resources/images/student/class_button_04.png" width="78" height="27" alt="변경완료버튼" /></form:button>&nbsp; --%>
	<!-- 
	<a href="javascript:window.location.href=parent.document.referrer;"><img src="${pageContext.request.contextPath}/resources/images/student/cancel_button.png" width="61" height="27" alt="취소버튼" /></a>
	-->
</div>
	
</form:form>
<!-- //학생 개인정보관리 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>