<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<meta http-equiv="Content-Security-Policy"
  content="default-src 'self' 'unsafe-inline' https://attend.kduniv.ac.kr; 
  			script-src 'self' 'unsafe-inline' https://attend.kduniv.ac.kr;"
/>

<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM">
<script>location.href="${pageContext.request.contextPath }/muniv/main";</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
<script>location.href="${pageContext.request.contextPath }/prof/prof_mypage";</script>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_STUDENT">
<script>location.href="${pageContext.request.contextPath }/student/student_mypage";</script>
</sec:authorize>
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> 전자출결</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="shortcut icon" href="/resources/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sub_style.css">

<spring:eval expression="@config['chk_local']" var="chk_local"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/index.js"></script>

<c:if test="${not empty param.error}">
<script>
	window.onload=function() {alert('${error }');};
	//$(document).ready(function() { alert('${error }'); });
</script>
</c:if>
</head>

<body class="main_body">
<div id="wrap">
<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM,ROLE_PROF,ROLE_STUDENT">
<div id="header">
	<jsp:include page="header.jsp"></jsp:include>
</div>
</sec:authorize>
<div id="article">
<div id="contents">
	<!-- section -->
  <div id="main_container">
    <div id="content_left">
      <div class="left_top">
        <p class="float_left mg_t45"><img src="${pageContext.request.contextPath }/resources/images/index/visual_txt.gif" alt="복잡한 전자출결시스템은 이제그만!" /></p>
        <p><img src="${pageContext.request.contextPath }/resources/images/index/visual_bg.gif" alt="" /></p>
      </div>
      <div class="left_bottom">
        <p class="cube_01"><img src="${pageContext.request.contextPath }/resources/images/index/cube_01.gif" alt="" /></p>
        <p class="cube_02"><img src="${pageContext.request.contextPath }/resources/images/index/cube_02.gif" alt="" /></p>
        <p class="cube_03"><img src="${pageContext.request.contextPath }/resources/images/index/cube_03.gif" alt="" /></p>
        <p class="cube_04"><img src="${pageContext.request.contextPath }/resources/images/index/cube_04.gif" alt="" /></p>
        <p class="cube_05"><img src="${pageContext.request.contextPath }/resources/images/index/cube_05.png" alt="" /></p>
      </div>
    </div>
    </div>	
<%--
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
 --%>
	<!-- //section -->
</div>
</div>
<div id="right"><jsp:include page="aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="footer.jsp"></jsp:include></div>
</div>
<!-- <a href="http://localhost:8080/gw?portalid=A0264&tkey=2015071012&skey=480928e7e4ed8a180c99a4ab33e150f0">asdgfadfag</a> -->
</body>
</html>