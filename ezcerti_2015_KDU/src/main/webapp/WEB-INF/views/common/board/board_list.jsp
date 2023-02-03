<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<c:set var="varTitleName" value="" />
<c:choose>
	<c:when test="${board_type eq 'NOTICE'}">	
		<c:set var="varTitleName" value="공지사항" />
	</c:when>
	<c:otherwise>
		<c:set var="varTitleName" value="문의게시판" />
	</c:otherwise>
</c:choose>

<script>
$(document).ready(function(){
	<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSTEM">
		$(".menu4 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_04.gif");
		$(".menu4 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif");
		$("#in_topmenu4").css("display","block");
		$("#in_menu4").css("display","block");
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_PROF">
		$(".menu16 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_menu_ov_04.gif");
		$(".menu16 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/admin/admin_smenu_ov_04.gif");
		$("#in_topmenu16").css("display","block");
		$("#in_menu16").css("display","block");
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		$(".menu24 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_community_on.gif");
		$(".menu24 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_community_on.gif");
		showElementTop(24);
		showElement(24);
	</sec:authorize>
});

function paging(currentPage){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/comm/board/board_list';
	f.submit();
}

function doSearch(){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.currentPage.value = 1;
	f.searchValue = "";
	f.action = '${pageContext.request.contextPath}/comm/board/board_list';
	f.submit();
}

function doView(board_no){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.board_no.value = board_no;
	f.action = '${pageContext.request.contextPath}/comm/board/board_view';
	f.submit();
}

function doWrite(board_type){
	var f = document.getElementById('searchForm');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/board/board_form';
	f.submit();
}

function doChangeSubject() {
	doSearch();
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 게시판 목록 -->
	<c:set var="pb" value="${pageBean }"/>
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom">
			<c:if test="${board_type eq 'NOTICE'}">
				<img src="${pageContext.request.contextPath}/resources/images/board/notice_title.gif" alt="공지사항" />
			</c:if>
			<c:if test="${board_type eq 'QNA'}">
				<!-- UNIV_IMAGE -->
				<img src="${pageContext.request.contextPath}/resources/images/board/qna_title.gif" alt="문의사항" />
			</c:if>
		  </td>
	      <td width="340" align="right" valign="bottom">
			<img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="커뮤니티" /> &nbsp;커뮤니티 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;${varTitleName }
		  </td>
	    </tr>
	  </table>
	</div>
	<br />
	
	<form id="searchForm" onsubmit="javascript:doSearch(); return false;" method="post" autocomplete="off">
		<div id="board">
			<table border="0" width="100%">
				<tr>
					<td>
						<c:if test="${sessionScope.USER_TYPE eq '[ROLE_SYSTEM]' or sessionScope.USER_TYPE eq '[ROLE_ADMIN]' or sessionScope.USER_TYPE eq '[ROLE_PROF]'}">
							<c:if test="${board_type eq 'NOTICE'}">
								<span class="pd_r5 bold t_right">선택 :</span> 
								<select id="board_subtype" name="board_subtype" onChange="javascript:doChangeSubject()">
									<option value="all" <c:if test="${board_subtype eq null}">selected</c:if>>전체 공지</option>
									<option value="prof" <c:if test="${board_subtype eq 'prof'}">selected</c:if>>교수 공지</option>
								</select>
							</c:if>
						</c:if>
					</td>
					<td align="right"><p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>	</td>
				</tr>
			</table>
		
			<div id="board_list">	
				
				<table width="700" border="0" cellspacing="0" cellpadding="0">
					<caption>게시판 목록</caption>
					<thead>
						<tr>
							<th width="15%" class="bg_left" scope="col">번호</th>
							<th scope="col">제목</th>
							<th width="15%" scope="col">작성자</th>
							<th width="15%" scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="b" items="${pb.list}">
					<tr>
						<td>${b.row_no }</td>
						<td class="list_title">
							<a href="javascript:doView('${b.board_no }')">${b.title }&nbsp;<c:if test="${board_type ne 'NOTICE'}">(${b.cmmt_cnt})</c:if></a>	        
						</td>
						<td>${b.reg_user_name }</td>
						<td>${b.reg_date }</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			</div> <!-- board_list -->
			<div class="btn_area">
				<c:if test="${board_type eq 'NOTICE'}">
					<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN">
						<a href="javascript:doWrite('${board_type}')">
							<img src="${pageContext.request.contextPath}/resources/images/board/write_btn.gif" alt="등록버튼" />
						</a>
					</sec:authorize>
				</c:if>
				<c:if test="${board_type eq 'QNA'}">
					<a href="javascript:doWrite('${board_type}')">
						<img src="${pageContext.request.contextPath}/resources/images/board/write_btn.gif" alt="등록버튼" />
					</a>
				</c:if>
			</div>
			<div class="pagination">
				<div class="page_num"> 
					<my:pageGroup/>
				</div>
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
							<select id="searchItem" name="searchItem">
								<option value="title"
								<c:if test="${param.searchItem eq 'title'}">
									selected
								</c:if>
								>제목</option>
								<option value="name"
								<c:if test="${param.searchItem eq 'name'}">
									selected
								</c:if>
								>등록자명</option>
							</select>
						<label class="alternate" for="fmString2">검색어 입력</label>
						<input type="text" id="searchValue" name="searchValue" value="${param.searchValue}" class="search_txt" />
						<label class="alternate" for="btnSearch">검색</label>
						<input name="btnSearch" type="image" src="${pageContext.request.contextPath}/resources/images/board/search_btn.gif" alt="검색" id="btnSearch" />
						</fieldset>
					</div>
				</div>
			</div>
		</div> <!-- board -->
	
		<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
		<input type="hidden" id="board_type" name="board_type" value="${board_type}">
		<input type="hidden" id="board_no" name="board_no">
	</form>

	<!-- //관리자목록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>