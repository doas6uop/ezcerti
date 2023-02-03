<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/iscroll.js"></script-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/categorylayer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script>
$(document).ready(function(){
	$("#topmenu_01").removeClass('submenugrayfont').addClass('menubluefont');
	
	setInterval("location.reload();", 180000);
});
var myScroll;
</script>

</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../header.jsp"></jsp:include>
</div>
<!-- 마이페이지 -->
<form>
<input type="hidden" name="classday" id="classday">
</form>
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" width="100%;"	margin="0;"	auto="text-align: center;" style="max-width:13px;" alt="아이콘">&nbsp; 오늘의 강의</div>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5%">
    <c:if test="${not empty lectureDay.class_prev}">
    <div class="visual">
    <a href="${pageContext.request.contextPath}/m/prof/prof_mypage?classday=${lectureDay.class_prev }"><img src="${pageContext.request.contextPath}/resources_m/images/beforeb_button.png" style="max-width:45px;" alt="이전버튼"></a>
    </div>
    </c:if>
    </td>
    <td width="90%" align="center" class="blackboldfont">${lectureDay.classday } (${lectureDay.classday_name})</td>
    <td width="5%" align="right">
    <c:if test="${not empty lectureDay.class_next}">
    <div class="visual">
    <a href="${pageContext.request.contextPath}/m/prof/prof_mypage?classday=${lectureDay.class_next }"><img src="${pageContext.request.contextPath}/resources_m/images/nextb_button.png" style="max-width:45px;" alt="다음버튼"></a>
    </div>
    </c:if>
    </td>
  </tr>
</table>
<div class="tablelayout">
<c:forEach var="list" items="${attendList}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subgraybox">
  <tr>
    <td width="17%" rowspan="2" align="center" valign="middle" class="leftgraybox">${list.class_type_name }<br>
      ${list.class_sts_name }</td>

    <td colspan="2" height="33" class="graysmallfont">
        <c:if test="${list.is_team == 'Y'}">*팀티칭</c:if><br/>
    	<a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${list.classday }&class_cd=${list.class_cd }&classhour_start_time=${list.classhour_start_time}"><font style="font-size:14px; font-weight:bold">${list.class_name }</font><br/>(${list.classroom_no})</a>
    </td>
<%--정상,보강 --%>
<c:if test="${list.class_type_cd=='G019C001'||list.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>
	<c:if test="${makeup_lesson eq 'Y' }">
		<c:if test="${list.class_sts_cd=='G020C001'&&list.class_type_cd=='G019C001' }">
			<td width="27%" rowspan="2">
				<c:if test="${list.classoff_yn eq 'Y'}">
					<c:choose>
						<c:when test="${list.class_prog_cd eq 'G018C003'}">
							<c:set var="classOffText" value="휴강<br>신청중" />
						</c:when>
						<c:otherwise>
							<c:set var="classOffText" value="휴강<br>신청" />
						</c:otherwise>
					</c:choose>
				</c:if>					
			
				<div class="rightbluebox" onclick="skipLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.class_prog_cd}','${list.classroom_no}')">
				${classOffText}
		    	</div>
		    </td>
		</c:if>
		<c:if test="${list.class_sts_cd=='G020C001'&&list.class_type_cd=='G019C003' }">
			<td width="27%" rowspan="2">
				<div class="rightbluebox">
				강의<br>이전
		    	</div>
	        </td>
		</c:if>
	</c:if>	
	<%--//강의전 --%>
	<%--강의중 --%>
	<c:if test="${list.class_sts_cd=='G020C002' }">
		<!-- 2015.02.02 (인증처리 하도록 수정)
		- 인증요청 전인 경우 항상 강의인증 버튼 표시
		- 인증요청 후인 경우  
		- CERT_TYPE이 CERT_NUM인 경우만 강의인증 버튼 표시
		- CERT_TYPE이 PROF_AUTH인 경우 강의중으로 표시
		-->
	
		<%--인증요청전 --%>
		<c:if test="${list.cert_sts_cd=='G021C001' }">
		    <td width="27%" rowspan="2">
		    	<div class="rightdeepbbox" onclick="certType('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.cert_sts_cd }')">
		    		강의<br>시작
		    	</div>
		    </td>	    
	    </c:if>
		<%--//인증요청전 --%>

		<%--인증요청후 --%>
		<c:if test="${list.cert_sts_cd=='G021C002'}">
			<c:choose>
				<c:when test="${list.cert_type eq 'CERT_NUM'}">
					<td width="27%" rowspan="2" class="listpurplebox">
						<div class="rightpurplebox" onclick="certLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.cert_sts_cd }')">
				    		인증코드<br>확인
				    	</div>
				    </td>
				</c:when>
				<c:when test="${list.cert_type eq 'PROF_AUTH'}">
					<td width="27%" rowspan="2" class="listpurplebox">
						<div class="rightpurplebox">
				    		강의중
				    	</div>
				    </td>
				</c:when>
				<c:when test="${list.cert_type eq 'BEACON_AUTH'}">
					<td width="27%" rowspan="2" class="listpurplebox">
						<div class="rightpurplebox">
				    		강의중
				    	</div>
				    </td>
				</c:when>
			</c:choose>
		</c:if>
		<%--//인증요청후 --%>
	</c:if>
	<%--//강의중 --%>
	<%--강의완료 --%>
	<c:if test="${list.class_sts_cd=='G020C003' }">
		<c:set var="varClassStatus" value="강의<br/>종료" />
		<c:if test="${list.class_type_cd ne 'G019C002' and list.class_sts_cd eq 'G020C003' and empty list.cert_type}">
			<c:set var="varClassStatus" value="<font style='color:rgba(219, 36, 39, 1);'>결강<br/>(출결미처리)</font>" />
		</c:if>									
	
		<td width="27%" rowspan="2" class="listgraybigbox"><div class="whiterightbox">${varClassStatus}</div></td>
	</c:if>
	<%--//강의완료 --%>
</c:if>
<%--//정상,보강 --%>
<%--휴강 --%>
<c:if test="${list.class_type_cd=='G019C002' }">
	<%--보강 없음 --%>
	<c:if test="${empty list.before_classday }">
	<td width="27%" rowspan="2"><div class="rightyellowbox">보강정보<br><br>
    없음</div></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty list.before_classday }">
	<td width="27%" rowspan="2"><div class="rightyellowbox">보강정보<br>
    <fmt:formatDate value="${list.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
    <fmt:formatDate value="${list.before_classday}" type="time" pattern="(E) HH:mm"/></div></td>
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>    
  </tr>
  <tr>
    <td width="43%"><a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${list.classday }&class_cd=${list.class_cd }&classhour_start_time=${list.classhour_start_time}">
    	<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
    	<c:set var="view_week" value="${list.curr_week}" />
    	<c:if test="${view_week eq '16'}">
    		<c:set var="view_week" value="${view_week - 1}" />
    	</c:if>
    	    
		&nbsp;<c:if test="${list.curr_week ne null && !empty list.curr_week}">(${view_week})</c:if>
    	${list.classday}<fmt:formatDate value="${list.classday}" type="time" pattern="(E)"/> ${list.classhour_start_time }</a>
    </td>
    <td width="12%" align="right">${list.attendee_cnt }명</td>  
  </tr>
</table>
</c:forEach>
<c:if test="${empty attendList }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
</div>
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" width="100%;" margin="0;"	auto="text-align: center;" style="max-width:13px;" alt="아이콘">&nbsp; 강의 목록</div>
<div class="tablelayout">
<c:forEach var="list" items="${lectureList }">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subgraybox" onclick="$(this).removeClass('subgraybox').addClass('subbluebox');location.href='${pageContext.request.contextPath}/prof/class/class_list?class_cd=${list.class_cd}'">
  <tr>
    <td width="11%" rowspan="2" align="center" valign="middle">
    <div class="numberbox">${list.row_no }</div></td>
    <td colspan="3" style="padding:5px 0 5px 0">&nbsp;${list.class_name}<c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if></td>
    <td width="11%" rowspan="2" align="center" valign="middle">
    <div class="visual">
    <img src="${pageContext.request.contextPath}/resources_m/images/blue_circleb_b_icon.png" style="max-width:23px;" alt="화살표아이콘">
    </div>
    </td>
  </tr>
  <tr class="graysmallfont">
    <td width="40%" height="20">
	    &nbsp;${list.classday_name }요일 ${list.classhour_start_time } ~ ${list.classhour_end_time }
	    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td width="22%" height="20" align="right">${list.subject_cd }-${list.subject_div_cd }</td>
    <td width="16%" height="20" align="right">${list.attendee_cnt }명</td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty lectureList }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subgraybox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<br>
</div>
<div id="dialog_skip_lecture1" title="휴강처리">
	<div id="ajax_indicator1" style="/* display: none; */">
		<p style="text-align:center; padding:16px 0 0 0; left:48%; top:48%; position:absolute;">
			<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
		</p>
	</div>
</div>	
<div id="dialog_skip_lecture2" title="휴강처리"></div>	
<div id="dialog_cert_lecture0" title="강의인증"></div>	
<div id="dialog_cert_lecture1" title="강의인증"></div>	
<div id="dialog_cert_lecture2" title="강의인증"></div>	
<div id="dialog_cert_lecture3" title="강의인증"></div>	

<!-- //마이페이지 -->
<div>
	<jsp:include page="../footer.jsp"></jsp:include>
</div>
</body>
</html>
