<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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

<c:set var="cr" value="${classOffRequest}"/>
<spring:eval expression="@config['makeup_lesson_approval']" var="makeup_lesson_approval"/>

<script>
$(document).ready(function(){
	<c:if test="${cr.proc_status eq 'G030C002' or cr.proc_status eq 'G030C005'}">
	window.resizeBy(0, 20);
	</c:if>
	
	<c:if test="${cr.proc_status eq 'G030C003' or cr.proc_status eq 'G030C006'}">
		window.resizeBy(0, 50);
	</c:if>
});

function doChangeProcType() {
	var procType = $(':radio[name="proc_type"]:checked').val();
	
	if(procType == "APPROVAL") {
		document.getElementById("reject_reason").innerHTML = "";
	} else {
		var str = "";
		str +=  "<table border='0' cellpadding='0' cellspacing='0' class='tstyle_row1 mg_t5'>";
		str +=  "<tr>";
		str +=  "<th width='30%' class='major_th'>반려사유</th>";
		str +=  "<td><textarea class='w100 input_gray' id='proc_reason' name='proc_reason' rows='5'></textarea></td>";
		str +=  "</tr>";
		str +=  "</table>";
		
		document.getElementById("reject_reason").innerHTML = str;
	}
}

function doProc(req_no, type) {
	var procType = $(':radio[name="proc_type"]:checked').val();
	var rejectReason = $('#proc_reason').val();
	
	if(type == 'DELETE') {
		procType = type;
	}
	
	var postString = {req_no: req_no, proc_type: procType, reject_reason: rejectReason};

	$.ajax({
		type: "POST",

		url: "${pageContext.request.contextPath}/muniv/main/classoff_proc",

		data: postString,

		success: function(msg) {
			alert(msg);
			opener.location.reload(true);  
			self.close();
		},
		error: function(msg){
			alert(msg);
		}
   });	      	
}

function doPrint() {
	var targetURL = "${pageContext.request.contextPath}/muniv/main/classoff_view?req_no=${cr.req_no}&print_flag=Y&view_type=VIEW";
	
	window.open(targetURL,'classOffPop','width=700, height=460,top=0,left=0,toolbar=no, menubar=no, scrollbars=yes')
}

function doApproval() {
	location.replace("${pageContext.request.contextPath}/muniv/main/classoff_view?req_no=${cr.req_no}&view_type=APPROVAL") ;
}

function doChangeReason() {
	var reqReason = $('#req_reason').val();
	
	var postString = {req_no: "${cr.req_no}", reqReason: reqReason};

	$.ajax({
		type: "POST",

		url: "${pageContext.request.contextPath}/muniv/main/classoff_change_reason",

		data: postString,

		success: function(msg) {
			alert(msg);
			opener.location.reload(true);  
			self.close();
		},
		error: function(msg){
			alert(msg);
		}
   });	      		
}

<c:if test="${print_flag eq 'Y'}">
	window.print();
	setTimeout("window.close();", 500);
</c:if>
  
</script>

</head>

<c:set var="table_class" value="border='0' class='tstyle_row1 mg_t20'"/>
<c:set var="th_class" value="class='major_th'"/>
<c:set var="th_bline_class" value="class='bline_dark'"/>
<c:set var="req_cancel_flag" value="ADD_REQ" />
<c:set var="classoff_rowspan" value="3" />

<c:if test="${print_flag eq 'Y'}">
	<c:set var="table_class" value="border='1' width='90%'"/>
	<c:set var="th_class" value=""/>
	<c:set var="th_bline_class" value="style='padding:5px 5px 5px 10px'"/>
</c:if>

<c:if test="${cr.proc_status eq 'G030C004' or cr.proc_status eq 'G030C005' or cr.proc_status eq 'G030C006'}">
	<c:set var="req_cancel_flag" value="CANCEL_REQ" />
	<c:set var="classoff_rowspan" value="2" />
</c:if>

<body>
<div id="article">
	<div id="contents" style="width:620px; padding-left:40px">
	
 	<c:if test="${view_type eq 'VIEW'}">
		<h4 class="h4_title01 t_center">휴강신청서</h4>
		
		<c:if test="${print_flag eq 'Y'}">
		<br/><br/>
		</c:if>		
		
		<table cellpadding="0" cellspacing="0" ${table_class}>
			<tr>
				<th ${th_class} rowspan="2">교수정보</th>
				<th >교수명</th>
					<td ${th_bline_class}>${cr.prof_name}</td>
			</tr>
			<tr>
				<th ${th_bline_class}>사번</th>
					<td ${th_bline_class}>${cr.prof_no}</td>
			</tr>
			<tr>
				<th ${th_class} rowspan="${classoff_rowspan}">휴강정보</th>
				<th>과목명</th>
					<td ${th_bline_class}>${cr.class_name} (${cr.subject_cd}-${cr.subject_div_cd})</td>
			</tr>
			<tr>
				<th>수업일시</th>
					<td ${th_bline_class}>${cr.classday} (${cr.classday_name}) ${cr.classhour_start_time} ~ ${cr.classhour_end_time}</td>
			</tr>
			<c:if test="${req_cancel_flag eq 'ADD_REQ'}">
			<tr>
				<th ${th_bline_class}>휴강사유</th>
					<td ${th_bline_class}><input type="text" name="req_reason" id="req_reason" size="40" value="${cr.req_reason}" style="font-size:12px;">&nbsp;&nbsp;<a href="javascript:doChangeReason()">[사유변경]</a></td>					
			</tr>
			</c:if>

			<c:set var="addInfo" value="" />
			<c:if test="${cr.add_classday ne null}">
				<c:set var="addInfo" value="${cr.add_classday} (${cr.add_classday_name}) ${cr.add_classhour_start_time} ~ ${cr.add_classhour_end_time} (${cr.add_classroom_no})" />
			</c:if>
			
			<tr>
				<th ${th_class}>보강정보</th>
				<th>보강일</th>
					<td ${th_bline_class}>${addInfo}</td>
			</tr>
			
			<c:if test="${cr.proc_status eq 'G030C002' or cr.proc_status eq 'G030C005'}">
				<tr>
					<th ${th_class} rowspan="3">처리정보</th>
					<th>신청일</th><td><fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th>처리구분</th><td>${cr.proc_status_nm}</td>
				</tr>
				<tr>
					<th>처리일</th><td><fmt:formatDate value="${cr.proc_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
			</c:if>

			<c:if test="${req_cancel_flag eq 'G030C003' or cr.proc_status eq 'G030C006'}">
				<tr>
					<th ${th_class} rowspan="4">처리정보</th>
					<th>신청일</th><td><fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th>처리구분</th><td>${cr.proc_status_nm}</td>
				</tr>
				<tr>
					<th>처리일</th><td><fmt:formatDate value="${cr.proc_date}" pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				<tr>
					<th>반려사유</th><td>${cr.proc_reason}</td>
				</tr>			
			</c:if>
			
		</table>
		
		<p class="t_center mg_t40 f14">신청일 : <fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></p>

		<c:if test="${print_flag ne 'Y'}">
		<p class="t_right mg_t20">
			<c:if test="${sessionScope.ADMIN_INFO.admin_level_cd eq 'G014C001'}">
				<c:if test="${cr.proc_status eq 'G030C001' or cr.proc_status eq 'G030C004'}">
					<sec:authorize ifAnyGranted="ROLE_SYSTEM">
						<a href="javascript:doApproval()"><img src="${pageContext.request.contextPath}/resources/images/admin/s_conf_return_btn.gif" alt="승인및반려처리" /></a>
					</sec:authorize>
				<%-- <a href="javascript:doProc('${cr.req_no}', 'DELETE')"><img src="${pageContext.request.contextPath}/resources/images/board/del_btn.gif" alt="삭제" /></a> --%>
				</c:if>
				<a href="javascript:doPrint()"><img src="${pageContext.request.contextPath}/resources/images/admin/prt_btn.gif" alt="신청서 출력" /></a>
			</c:if>		
			<a href="javascript:self.close()"><img src="${pageContext.request.contextPath}/resources/images/admin/close_btn.gif" alt="닫기" /></a>
		</p>
		</c:if>
	</c:if>
 
 	<c:if test="${view_type eq 'APPROVAL'}">
		<h4 class="h4_title01 t_center">승인 및 반려 처리</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1 mg_t20">
			<tr>
				<th width="15%" rowspan="4" class="major_th">신청정보</th>
				<th >교수명</th>
					<td width="70%" >${cr.prof_name}</td>
			</tr>
			<tr>
				<th>사번</th>
					<td>${cr.prof_no}</td>
			</tr>
			<tr>
				<th>신청번호</th>
					<td>${cr.req_no}</td>
			</tr>
			<tr>
				<th>신청일</th>
					<td><fmt:formatDate value="${cr.req_date}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
		</table>
		
		<table border="0" cellpadding="0" cellspacing="0" class="tstyle_row1 mg_t5">
			<tr>
				<th width="15%" rowspan="3" class="major_th">승인 및<br/>반려처리</th>
				<th >구분</th>
					<td width="70%" >
						<span><input type="radio" checked="checked" value="APPROVAL" name="proc_type" id="proc_type" onClick="javascript:doChangeProcType()"/><label for="radio_conf">승인</label></span>
						<span class="pd_l10"><input type="radio" value="REJECT" name="proc_type" id="proc_type" onClick="javascript:doChangeProcType()"/><label for="radio_return ">반려</label></span>
					</td>
			</tr>
			<tr>
				<th>처리일</th>
					<td>
						<label for="date_select" class="alternate">승인</label>
						<jsp:useBean id="toDay" class="java.util.Date" />
						<fmt:formatDate value="${toDay}" pattern="yyyy년 MM월 dd일" />
				</td>
			</tr>
		</table>

		<div id="reject_reason" name="reject_reason"></div>
		
		<p class="t_right mg_t20"><a href="javascript:doProc('${cr.req_no}', 'PROC')"><img src="${pageContext.request.contextPath}/resources/images/admin/approval_btn.gif" alt="처리완료" /></a></p>
 	
 	</c:if>

	</div>
</div>

</body>
</html>