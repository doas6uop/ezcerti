<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/prof_cert.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">

<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>

<script>
$(document).ready(function(){
	$(".menu12 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_attend_on.gif");
	$(".menu12 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_attend_on.gif");
	showElementTop(12);
	showElement(12);
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
	
	if($("select#lst_term").length>0){
		$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$("#curr_year").val(), term_cd: $('#curr_term_cd').val()}, function(j){
			var options = "<option value=''>전체</option>";
			for (var i = 0; i < j.length; i++) 
			{
				if(j[i].class_cd=='<c:out value="${class_cd}"/>'){
					options += '<option value="' + j[i].class_cd + '" selected="selected">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				}else{
					options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				}
				
			}
			$("#lst_class").html(options);
			//$('#lst_dept option:first').attr('selected', 'selected');
		});
	}		
});

function doChangeTerm(obj) {
	var termVal = $("#lst_term").val();
	
	splitTerm(termVal);
}

function splitTerm(termVal) {
	if(termVal != "") {
		var arrTermVal = termVal.split(":");
		
		$("#curr_year").val(arrTermVal[0]);
		$("#curr_term_cd").val(arrTermVal[1]);
	}	
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/prof/class/class_list';
	f.submit();
}
$(function(){
	$("select#lst_term").change(function(){
		$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
			var options = "<option value=''>전체</option>";
			for (var i = 0; i < j.length; i++) 
			{
				options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
				
			}
			$("#lst_class").html(options);
			$('#lst_class option:first').attr('selected', 'selected');
		});
	}); 	
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
        dateFormat: 'yy-mm-dd',
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
 
    $('#sdate').datepicker();
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });
 
    $('#edate').datepicker();
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
    });
});
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 강의출결목록 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/prof/professor_class_title_01.png"  alt="강의출결  타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;강의출결 &nbsp; <img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp; 강의출결</td>
    </tr>
  </table>
</div>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/class/class_list" autocomplete="off">
<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
  <tr>
    <td align="center" valign="middle"><table width="665" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="66" height="33" align="left">학기 :</td>
        <td width="130" height="33" align="left">
        
        <select name="term_cd" id="lst_term" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
        	<c:forEach var="term" items="${termList }">
        		<c:choose>
        			<c:when test="${year eq term.year and term_cd eq term.term_cd}">
        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>
        </select>
        
        </td>
        <td width="66" height="33" align="left">강의명 :</td>
        <td width="250" height="33" align="left">
        <select name="class_cd" id="lst_class" class="searchlistbox" style="width:300px;">
        	<option value="">전체</option>
        </select>
	    </td>
        <td width="112" rowspan="2">
        	<button><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button></td>
      </tr>
      <tr align="left">
        <td>강의형태 :</td>
        <td>
 	        <select name="class_type" class="searchlistbox" id="lst_class_type" style="width:100px;">
	        <option value="">전체</option>
	          <c:forEach var="code" items="${classTypeList }">
        		<c:choose>
        			<c:when test="${class_type==code.code }">
        				<option value="${code.code }" selected="selected">${code.code_name }</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${code.code }">${code.code_name }</option>
        			</c:otherwise>
        		</c:choose>
       		  </c:forEach>
	        </select>
        </td>
        <td height="33">강의일 :</td>
        <td height="33">
        <input type="text" id="sdate" name="sdate" class="searchtextbox" value="${sdate }" style="width:80px;" readonly="readonly"> ~ <input type="text" id="edate" name="edate" value="${edate }" class="searchtextbox" style="width:80px;" readonly="readonly"> 
        </td>
        </tr>
    </table></td>
  </tr>
</table>
<br>
<table width="700" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="25" align="right" class="grayfont">[총 ${pb.allCnt }건] &nbsp;</td>
	  </tr>
</table>
<c:forEach var="b" items="${pb.list }">
<table width="699" height="87" border="0" cellpadding="0" cellspacing="0" class="graybox">
  <tr>
    <td width="86" rowspan="2" align="center" valign="middle" class="listleftbg">${b.class_type_name }<br />
      ${b.class_sts_name }</td>
    
    <td align="left"  class="blackfont"><a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${b.classday }&class_cd=${b.class_cd }&classhour_start_time=${b.classhour_start_time}">${b.class_name } (${b.classroom_no})</a></td>
    <td align="right" class="blackfont">${b.subject_cd }-${b.subject_div_cd }</td>
      
<%--정상,보강 --%>
<c:if test="${b.class_type_cd=='G019C001'||b.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<!-- 보강처리를 하지 않는 경우 버튼 제거 -->        	
	<c:if test="${b.class_sts_cd=='G020C001'&&b.class_type_cd=='G019C001' }">
	    <!-- td width="130" rowspan="2" align="center" valign="middle" class="listrightblue" style="cursor: pointer;" onclick="skipLecture('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.class_prog_cd}','${b.classroom_no}')"-->
	    <td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">
			<table border="0">
				<tr height="30">
					<td align="center" style="font-size: 16px;font-weight:bold;padding:10px 0 5px 0">강의전</td>
				</tr>
				<c:if test="${makeup_lesson eq 'Y' and b.classoff_yn eq 'Y'}">
					<c:choose>
						<c:when test="${b.class_prog_cd eq 'G018C003'}">
							<c:set var="classOffText" value="휴강신청중" />
						</c:when>
						<c:otherwise>
							<c:set var="classOffText" value="휴강신청" />
						</c:otherwise>
					</c:choose>					
					<tr>
						<td align="center"><hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" /></td>
					</tr>
					<tr>
						<td align="center">${classOffText}</td>
					</tr>
				</c:if>
			</table>
	    </td>
	</c:if>
	<c:if test="${b.class_sts_cd=='G020C001'&&b.class_type_cd=='G019C003' }">
		<td width="130" rowspan="2" align="center" valign="middle" class="listrightblue">보강정보 
	        <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
	        강의전
        </td>
	</c:if>		
	<%--//강의전 --%>
	<%--강의중 --%>
	<c:if test="${b.class_sts_cd=='G020C002' }">
		<%--인증요청전 --%>
		<c:if test="${b.cert_sts_cd=='G021C001' }">
			<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb" style="cursor: pointer;" onclick="certType('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.cert_sts_cd }')">강의시작</td>
	    </c:if>
		<%--//인증요청전 --%>
		<%--인증요청후 --%>
		<c:if test="${b.cert_sts_cd=='G021C002' }">
			<c:choose>
				<c:when test="${b.cert_type eq 'CERT_NUM'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightpurple" style="cursor: pointer;" onclick="certLecture('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.cert_sts_cd }')">인증코드확인</td>
				</c:when>
				<c:when test="${b.cert_type eq 'PROF_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb">강의중</td>
				</c:when>
				<c:when test="${b.cert_type eq 'BEACON_AUTH'}">
					<td width="130" rowspan="2" align="center" valign="middle" class="listrightdeepb">강의중</td>
				</c:when>
			</c:choose>
		</c:if>
		<%--//인증요청후 --%>
	</c:if>
	<%--//강의중 --%>
	<%--강의완료 --%>
	<c:if test="${b.class_sts_cd=='G020C003' }">
		<c:set var="varClassStatus" value="강의종료" />
		<c:if test="${b.class_type_cd ne 'G019C002' and b.class_sts_cd eq 'G020C003' and empty b.cert_type}">
			<c:set var="varClassStatus" value="<font style='color:rgba(219, 36, 39, 1);'>결강<br/>(출결미처리)</font>" />
		</c:if>									
	
		<c:if test="${b.class_type_cd=='G019C001' }">
			<td width="130" rowspan="2" align="center" valign="middle" class="listgraybigbox">${varClassStatus}
				<c:if test="${makeup_lesson eq 'Y' }">
					<c:choose>
						<c:when test="${b.class_prog_cd eq 'G018C003'}">
							<c:set var="classOffText" value="휴강신청중" />
						</c:when>
						<c:otherwise>
							<c:set var="classOffText" value="휴강신청" />
						</c:otherwise>
					</c:choose>												
					<hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
					<span style="padding:5px 12px 10px 12px;color:#DDD;cursor: pointer;" onclick="skipLecture('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.class_prog_cd}','${b.classroom_no}')">${classOffText}</span>
				</c:if>
			</td>
		</c:if>

		<c:if test="${b.class_type_cd=='G019C003' }">
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
<c:if test="${b.class_type_cd=='G019C002' }">
	<%--보강 없음 --%>
	<c:if test="${empty b.before_classday }">
		<td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보
		<hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
    없음<br></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty b.before_classday }">
	 <td width="130" rowspan="2" align="center" valign="middle" class="listrightyellow">보강정보 
	 <hr style="noshade:noshade; size:1px; width:96px; color:#FFFFFF;" />
	 <fmt:formatDate value="${b.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
		<c:choose>
			<c:when test="${b.class_prog_cd eq 'G018C004'}">
				(취소신청중)
			</c:when>
			<c:otherwise>
				<fmt:formatDate value="${b.before_classday}" type="time" pattern="(E) HH:mm"/>
			</c:otherwise>
		</c:choose>	 
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>

  </tr>
  <tr>
    <td width="340" height="37" valign="top" align="left" class="grayfont">
    	<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
    	<c:set var="view_week" value="${b.curr_week}" />
    	<c:if test="${view_week eq '16'}">
    		<c:set var="view_week" value="${view_week - 1}" />
    	</c:if>
    
	    <c:if test="${b.curr_week ne null && !empty b.curr_week}">[${view_week}주차]</c:if>    
		<a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${b.classday }&class_cd=${b.class_cd }&classhour_start_time=${b.classhour_start_time}">${b.classday} <fmt:formatDate value="${b.classday}" type="time" pattern="(E)"/> ${b.classhour_start_time } ~ ${b.classhour_end_time}</a>
		<c:if test="${b.is_team == 'Y'}">&nbsp;&nbsp;&nbsp;*팀티칭</c:if>
    </td>
    <td width="75" height="37" valign="top" align="right" class="blackfont">${b.attendee_cnt }명</td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty pb.list }">
<table width="680" height="100" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>

<div class="alignright">
	<!-- 보강처리를 하지 않는 경우 버튼 제거 -->        	
	<c:if test="${makeup_lesson eq 'Y' }">
		<%-- <a href="${pageContext.request.contextPath}/prof/class/class_add"><img src="${pageContext.request.contextPath}/resources/images/prof/class_button_05.png" width="78" height="27" alt="보강등록버튼" /></a> --%>
	</c:if>
</div>

<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
	    <td height="18" align="center" class="paginggrayfont"><my:pageGroup/></td>
	</tr>
</table>
<br>

<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="curr_year" name="curr_year">
<input type="hidden" id="curr_term_cd" name="curr_term_cd">

</form>
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
<!-- //교수 강의출결목록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>