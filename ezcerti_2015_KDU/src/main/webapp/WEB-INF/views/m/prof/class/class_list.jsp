<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/categorylayer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources_m/js/prof_cert.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">
<script>
$(document).ready(function(){
	$("#topmenu_02").removeClass('submenugrayfont').addClass('menubluefont');
	
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
	f.action = '${pageContext.request.contextPath}/m/prof/class/class_list';
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
	        changeYear: true,
	        showButtonPanel: false,
	        yearRange: 'c-3:c+1',
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

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 강의출결목록 -->
<c:set var="pb" value="${pageBean }"/>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/class/class_list" autocomplete="off">
<div class="subsearchbg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="18%" height="40" align="right">학기:</td>
      <td width="40%" align="left"><label for="listmenu"></label>
       
        <select name="term_cd" id="lst_term" class="searchlistbox" style="max-width:110px;" onChange="javascript:doChangeTerm(this)">
          <c:forEach var="term" items="${termList }">
        		<c:choose>
        			<c:when test="${year eq term.year and term_cd==term.term_cd }">
        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>
      	</select>
      	
      </td>
      <td width="24%" align="right">강의명 :</td>
      <td width="18%" align="left">
      <select name="class_cd" id="lst_class" class="searchlistbox" style="max-width:90px;">
        <option value="">전체</option>		
      </select></td>
    </tr>
    <tr>
      <td width="18%" height="33" align="right">강의일:</td>
      <td colspan="2" width="72%" align="left"><label for="textbox"></label>
        <input type="text" id="sdate" name="sdate" value="${sdate }" class="searchtextbox" style="max-width:61px" readonly="readonly">~
        <input type="text" id="edate" name="edate" value="${edate }" class="searchtextbox" style="max-width:61px" maxlength="10" readonly="readonly"></td>
      <td width="10%" align="right" valign="bottom"><div class="visual">
        <button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:63px;" alt="검색버튼"></button>
      </div></td>
    </tr>
  </table>
</div>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5%" style="min-width:45px;">
    <c:if test="${cPage>1 }">
    <div class="visual">
    <a href="javascript:paging(${cPage-1 })"><img src="${pageContext.request.contextPath}/resources_m/images/beforeb_button.png" style="max-width:45px;" alt="이전버튼"></a>
    </div>
    </c:if>
    </td>
    <td width="90%" align="center" class="blackboldfont">[총 ${pb.allCnt }건]</td>
    <td width="5%" align="right" style="min-width:45px;">
    <c:if test="${pb.totalPage > cPage }">
    <div class="visual">
    <a href="javascript:paging(${cPage+1 })"><img src="${pageContext.request.contextPath}/resources_m/images/nextb_button.png" style="max-width:45px;" alt="다음버튼"></a>
    </div>
    </c:if>
    </td>
  </tr>
</table>
<div class="tablelayout">
<c:forEach var="b" items="${pb.list }">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subgraybox">
  <tr>
    <td width="17%" rowspan="2" align="center" valign="middle" class="leftgraybox">${b.class_type_name }<br>
      ${b.class_sts_name }</td>

    <td style="padding:5px 0 5px 5px" colspan="2">
    <c:if test="${list.is_team == 'Y'}">*팀티칭<br/></c:if>
    <a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${b.classday }&class_cd=${b.class_cd }&classhour_start_time=${b.classhour_start_time}"><font style="font-size:14px; font-weight:bold">${b.class_name }</font><br/>(${b.classroom_no})</a></td>
      
<%--정상,보강 --%>
<c:if test="${b.class_type_cd=='G019C001'||b.class_type_cd=='G019C003' }">
	<%--강의전 --%>
	<spring:eval expression="@config['makeup_lesson']" var="makeup_lesson"/>
	<c:if test="${makeup_lesson eq 'Y' }">
		<c:if test="${b.class_sts_cd=='G020C001'&&b.class_type_cd=='G019C001' }">
			<td width="27%" rowspan="2">
				<c:if test="${b.classoff_yn eq 'Y'}">
					<c:choose>
						<c:when test="${b.class_prog_cd eq 'G018C003'}">
							<c:set var="classOffText" value="휴강<br>신청중" />
						</c:when>
						<c:otherwise>
							<c:set var="classOffText" value="휴강<br>신청" />
						</c:otherwise>
					</c:choose>					
				</c:if>
			
				<div class="rightbluebox" onclick="skipLecture('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.class_prog_cd}','${b.classroom_no}')">
				${classOffText}
		    	</div>
		    </td>
		</c:if>
		<c:if test="${b.class_sts_cd=='G020C001'&&b.class_type_cd=='G019C003' }">
			<td width="27%" rowspan="2">
				<div class="rightbluebox">
					강의<br>이전
		    	</div>
	    	</td>
		</c:if>
	</c:if>	
	<%--//강의전 --%>
	<%--강의중 --%>
	<c:if test="${b.class_sts_cd=='G020C002' }">
		<%--인증요청전 --%>
		<c:if test="${b.cert_sts_cd=='G021C001' }">
		    <td width="27%" rowspan="2">
		    	<div class="rightdeepbbox" onclick="certType('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.cert_sts_cd }')">
		    		강의<br>시작
		    	</div>
		    </td>
	    </c:if>
		<%--//인증요청전 --%>

		<%--인증요청후 --%>
		<c:if test="${b.cert_sts_cd=='G021C002' }">
			<c:choose>
				<c:when test="${b.cert_type eq 'CERT_NUM'}">
					<td width="27%" rowspan="2" class="listpurplebox">
						<div class="rightpurplebox" onclick="certLecture('${b.class_cd}','${b.classday}','${b.classhour_start_time}','${b.cert_sts_cd }')">
				    		인증코드<br>확인
				    	</div>
				    </td>
				</c:when>
				<c:when test="${b.cert_type eq 'PROF_AUTH'}">
					<td width="27%" rowspan="2" class="listpurplebox">
						<div class="rightpurplebox">
				    		강의중
				    	</div>
				    </td>
				</c:when>
				<c:when test="${b.cert_type eq 'BEACON_AUTH'}">
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
	<c:if test="${b.class_sts_cd=='G020C003' }">
		<c:set var="varClassStatus" value="강의<br/>종료" />
		<c:if test="${b.class_type_cd ne 'G019C002' and b.class_sts_cd eq 'G020C003' and empty b.cert_type}">
			<c:set var="varClassStatus" value="<font style='color:rgba(219, 36, 39, 1);'>결강<br/>(출결미처리)</font>" />
		</c:if>									
	
		<td width="27%" rowspan="2" class="listgraybigbox"><div class="whiterightbox">${varClassStatus}</div></td>
	</c:if>
	<%--//강의완료 --%>
</c:if>
<%--//정상,보강 --%>
<%--휴강 --%>
<c:if test="${b.class_type_cd=='G019C002' }">
	<%--보강 없음 --%>
	<c:if test="${empty b.before_classday }">
	<td width="27%" rowspan="2"><div class="rightyellowbox">보강정보<br><br>
    없음</div></td>
	</c:if>
	<%--//보강 없음 --%>
	<%--보강 있음 --%>
	<c:if test="${not empty b.before_classday }">
	<td width="27%" rowspan="2"><div class="rightyellowbox">보강정보<br>
    <fmt:formatDate value="${b.before_classday}" type="date" pattern="yyyy-MM-dd"/><br>
    <fmt:formatDate value="${b.before_classday}" type="time" pattern="(E) HH:mm"/></div></td>
	</c:if>
	<%--//보강 있음 --%>
</c:if>
<%--//휴강  --%>    
  </tr>
  <tr>
    <td width="43%"><a href="${pageContext.request.contextPath}/prof/class/class_view?classday=${b.classday }&class_cd=${b.class_cd }&classhour_start_time=${b.classhour_start_time}">
    	<!-- 15주차가 보강주로 인해 16주차에 강의가 생성됨으로 표시를 16이 아닌 15로 표시되도록 함 -->
    	<c:set var="view_week" value="${b.curr_week}" />
    	<c:if test="${view_week eq '16'}">
    		<c:set var="view_week" value="${view_week - 1}" />
    	</c:if>
    	    
		&nbsp;<c:if test="${b.curr_week ne null && !empty b.curr_week}">(${view_week})</c:if>
    	${b.classday}<fmt:formatDate value="${b.classday}" type="time" pattern="(E)"/> ${b.classhour_start_time }</a>
    </td>
    <td width="12%" align="right">${b.attendee_cnt }명</td>
  </tr>
</table>
</c:forEach>
<c:if test="${empty pb.list }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
	<tr>
	    <td height="25" align="center" class="paginggrayfont"><my:pageGroupMobile/></td>
	</tr>
</table>
</div>
	
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
<!-- //강의출결목록 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
