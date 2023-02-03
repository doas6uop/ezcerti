<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<script>
$(document).ready(function(){
	$(".menu11 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_mypage_on.gif");
	$(".menu11 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_mypage_on.gif");
	
	setInterval("location.reload();", 180000);
});

$(function() {
	$.datepicker.regional['ko'] = {
	        closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
	        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        dateFormat: 'yy-mm-dd (DD)',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '',
	        showOn: 'focus',
	        changeMonth: true,
	        changeYear: false,
	        showButtonPanel: false,
	        yearRange: 'c-1:c+1'
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);	    
	    $('#selectedDate').datepicker({
    		onSelect: function(dateText) {
    			location.href = "/prof/prof_mypage?classday="+dateText.substring(0, 10);
    		}
	    });
	});
</script>

</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 마이페이지 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/professor_mypage_title_01.png" width="128" height="20" alt="오늘의 강의 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;마이페이지</td>
    </tr>
  </table>
</div>
<br />
<form>
<input type="hidden" name="classday" id="classday">

</form>
<table width="680" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="61">
    <c:if test="${not empty lectureDay.class_prev}">
    	<a href="${pageContext.request.contextPath}/prof/prof_mypage?classday=${lectureDay.class_prev }"><img src="${pageContext.request.contextPath}/resources/images/prof/before_button.png" width="61" height="27" alt="이전버튼" /></a>
    </c:if>
    </td>
    <td width="615" align="center" class="bigfont">
   		<c:set var="selectedDate" value="${lectureDay.myclassday} (${lectureDay.classday_name})"/>
    	<input type="text" class="inputWithImge" id="selectedDate" name="selectedDate" value="${selectedDate}" style="background-image:url(/resources/images/admin/calendar-month.png);background-repeat:no-repeat;background-position:right; background-size: 18px 18px; width:150px; font-weight:bold; font-size:18px; background-color: transparent; border: 0px solid; color: #000000;" readonly="readonly">
    </td>
    <td width="10">
    <c:if test="${not empty lectureDay.class_next}">
    	<a href="${pageContext.request.contextPath}/prof/prof_mypage?classday=${lectureDay.class_next }"><img src="${pageContext.request.contextPath}/resources/images/prof/next_button.png" width="61" height="27" alt="다음버튼" /></a>
   	</c:if>
    </td>
  </tr>
</table>
<c:forEach var="list" items="${attendList}">

<table width="680" height="87" border="0" cellpadding="0" cellspacing="0" class="graybox">
  <tr>
    <td width="86" rowspan="2" align="center" valign="middle" class="listleftbg">${list.class_type_name }<br />
      ${list.class_sts_name }</td>
    <td align="left" valign="middle" class="blackfont">
    <a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${list.classday }&class_cd=${list.class_cd }&classhour_start_time=${list.classhour_start_time}">${list.class_name }  (${list.classroom_no})</a></td>
    <td align="right" class="blackfont">${list.subject_cd }-${list.subject_div_cd }</td>
<%--정상,보강 --%>
<c:if test="${list.class_type_cd=='G019C001'||list.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>
	
	<c:if test="${list.class_sts_cd=='G020C001'&&list.class_type_cd=='G019C001' }">
	    <!-- td width="130" rowspan="2" align="center" valign="middle" class="listrightblue" style="cursor: pointer;" onclick="skipLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.class_prog_cd}','${list.classroom_no}')"-->
	    <td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">
			<table border="0">
				<tr height="30">
					<td style="font-size: 16px;font-weight:bold;padding:10px 0 5px 0" align="center">강의전</td>
				</tr>
				<c:if test="${makeup_lesson eq 'Y' and list.classoff_yn eq 'Y'}">
					<c:choose>
						<c:when test="${list.class_prog_cd eq 'G018C003'}">
							<c:set var="classOffText" value="휴강신청중" />
						</c:when>
						<c:otherwise>
							<c:set var="classOffText" value="휴강신청" />
						</c:otherwise>
					</c:choose>
					<tr>
						<td><hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" /></td>
					</tr>
					<tr>
						<td  align="center">${classOffText}</td>
					</tr>
				</c:if>
			</table>
	    </td>
	</c:if>		
	<c:if test="${list.class_sts_cd=='G020C001'&&list.class_type_cd=='G019C003' }">
		<td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">보강정보 
	        <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
	        강의전
        </td>
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
	    	<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb" style="cursor: pointer;" onclick="certType('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.cert_sts_cd }')">강의시작</td>	    
	    </c:if>
		<%--//인증요청전 --%>
		<%--인증요청후 --%>
		<c:if test="${list.cert_sts_cd=='G021C002'}">
			<c:choose>
				<c:when test="${list.cert_type eq 'BEACON_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb">강의중</td>
				</c:when>
				<c:when test="${list.cert_type eq 'CERT_NUM'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightpurple" style="cursor: pointer;" onclick="certLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.cert_sts_cd }')">인증코드확인</td>
				</c:when>
				<c:when test="${list.cert_type eq 'PROF_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb">강의중</td>
				</c:when>
			</c:choose>
		</c:if>
		<%--//인증요청후 --%>
	</c:if>
	<%--//강의중 --%>
	<%--강의완료 --%>
	<c:if test="${list.class_sts_cd=='G020C003' }">
		<c:set var="varClassStatus" value="강의종료" />
		<c:if test="${list.class_type_cd ne 'G019C002' and list.class_sts_cd eq 'G020C003' and empty list.cert_type}">
			<c:set var="varClassStatus" value="<font style='color:rgba(219, 36, 39, 1);'>결강<br/>(출결미처리)</font>" />
		</c:if>									
	
		<c:if test="${list.class_type_cd=='G019C001' }">
		    <!-- td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox" style="cursor: pointer;" onclick="skipLecture('${list.class_cd}','${list.classday}','${list.classhour_start_time}','${list.class_prog_cd}','${list.classroom_no}')"-->
		    <td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox">
				<table border="0">
					<tr height="30">
						<td style="font-size: 16px;font-weight:bold;padding:10px 0 5px 0" align="center">${varClassStatus}</td>
					</tr>
					<c:if test="${makeup_lesson eq 'Y' and list.classoff_yn eq 'Y'}">	
						<c:choose>
							<c:when test="${list.class_prog_cd eq 'G018C003'}">
								<c:set var="classOffText" value="휴강신청중" />
							</c:when>
							<c:otherwise>
								<c:set var="classOffText" value="휴강신청" />
							</c:otherwise>
						</c:choose>
						<tr>
							<td><hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" /></td>
						</tr>
						<tr>
							<td  align="center">${classOffText}</td>
						</tr>
					</c:if>						
				</table>
		    </td>
		</c:if>
		<c:if test="${list.class_type_cd=='G019C003' }">
			<td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox">보강정보 
		        <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
		        ${varClassStatus}
	        </td>
		</c:if>
	</c:if>
	<%--//강의완료 --%>
</c:if>
<%--//정상,보강 --%>
<%--휴강 --%>
<c:if test="${list.class_type_cd=='G019C002' }">
	<%--보강 없음 --%>
	<c:if test="${empty list.before_classday }">
		<td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보
		<hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
    없음<br></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty list.before_classday }">
	 <td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보 
	 <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
	 <fmt:formatDate value="${list.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
	 
		<c:choose>
			<c:when test="${list.class_prog_cd eq 'G018C004'}">
				(취소신청중)
			</c:when>
			<c:otherwise>
				<fmt:formatDate value="${list.before_classday}" type="time" pattern="(E) HH:mm"/>
			</c:otherwise>
		</c:choose>
	 
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>
  </tr>
  <tr>
    <td width="350" height="37" align="left" valign="top" class="grayfont">
    	<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
    	<c:set var="view_week" value="${list.curr_week}" />
    	<c:if test="${view_week eq '16'}">
    		<c:set var="view_week" value="${view_week - 1}" />
    	</c:if>
	    <c:if test="${list.curr_week ne null && !empty list.curr_week}">[${view_week}주차]</c:if>    
	    <a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${list.classday }&class_cd=${list.class_cd }&classhour_start_time=${list.classhour_start_time}">
	    ${list.classday} <fmt:formatDate value="${list.classday}" type="time" pattern="(E)"/> ${list.classhour_start_time } ~ ${list.classhour_end_time }</a>
	    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td width="74" height="37" align="right" valign="top" class="grayfont">${list.attendee_cnt }명</td>
  </tr>
</table>
</c:forEach>  
<c:if test="${empty attendList }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>

<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/professor_mypage_title_02.png" alt="강의목록 타이틀" /></td>
    </tr>
  </table>
</div>
<br />
<c:forEach var="list" items="${lectureList }">
<c:set var="lec_year" value="${fn:substring(list.class_cd,9,13)}"/>
<c:set var="lec_hakgi" value="${fn:substring(list.class_cd,14,22)}"/>

<c:choose>
	<c:when test="${lec_hakgi eq 'G002C001'}">
		<c:set var="lec_hakgi" value="1"/>
	</c:when>
	<c:otherwise>
		<c:set var="lec_hakgi" value="2"/>
	</c:otherwise>
</c:choose>

<table width="680" height="77" border="0" cellpadding="0" cellspacing="0" class="graybox" style="cursor: pointer;">
  <tr>
    <td width="60" rowspan="2" align="center" valign="middle" onclick="location.href='${pageContext.request.contextPath}/prof/class/class_list?class_cd=${list.class_cd}'"><div class="bluesquare">${list.row_no }</div></td>
    <td colspan="2" align="left" class="blackfont" onclick="location.href='${pageContext.request.contextPath}/prof/class/class_list?class_cd=${list.class_cd}'">${list.class_name}</td>
    <td align="right" class="blackfont">${list.subject_cd }-${list.subject_div_cd }</td>
    <td width="100" rowspan="2" align="center" valign="middle">
    	<img src="${pageContext.request.contextPath}/resources/images/prof/list_right_arrow_icon.png" width="28" height="28" alt="회색화살표아이콘" onclick="location.href='${pageContext.request.contextPath}/prof/class/class_list?class_cd=${list.class_cd}'" />
    </td>
  </tr>
  <tr onclick="location.href='${pageContext.request.contextPath}/prof/class/class_list?class_cd=${list.class_cd}'">
    <td width="326" height="39" align="left" class="grayfont">${list.classday_name }요일 ${list.classhour_start_time } ~ ${list.classhour_end_time }
    <c:if test="${list.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td width="97" height="39" align="right" class="grayfont"></td>
    <td width="97" height="39" align="right" class="grayfont">${list.attendee_cnt }명</td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty lectureList }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>

<!-- //강의목록 -->
<br>
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
<!-- //교수 마이페이지 -->
</div>
</div>
<div id="right"><jsp:include page="../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

