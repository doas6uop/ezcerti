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

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_prof_usage';
	f.submit();
}

function doSearch(){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = 1;
	f.sortField.value = '';
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_prof_usage';
	f.submit();
}

function doCloseSearch(){
	var f = document.getElementById('searchForm');
	
	if(f.sortField.value == '') {
		f.sortField.value = 'G026C002';
	} else {
		if(f.sortField.value == 'G026C001') {
			f.sortField.value = 'G026C002';
		} else {
			f.sortField.value = 'G026C001';
		}
	}	
	
	f.method = 'get';
	f.currentPage.value = 1;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_prof_usage';
	f.submit();
}

function doExcelDownload() {
	location.href = "${pageContext.request.contextPath}/muniv/stats/stats_prof_usage?type=EXCEL&item="+$("#item").val()+"&value="+$("#value").val();
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
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/stats_title_05.gif"  alt="결강현황" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;교수별 사용통계</td>
    </tr>
  </table>
</div>
<br />

<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_prof_usage" autocomplete="off">
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>목록</caption>
			<thead>
				<tr>
			        <th width="30" class="bg_left" scope="col">NO</td>
			        <th width="100" scope="col">단과</td>
			        <th width="120" scope="col">학과</td>
			        <th width="50" scope="col">사번</td>
			        <th width="100" scope="col">성명</td>
			        <th width="50" scope="col">총 강의수</td>
			        <th width="50" scope="col">처리수</td>
			        <th width="50" scope="col">미처리수</td>
			        <th width="50" scope="col">사용률</td>
			        <th width="40" scope="col"><a href="javascript:doCloseSearch()">마감<a/></td>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(pb.list)==0 }">
					<tr>
						<td class="tdwhite" colspan="9" align="center" style="padding:30px 0 30px 0; border-right:none;">검색결과가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="${pb.list}" varStatus="status">
						<c:choose>
							<c:when test="${b.PROF_ADM_CD eq 'G026C002'}">
								<c:set var="varClose" value="마감" />
							</c:when>
							<c:otherwise>
								<c:set var="varClose" value="&nbsp;" />
							</c:otherwise>
						</c:choose>
						
						<tr class="tr_over">
							<td>${b.ROW_NO}</td>
							<td>${b.COLL_NAME}</td>
							<td>${b.DEPT_NAME}</td>
							<td>${b.PROF_NO}</td>
							<td>${b.PROF_NAME}</td>
							<td>${b.TOT_CNT}</td>
							<td>${b.PROC_CNT}</td>
							<td>${b.NOT_PROC_CNT}</td>
							<td>${b.USAGE}%</td>
							<td>${varClose}</td>
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
			            <option value="coll_name"	<c:if test="${param.item=='coll_name'}">selected</c:if>>단과명</option>
						<option value="dept_name"	<c:if test="${param.item=='dept_name'}">selected</c:if>>학과명</option>
						<option value="prof_no"		<c:if test="${param.item=='prof_no'}">selected</c:if>>사번</option>
						<option value="prof_name"	<c:if test="${param.item=='prof_name'}">selected</c:if>>교수명</option>
					</select>
				<label class="alternate" for="fmString2">검색어 입력</label>
				<input type="text" id="value" name="value" value="${param.value}" class="search_txt" />
				<label class="alternate" for="btnSearch">검색</label>
				<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" onClick="javascript:doSearch()" />
				</fieldset>
			</div>
		</div>
	</div>
</div> <!-- board -->

<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="sortField" name="sortField" value="${param.sortField}">
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

