<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sub_style.css">
<style>
img { border:0 }

.titlebg {
	background-image: url(${pageContext.request.contextPath }/resources/images/common/sub_title_bg.jpg);
	background-repeat: no-repeat;
	background-position: left bottom;
	height: 94px;
	width: 700px;
	text-align: center;
	font-family: "돋움", "돋움체";
	font-size: 12px;
	color: #515151;
}
.ddivback {
	background-image: url(${pageContext.request.contextPath }/resources/images/common/back_01.jpg);
	background-repeat: no-repeat;
	height: 148px;
	width: 710px;
	margin-top: 10px;
	margin-bottom: 10px;
}
.pdivback {
	background-image: url(${pageContext.request.contextPath }/resources/images/common/back_02.jpg);
	height: 148px;
	width: 710px;
	margin-top: 15px;
	margin-bottom: 15px;
}
.idivback {
	background-image: url(${pageContext.request.contextPath }/resources/images/common/back_03.jpg);
	background-repeat: no-repeat;
	height: 148px;
	width: 710px;
	margin-top: 15px;
	margin-bottom: 15px;
}
.numbertable {
	font-family: "돋움", "돋움체";
	font-size: 12px;
	line-height: 10px;
	font-weight: bold;
	color: #6D6D6D;
	width: 580px;
	border: 1px solid #54AEC7;
	margin-top: 20px;
	margin-left: 98px;
}
.bluefont {
	font-family: "굴림", "굴림체", "바탕";
	font-size: 13px;
	font-weight: bold;
	color: #0C91CD;
}
</style>
<script>
$(document).ready(function(){
});
</script>
<!-- cache-control -->
<% 
	response.setHeader("Cache-Control","no-store"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0); 
	if (request.getProtocol().equals("HTTP/1.1")) response.setHeader("Cache-Control", "no-cache"); %>
</head>

<body class="sub_body">
<div id="wrap">
<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM,ROLE_PROF,ROLE_STUDENT">
<div id="header">
	<jsp:include page="header.jsp"></jsp:include>
</div>
</sec:authorize>
<div id="article">
<div id="contents">
<!-- section -->
<div class="titlebg" style="margin-top:20px;">
	<table width="670" border="0" cellpadding="0" cellspacing="0" >
		<tr>
			<td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath }/resources/images/common/sub_center_title.png" width="110" height="20" alt="고객센터 타이틀" /></td>
			<td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath }/resources/images/common/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;고객센터&nbsp;  <img src="${pageContext.request.contextPath }/resources/images/common/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 고객센터</td>
		</tr>
	</table>
</div>
<br />
<div class="ddivback">
	<table width="605" border="0" align="left" cellpadding="0" cellspacing="0" class="numbertable">
		<tr>
			<td width="35" height="30" align="center"><img src="${pageContext.request.contextPath }/resources/images/common/icon.png" width="15" height="17" alt="아이콘" /></td>
			<td width="300" align="left">출결관련문의</td>
			<td width="305" align="left" class="bluefont">&nbsp;</td>
		</tr>
		<tr>
			<td width="35" height="20" align="center"></td>
			<td width="300" align="left">: 담당교수, 각 학과사무실</td>
			<td width="305" align="left" class="bluefont">&nbsp;</td>
		</tr>
	</table>
</div>
<div class="pdivback">
	<table width="605" border="0" align="left" cellpadding="0" cellspacing="0" class="numbertable">
		<tr>
			<td width="35" height="30" align="center"><img src="${pageContext.request.contextPath }/resources/images/common/icon.png" width="15" height="17" alt="아이콘" /></td>
			<td width="300" align="left">개인정보관련문의(개인정보분실)</td>
			<td width="305" align="left" class="bluefont"><spring:eval expression="@config['univ_title']"/></td>
		</tr>
		<tr>
			<td width="35" height="20" align="center"></td>
			<td width="300" align="left">: 경동대학교 교무처 033-738-1200</td>
			<td width="305" align="left" class="bluefont">&nbsp;</td>
		</tr>	
	</table>
</div>
<div class="idivback">
	<table width="605" border="0" align="left" cellpadding="0" cellspacing="0" class="numbertable">
		<tr>
			<td width="35" height="30" align="center"><img src="${pageContext.request.contextPath }/resources/images/common/icon.png" width="15" height="17" alt="아이콘" /></td>
			<td width="300" align="left">시스템장애 및 문의</td>
			<td width="305" align="left" class="bluefont">(주)씨딘 02-6925-6005</td>
		</tr>
		<tr>
			<td width="35" height="20" align="center"></td>
			<td width="300" align="left">: 경동대학교 교무처 033-738-1200</td>
			<td width="305" align="left" class="bluefont">&nbsp;</td>
		</tr>	
	</table>
</div>
<!-- //section -->
</div>
</div>
<div id="right"><jsp:include page="aside1.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="footer.jsp"></jsp:include></div>
</div>
</body>
<div id="not_visible"></div>
</html>