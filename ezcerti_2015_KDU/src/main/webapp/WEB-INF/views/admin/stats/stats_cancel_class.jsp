<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">

<script>
$(document).ready(function(){
	$(".menu6_admin .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_06.gif");
	$(".menu6_admin .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_06.gif");
	$("#in_topmenu6").css("display","block");
	$("#in_menu6").css("display","block");
});

function doSearch(type){
	
	var f = document.getElementById('searchForm');
	
	if(type != "") {
		f.type.value = type;		
	}
	
	f.method = 'post';
	f.currentPage.value = 1;
	//f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_cancel_class';
	f.submit();
}

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_cancel_class';
	f.submit();
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

function doPopupProfClassStats(prof_no, subject_cd, subject_div_cd) {
	var targetURL = "${pageContext.request.contextPath}/muniv/stats/stats_academic_prof_class?prof_no="+prof_no+"&subject_cd="+subject_cd+"&subject_div_cd="+subject_div_cd;
	
	window.open(targetURL,'classStatPop','width=1550, height=800,top=0,left=0, toolbar=no, menubar=no, scrollbars=yes')
}

function doExcelDownload() {
	
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_cancel_class';
	f.submit();
	$("#type").val('');
}
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

<c:set var="pb" value="${pageBean }"/>	
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/cancel_class.gif"  alt="결강현황" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;결강현황</td>
    </tr>
  </table>
</div>
<br />

<form id="searchForm" onsubmit="javascript:doSearch(''); return false;" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_cancel_class" autocomplete="off">

	<div id="board">
		<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	
		<div id="board_list">	
			
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<caption>목록</caption>
				<thead>
					<tr>
				        <th width="30" class="bg_left" scope="col">NO</th>
				        <th width="220" scope="col"><a href="javascript:changeOrder('CLASSDAY || CLASSHOUR_START_TIME')">강의일시</a></th>
				        <th width="125" scope="col"><a href="javascript:changeOrder('PROF_DEPT_NAME')">학과</a></th>
				        <th width="150" scope="col"><a href="javascript:changeOrder('CLASS_NAME')">과목</a></th>
				        <th width="110" scope="col"><a href="javascript:changeOrder('PROF_NAME')">교수</a></th>
				        <th width="110" scope="col">직종</th>
				        <th width="55" scope="col">수강</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(pb.list)==0 }">
						<tr>
							<td class="tdwhite" colspan="7" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="b" items="${pb.list}" varStatus="status">
							<tr class="tr_over">
								<td>${b.row_no}</td>
								<td><a href="${pageContext.request.contextPath}/muniv/attend/class_attend_view?classday=${b.classday}&classhour_start_time=${b.classhour_start_time }&class_cd=${b.class_cd }">${b.classday } <fmt:formatDate value="${b.classday }" type="time" pattern="(E)"/> ${b.classhour_start_time }~${b.classhour_end_time }</a></td>
								<td>${b.prof_dept_name }</td>
								<td>${b.class_name }</td>
								<td>${b.prof_name }</td>
								<td>${b.prof_jikjong}</td>
								<td>${b.attendee_cnt }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose> 
				</tbody>
			</table>
		</div> <!-- board_list -->
		<div class="pagination">
			<div class="page_num"> 
				<my:pageGroup/>
			</div>
		</div>
		<div class="btn_area">
			<a href="javascript:doExcelDownload()">
				<img src="${pageContext.request.contextPath }/resources/images/common/e_down_button.png">
			</a>	
		</div>
		<div class="search_area">
			<div class="search">
				<h4 class="float_left mg_t3">
					<img src="${pageContext.request.contextPath}/resources/images/board/search_title.gif" alt="search" />
				</h4>
				<div class="float_left pd_l15">
					<fieldset>
					<legend>통합검색</legend>
					<label class="alternate" for="fmSearch4">검색목록</label>
						<select id="item" name="item">
				            <option value="class_name" <c:if test="${param.item=='class_name'}">selected</c:if>>과목명</option>
							<option value="prof_name" <c:if test="${param.item=='prof_name'}">selected</c:if>>교수명</option>
						</select>
					<label class="alternate" for="fmString2">검색어 입력</label>
					<input type="text" id="value" name="value" value="${param.value}" class="search_txt" />
					<label class="alternate" for="btnSearch">검색</label>
					<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
					</fieldset>
				</div>
			</div>
		</div>
	</div> <!-- board -->
	
	<input type="hidden" id="current_date" name="current_date" value="${param.current_date }">
	<input type="hidden" id="currentPage" name="currentPage">
	<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
	<input type="hidden" id="sortOrder" name="sortOrder" value="${param.sortOrder}">
	<input type="hidden" id="type" name="type" value="${param.type}">

</form>
<!-- //관리자출결현황 -->
</div>
</div>

<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>

<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

