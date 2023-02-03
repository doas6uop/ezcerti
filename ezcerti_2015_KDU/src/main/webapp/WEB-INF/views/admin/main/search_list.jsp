<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="//select-box.googlecode.com/svn/tags/0.2/jquery.selectbox-0.2.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_style.css">

<script>
$(document).ready(function(){
	$(".menu2 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_02.gif");
	
	$("input[name='searchType']").change(function() {
		// 정렬필드 초기화
		$("#sortField").val('');
		
		changeSearchType($(this).val());
		$("#currentPage").val("1");
	}); 
	
	$("#item").change(function() {
		$("#currentPage").val("1");
	}); 	

	$('input[name="searchType"]:radio:input[value="${searchType}"]').attr('checked', 'checked');
	
	changeSearchType($('#searchType:checked').val());

});

function changeSearchType(type){
	
	if(type == 'PROF') {
		$("#item").html("<option value='all'>전체</option><option value='name'>교수명</option><option value='code' >사번</option>");
		$("#item").val("all").attr("selected", "selected");
	} else if(type == 'STUDENT') {
		$("#item").html("<option value='name'>학생명</option><option value='code' >학번</option><option value='cert_count' >인증횟수</option>");
		$("#item").val("name").attr("selected", "selected");
	} else if(type == 'CLASS') {
		$("#item").html("<option value='all'>전체</option><option value='class'>강의명</option><option value='prof' >교수명</option>");
		$("#item").val("all").attr("selected", "selected");
	}
}

function changeOrder(sortField) {
	if($("#sortOrder").val() == "DESC") {
		$("#sortOrder").val("ASC");
	} else {
		$("#sortOrder").val("DESC");
	}
	$("#sortField").val(sortField);

	doSearch();
}

function doSearch(type){
	
	var f = document.getElementById('searchForm');
	
	if(type != "") {
		f.type.value = type;		
	}
	
	f.method = 'post';
	f.currentPage.value = 1;
	//f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/main/search';
	f.submit();
}

function doExcelDownload() {

	// 엑셀 다운로드시 교수, 학생, 과목에 따른 타입을 구분한다.
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/main/search';
	f.submit();
	
	// 폼정보 초기화
	$("#type").val('');
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/main/search';
	f.submit();
}

function onSubmit() {
	$("#currentPage").val("1");
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	
<!--통합검색 페이지 시작-->
<h4 class="mg_b10 float_left mg_t80"><img src="${pageContext.request.contextPath}/resources/images/admin/search_h4_01.gif" alt="통합검색" /></h4>
<!-- onSubmit="javascript:onSubmit()" -->
<form id="searchForm" onsubmit="javascript:doSearch(''); return false;" method="get" action="${pageContext.request.contextPath}/muniv/main/search" autocomplete="off" >
	<div id="searchBox">
		<fieldset>
		<div class="targetSelect">
	  	<p class="float_left"><img src="${pageContext.request.contextPath}/resources/images/admin/search_text.gif" alt="검색할 대상을 선택하여 주세요" /></p>
	    <div class="float_right w32">
	        <label for="targetSearch1">
	        <input id="searchType" name="searchType" type="radio" value="PROF"/>
	        <span>교수</span></label>
	        <label for="targetSearch2">
	        <input id="searchType" name="searchType" type="radio" value="STUDENT" class="mg_l20"/>
	        <span>학생</span></label>
	        <label for="targetSearch3">
	        <input id="searchType" name="searchType" type="radio" value="CLASS" class="mg_l20"/>
	        <span>과목</span></label>
	    </div>
	  </div>
	  <div class="inputSearch">
	  	<div class="searchSelect">
	    	<select id="item" name="item" title="검색 방식 선택">
			</select>
	    </div>
	    <div class="searchKeyword">
	    	 <label for="searchKeyword" class="alternate">검색어 입력</label>
	       <input type="text" id="value" name="value" value="${searchValue}" class="search_input" title="검색어 입력"  value="검색어를 입력하여 주세요"/>
	    </div>
	    <div class="searchBtn">
	    	 <label for="searchBtn" class="alternate">검색어 입력</label>
	       <input type="image" id="searchBtn" name="searchBtn" src="${pageContext.request.contextPath}/resources/images/admin/search_btn.gif" alt="검색" />
	    </div>  
	  </div>
		</fieldset>
	</div>
	
	<c:if test="${bSearch}">
	<c:set var="pb" value="${pageBean }"/>	
	<div class="float_left mg_t30 mg_b150">
		<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
		<c:choose>
			<c:when test="${searchType eq 'PROF'}">
				<table border="0" cellpadding="0" cellspacing="0" class="tstyle_valSearch">
					<tr>
						<th>NO</th>
						<th>단과</th>
						<th><a href="javascript:changeOrder('DEPT_NAME')">학과</a></th>
						<th><a href="javascript:changeOrder('PROF_NO')">사번</a></th>
						<th width="12%"><a href="javascript:changeOrder('PROF_NAME')">교수명</a></th>
						<th>연락처</th>
						<th class="th_end">상태</th>
					</tr>
					<c:choose>
						<c:when test="${fn:length(pb.list)==0 }">
							<tr>
								<td colspan="7" align="center">검색결과가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${pb.list}" varStatus="status">
								<tr>
									<td>${((currentPage - 1) * 10) + status.count }</td>
									<td>${list.coll_name }</td>
									<td>${list.dept_name }</td>
									<td><a href="${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${list.prof_no }">${list.prof_no }</a></td>
									<td><a href="${pageContext.request.contextPath}/muniv/prof/prof_view?prof_no=${list.prof_no }">${list.prof_name }</a></td>
									<td>${list.hp_no }</td>
									<td>${list.prof_sts_cd }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose> 				
				</table>
				
				<div style="text-align: right; margin-top: 15px;">
					<a href="javascript:doExcelDownload()">
						<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" alt="엑셀다운로드">
					</a>
				</div>
				
			</c:when>
			<c:when test="${searchType eq 'STUDENT'}">
				<table border="0" cellpadding="0" cellspacing="0" class="tstyle_valSearch">
					<tr>
						<th>NO</th>
						<th>단과</th>
						<th><a href="javascript:changeOrder('DEPT_NAME')">학과</a></th>
						<th><a href="javascript:changeOrder('STUDENT_GRADE')">학년</a></th>
						<th><a href="javascript:changeOrder('STUDENT_NO')">학번</a></th>
						<th width="12%"><a href="javascript:changeOrder('STUDENT_NAME')">이름</a></th>
						<th>연락처</th>
						<th>상태</th>
						<th class="th_end">인증횟수</th>
					</tr>
					<c:choose>
						<c:when test="${fn:length(pb.list)==0 }">
							<tr>
								<td colspan="9" align="center">검색결과가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${pb.list}" varStatus="status">
								<tr>
									<td>${((currentPage - 1) * 10) + status.count }</td>
									<td>${list.coll_name }</td>
									<td>${list.dept_name }</td>
									<td>${list.student_grade }학년</td>
									<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?student_no=${list.student_no}">${list.student_no }</a></td>
									<td><a href="${pageContext.request.contextPath}/muniv/student/student_view?student_no=${list.student_no}">${list.student_name }</a></td>
									<td>${list.hp_no }</td>
									<td>${list.student_sts_name }</td>
									<td>${list.cert_count }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose> 				
				</table>
				
				<div style="text-align: right; margin-top: 15px;">
					<a href="javascript:doExcelDownload()">
						<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" alt="엑셀다운로드">
					</a>
				</div>
				
			</c:when>
			<c:when test="${searchType eq 'CLASS'}">
				<table border="0" cellpadding="0" cellspacing="0" class="tstyle_valSearch">
					<tr>
						<th>NO</th>
						<th><a href="javascript:changeOrder('CLASSDAY || CLASSHOUR_START_TIME')">강의일</a></th>
						<th><a href="javascript:changeOrder('PROF_DEPT_NAME')">학과</a></th>
						<th><a href="javascript:changeOrder('CLASS_NAME')">과목</a></th>
						<th width="12%"><a href="javascript:changeOrder('PROF_NAME')">교수</a></th>
						<th>수강인원</th>
						<th class="th_end">상태</th>
					</tr>
					<c:choose>
						<c:when test="${fn:length(pb.list)==0 }">
							<tr>
								<td colspan="7" align="center">검색결과가 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${pb.list}" varStatus="status">
								<c:set var="varClassStatus" value="${list.class_type_name }(${list.class_sts_name })" />
							
								<c:if test="${list.class_type_cd ne 'G019C002' and list.class_sts_cd eq 'G020C003' and empty list.cert_type}">
									<c:set var="varClassStatus" value="결강(출결미처리)" />
								</c:if>							
								<tr>
									<td>${((currentPage - 1) * 10) + status.count }</td>
									<td><a href="${pageContext.request.contextPath}/muniv/attend/class_attend_view?classday=${list.classday}&classhour_start_time=${list.classhour_start_time }&class_cd=${list.class_cd }">${list.classday } <fmt:formatDate value="${list.classday }" type="time" pattern="(E)"/> ${list.classhour_start_time } ~ ${list.classhour_end_time }</a></td>
									<td>${list.prof_dept_name }</td>
									<td>${list.class_name }</td>
									<td>${list.prof_name }</td>
									<td>${list.attendee_cnt }</td>
									<td>${varClassStatus}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose> 				
				</table>
				
				<div style="text-align: right; margin-top: 15px;">
					<a href="javascript:doExcelDownload()">
						<img src="${pageContext.request.contextPath }/resources/images/admin/excel_btn.png" alt="엑셀다운로드">
					</a>
				</div>
			</c:when>
		</c:choose>
		
		<br/>
		
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<tr>
			    <td height="18" align="center" class="paginggrayfont"><my:pageGroup/></td>
			</tr>
		</table>	
		
	</div>
	</c:if>
	<!--통합검색 페이지 끝-->

	<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
	<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
	<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
	<input type="hidden" id="type" name="type" value="${param.type}">
</form>

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

