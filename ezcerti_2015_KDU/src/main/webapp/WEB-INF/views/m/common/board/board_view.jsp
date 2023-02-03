<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources_m/css/smoothness/jquery-ui-1.10.3.custom.css">

<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<c:set var="varMenuIdx" value="" />
<c:set var="varTitleName" value="" />
<c:choose>
	<c:when test="${param.board_type eq 'NOTICE'}">	
		<c:set var="varMenuIdx" value="05" />

		<c:if test="${user_type eq '[ROLE_PROF]'}">
			<c:set var="varMenuIdx" value="06" />
		</c:if>
		
		<c:set var="varTitleName" value="공지사항" />
	</c:when>
	<c:otherwise>
		<c:set var="varMenuIdx" value="06" />

		<c:if test="${user_type eq '[ROLE_PROF]'}">
			<c:set var="varMenuIdx" value="07" />
		</c:if>

		<c:set var="varTitleName" value="문의게시판" />
	</c:otherwise>
</c:choose>

<script>
$(document).ready(function(){
	$("#topmenu_${varMenuIdx}").removeClass('submenugrayfont').addClass('menubluefont');
 });

function doList(){
	var f = document.getElementById('board');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/board/board_list';
	f.submit();
}

function doView(){
	var f = document.getElementById('board');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/board/board_view';
	f.submit();
}

function doModView(){
	var f = document.getElementById('board');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/board/board_modify_view';
	f.submit();
}

function doDelete(){
	var postString = $("#board").serialize();
	var r = confirm("삭제하시겠습니까?");
	if(r==true){
		$.ajax({
	        type: "POST",
	
	        url: "${pageContext.request.contextPath}/comm/board/board_delete",
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	doList();
	        },
	        error: function(msg){
	        	alert("실패");
	        }
	    });
	}
} 

function doBoardFileView(file_no) {
	document.location.replace('${pageContext.request.contextPath}/comm/board/board_file_download?file_no='+file_no);
}

function doCmmtAction(type, val) {
	var r = "";
	var actionURL = "";
	
    if(type == 'INSERT') {
    	r = confirm("등록하시겠습니까?");
    	
    	actionURL = "${pageContext.request.contextPath}/comm/board/board_cmmt_insert";
    } else {
    	r = confirm("삭제하시겠습니까?");
    	
    	document.getElementById('cmmt_no').value = val;
    	actionURL = "${pageContext.request.contextPath}/comm/board/board_cmmt_delete";
    }

	var postString = $("#board").serialize();

	if(r==true){
		$.ajax({
	        type: "POST",
	
	        //url: "${pageContext.request.contextPath}/comm/board/board_cmmt_insert",
	        url : actionURL,
	
	        data: postString,
	
	        success: function(msg) {
	        	alert(msg);
	        	//location.reload(true);
	        	doView();
	        },
	        error: function(msg){
	        	alert("실패");
	        }
	    });
	}
}

</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- Title Start -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
	<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; ${varTitleName}
</div>
<!-- Title End -->

<!-- Contents Start -->
<form id="board" name="board" method="post">

<div class=biginfobg3>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px 5px 0px 5px">
		<tr>
			<td width="70%" height="30" align="left" class="deepgraytd"><strong>${board.title}</strong></td>
			<td width="30%" height="30" align="right" class="deepgraytd">[${board.reg_date}]<!-- br/>${board.reg_user_name}--></td>
		</tr>
		<tr>
			<td height="100%" colspan="2" align="left" class="graytd" style="padding:10px 5px 10px 5px">
				${fn:replace(board.contents, cn, br)}
			</td>
		</tr>
		<c:if test="${!empty board.boardFileList }">
		<tr>
			<td height="30" colspan="2" align="left" class="graytd">
			<c:forEach var="b" items="${board.boardFileList}">
				<a href="javascript:doBoardFileView('${b.file_no}')">${b.org_file_name}</a><br/>
			</c:forEach>
			</td>
		</tr>
		</c:if>
	</table>
	
	<!-- Comment Start -->
	<c:if test="${board.board_type ne 'NOTICE'}">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:0px 5px 0px 5px">
		<tr>
			<td colspan="2" valign="center" class="deepgraytd">
				<textarea id="cmmt" name="cmmt" rows="3" cols="30"></textarea>&nbsp;&nbsp;
				<a href="javascript:doCmmtAction('INSERT', '')"><img src="${pageContext.request.contextPath}/resources_m/images/btnRegister.png" style="max-width:50px;" alt="등록버튼" /></a>
			</td>		
		</tr>
		
		<c:forEach var="cmt" items="${board.commentList}" varStatus="status">
		<c:set var="varListClass" value="deepgraytd" />
		<c:if test="${(status.index mod 2) eq 0}"><c:set var="varListClass" value="graytd" /></c:if>
		<tr>
			<td width="25%" height="30" class="${varListClass}">${cmt.reg_user_name}<br/>[${cmt.reg_date}]</td>
			<td align="left" class="${varListClass}" >
				${fn:replace(cmt.cmmt, cn, br)}
				<c:if test="${(user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]') || cmt.reg_user_no eq user_no}">
					<a href="javascript:doCmmtAction('DELETE', '${cmt.cmmt_no}')"><font style="color: #FF0000">삭제</font></a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		
	</table>
	</c:if>
	<!-- Comment End -->

</div>
<div class="photobutton">
	<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" style="max-width:50px;" alt="목록버튼" /></a>&nbsp;
	<c:set var="varAuth" value="F" />
	<c:if test="${board.board_type eq 'NOTICE'}">
		<c:if test="${user_type eq '[ROLE_PROF]' && user_no eq board.reg_user_no}">
			<c:set var="varAuth" value="T" />
		</c:if>
		<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]'}">
			<c:set var="varAuth" value="T" />
		</c:if>
	</c:if>
	<c:if test="${board.board_type eq 'QNA'}">
		<c:if test="${(user_type eq '[ROLE_PROF]' || user_type eq '[ROLE_STUDENT]') && user_no eq board.reg_user_no}">
			<c:set var="varAuth" value="T" />
		</c:if>
		<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]'}">
			<c:set var="varAuth" value="T" />
		</c:if>
	</c:if>

	<c:if test="${varAuth eq 'T'}">
		<a href="javascript:doModView()"><img src="${pageContext.request.contextPath}/resources/images/admin/insert_button_s.png" style="max-width:50px;" alt="수정버튼"/></a>&nbsp;
		<a href="javascript:doDelete()"><img src="${pageContext.request.contextPath}/resources/images/admin/delete_button.png" style="max-width:50px;" alt="삭제버튼" /></a>
	</c:if>

</div>

<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="searchItem" name="searchItem" value="${param.searchItem}">
<input type="hidden" id="searchValue" name="searchValue" value="${param.searchValue}">

<input type="hidden" id="board_type" name="board_type" value="${param.board_type}">
<input type="hidden" id="board_no" name="board_no" value="${board.board_no}">
<input type="hidden" id="cmmt_no" name="cmmt_no">
<input type="hidden" id="file_no" name="file_no">

</form>
<!-- Contents End -->

<!-- Footer Start -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
<!-- Footer End -->

</body>
</html>
