<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/muniv/info/gonggyul_search_popup';
	f.submit();
}

function doSelectedTarget(userNo, userName) {
	if(!$("#student_no", opener.document).val()) {
		$("#student_no", opener.document).val(userNo);
		$("#student_name", opener.document).val(userName);
		$("#to_user_name_span", opener.document).text(userName);
		
		window.close();
	} else {
		if($("#student_no", opener.document).val().indexOf(userNo) != -1) {
			alert("이미 지정되어 있습니다.");			
		} else {
			$("#student_no", opener.document).val(userNo);
			$("#student_name", opener.document).val(userName);
			$("#to_user_name_span", opener.document).text(userName);

			// 텍스트 초기화
			$('#class_name_box', opener.document).html("");
			$("#class_name_box", opener.document).text("공결일자를 선택해 주세요.");
			$('#sdate', opener.document).val("");
			$('#edate', opener.document).val("");
			window.close();
		}
	}
}
</script>
</head>

<body>
<div id="contents" style="padding-left: 10px;">
	<!-- 교수목록조회 -->
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
		  <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_06.gif"  alt="학생목록" /></td>
		  <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;학생목록</td>
	    </tr>
	  </table>
	</div>
  
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/muniv/info/gonggyul_search_popup" autocomplete="off">
<div id="board" class="pd_l10 pd_r10">
	<p class="t_right bold mg_b5">[총 ${pb.allCnt }건]</p>
	<table border="0" cellpadding="0" cellspacing="0" class="tstyle_col1">
		<tr>
			<th>번호</th>
			<th >학과</th>
			<th >학번</th>
			<th >학생명</th>
			<th >연락처</th>
			<!-- <th >공결상태</th> -->
		</tr>
		<c:choose>
			<c:when test="${fn:length(pb.list)==0 }">
				<tr>
					<td colspan="7">검색결과가 존재하지 않습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="b" items="${pb.list}">
				<tr class="tr_over">
					<td>${b.row_no}</td>
					<td>${b.dept_name}</td>
					<td><a href="javascript:doSelectedTarget('${b.student_no }','${b.student_name}')">${b.student_no }</a></td>
					<td><a href="javascript:doSelectedTarget('${b.student_no }','${b.student_name}')">${b.student_name }</a></td>
					<td>${b.hp_no}</td>
					<!-- <td>공결상태</td> -->
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<div class="pagination">
		<div class="page_num" style="width: auto;">
			<my:pageGroup/>
		</div>
	</div>
	 
	<div class="search_area">
		<div class="search">
			<h4 class="float_left mg_t3"><img src="${pageContext.request.contextPath}/resources/images/board/search_title.gif" alt="search" /></h4>
			<div class="float_left pd_l15">
				<fieldset>
				<legend>통합검색</legend>
				<label class="alternate" for="fmSearch2">검색목록</label>
				<select id="item" name="item">
					<option value="name"
					<c:if test="${param.item=='name'}">
						selected
					</c:if>
					>학생명</option>
					<option value="code"
					<c:if test="${param.item=='code'}">
						selected
					</c:if>
					>학번</option>
				</select>
				<label class="alternate" for="fmString2">검색어 입력</label>
				<input type="text" id="value" name="value" value="${param.value}" class="search_txt hanText"/>
				<label class="alternate" for="btnSearch">검색</label>
				<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
				</fieldset>
			</div>
		</div>
	</div>
</div>

<table width="100%">
<tr>
	<td align="center">
		<a href="javascript:window.close();"><img src="${pageContext.request.contextPath }/resources/images/common/close_button.png" alt="닫기버튼" /></a>
	</td>
</tr>
</table>

<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="coll_cd" name="coll_cd">
<input type="hidden" id="dept_cd" name="dept_cd">
</form>
<p>&nbsp;</p>
	<!-- //교수목록조회 -->
</div>
</body>
</html>

