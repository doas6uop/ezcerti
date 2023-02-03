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
	
	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
});

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
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_academic';
	f.submit();
}

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
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_academic';
	f.submit();
}

function doPopupProfClassStats(prof_no, subject_cd, subject_div_cd) {
	
	var curr_year = $("#curr_year").val();
	var curr_term_cd = $("#curr_term_cd").val();
	
	var targetURL = "${pageContext.request.contextPath}/muniv/stats/stats_academic_prof_class?prof_no="+prof_no+"&subject_cd="+subject_cd+"&subject_div_cd="+subject_div_cd+"&curr_year=" + curr_year + "&curr_term_cd=" + curr_term_cd;
	
	window.open(targetURL,'classStatPop','width=1550, height=800,top=0,left=0, toolbar=no, menubar=no, scrollbars=yes')
}

function doExcelDownload() {
	
	var f = document.getElementById('searchForm');
	$("#type").val('EXCEL');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/muniv/stats/stats_academic';
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
<!-- 관리자출결현황 -->
<c:set var="pb" value="${pageBean }"/>	
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/stats_title_01.png"  alt="학기통계타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/prof/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;통계 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/prof/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;학기통계</td>
    </tr>
  </table>
</div>
<br />

<form id="searchForm" onsubmit="javascript:doSearch(''); return false;" method="get" action="${pageContext.request.contextPath}/muniv/stats/stats_academic" autocomplete="off">
	
	<div id="board">
		<table width="699" border="0" cellpadding="0" cellspacing="0" style="padding-top: 5px;">
		  <tr>
		    <td align="center" valign="middle">
			    <table width="665" border="0" cellspacing="0" cellpadding="0">
			      <tr>
			      	<td width="45px;">학기 :</td>
			        <td width="110px;">
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
			        <td width="45px;">
			        	<button type="button" onclick="submit()"><img src="/resources/images/prof/button_reload2.png" style="height: 24px; vertical-align: middle;"/></button>
			        </td>
			        <td width="auto;">&nbsp;</td>
			      </tr>
			    </table>
			    
			    <input type="hidden" id="curr_year" name="curr_year">
				<input type="hidden" id="curr_term_cd" name="curr_term_cd">
		    </td>
		  </tr>
		</table>
		<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>
	
		<div id="board_list">	
			
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<caption>게시판 목록</caption>
				<thead>
					<tr>
						<th width="20" class="bg_left" scope="col">번호</th>
						<th width="50" scope="col"><a href="javascript:changeOrder('SUBJECT_CD')">학수번호</a></th>
						<th width="20" scope="col"><a href="javascript:changeOrder('SUBJECT_DIV_CD')">분반</a></th>
						<th width="90" scope="col"><a href="javascript:changeOrder('CLASS_NAME')">교과목명</a></th>
						<th width="40" scope="col"><a href="javascript:changeOrder('PROF_DEPT_NM')">학과</a></th>
						<th width="30" scope="col"><a href="javascript:changeOrder('PROF_NO')">교수사번</a></th>
						<th width="30" scope="col"><a href="javascript:changeOrder('PROF_NAME')">교수명</a></th>
						<th width="35" scope="col">강의수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="b" items="${pb.list}">
				<tr>
					<td>${b.ROW_NO}</td>
					<td>${b.SUBJECT_CD }</td>
					<td>${b.SUBJECT_DIV_CD }</td>
					<td>${b.CLASS_NAME }</td>
					<td>${b.PROF_DEPT_NM }</td>
					<td><a href="javascript:doPopupProfClassStats('${b.PROF_NO}','${b.SUBJECT_CD}','${b.SUBJECT_DIV_CD}');">${b.PROF_NO }</a></td>
					<td><a href="javascript:doPopupProfClassStats('${b.PROF_NO}','${b.SUBJECT_CD}','${b.SUBJECT_DIV_CD}');">${b.PROF_NAME }</a></td>
					<td>${b.CLASS_CNT }</td>
				</tr>
				</c:forEach>
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
				            <option value="code"
							<c:if test="${param.item=='code'}">
								selected
							</c:if>
							>사번</option>
							<option value="name"
							<c:if test="${param.item=='name'}">
								selected
							</c:if>
							>교수명</option>
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

