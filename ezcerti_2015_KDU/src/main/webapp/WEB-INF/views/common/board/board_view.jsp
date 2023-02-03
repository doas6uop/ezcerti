<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<c:set var="varTitleName" value="" />
<c:choose>
	<c:when test="${param.board_type eq 'NOTICE'}">	
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
	        	//window.location.href=parent.document.referrer;
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 관리자 상세정보/수정 -->
	<div class="titlebg">
	  <table width="670" border="0" cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="320" height="75" align="left" valign="bottom">
			<c:if test="${board.board_type eq 'NOTICE'}">
				<img src="${pageContext.request.contextPath}/resources/images/board/notice_title.gif" alt="공지사항" />
			</c:if>
			<c:if test="${board.board_type eq 'QNA'}">
				<img src="${pageContext.request.contextPath}/resources/images/board/qna_title.gif" alt="문의사항" />
			</c:if>
	      </td>
	      <td width="340" align="right" valign="bottom">
			<img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="커뮤니티" /> &nbsp;커뮤니티 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;${varTitleName }
		  </td>
	    </tr>
	  </table>
	</div>
  
<form:form commandName="board">
<div id="board" class="mg_t20">
	<div id="board_write">
		<table border="0" cellpadding="0" cellspacing="0" summary="글읽기">
			<caption>글읽기</caption>
			<c:if test="${param.board_type eq 'NOTICE'}">
				<tr>
					<th>선택</th>
					<td>
						<label class="alternate" for="subject">선택</label>
						<c:choose>
							<c:when test="${board.board_subtype eq 'all' }">
								전체 공지
							</c:when>
							<c:otherwise>
								교수 공지
							</c:otherwise>
						</c:choose>						
					</td>
				</tr>
			</c:if>	
			<tr>
				<th>제목</th>
				<td>${board.title}</td>
			</tr>
			<c:if test="${board.board_type ne 'NOTICE'}">
			<tr>
				<th>작성자</th>
				<td>${board.reg_user_name} [${board.reg_date}]</td>
			</tr>
			</c:if>
			<tr>
				<th>내용</th>
				<td>
					${fn:replace(board.contents, cn, br)}
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
				<c:forEach var="b" items="${board.boardFileList}">
					<a href="javascript:doBoardFileView('${b.file_no}')">${b.org_file_name}</a><br/>
				</c:forEach>
				</td>
			</tr>
		</table>
	</div>
	
	<c:set var="varAuth" value="F" />
	<c:if test="${board.board_type eq 'NOTICE'}">
		<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF">
			<c:if test="${user_type eq '[ROLE_PROF]' && user_no eq board.reg_user_no}">
				<c:set var="varAuth" value="T" />
			</c:if>
			<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]'}">
				<c:set var="varAuth" value="T" />
			</c:if>
		</sec:authorize>
	</c:if>
	<c:if test="${board.board_type eq 'QNA'}">
		<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF, ROLE_STUDENT">
			<c:if test="${(user_type eq '[ROLE_PROF]' || user_type eq '[ROLE_STUDENT]') && user_no eq board.reg_user_no}">
				<c:set var="varAuth" value="T" />
			</c:if>
			<c:if test="${user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]'}">
				<c:set var="varAuth" value="T" />
			</c:if>
		</sec:authorize>
	</c:if>
	
	<div class="btn_area">
		<span>
			<a href="javascript:doList()"><img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" /></a>
		</span>

		<c:if test="${varAuth eq 'T'}">
		<span class="pd_l5">
			<a href="javascript:doModView()"><img src="${pageContext.request.contextPath}/resources/images/board/insert_btn.gif" alt="수정" /></a>
		</span>
		<span class="pd_l5">
			<a href="javascript:doDelete()"><img src="${pageContext.request.contextPath}/resources/images/board/del_btn.gif" alt="삭제" /></a>
		</span>
		</c:if>
	</div>
</div>

<c:if test="${board.board_type ne 'NOTICE'}">
<div id="board" class="mg_t20">
	<div id="board_view">
    <table border="0" cellspacing="0" summary="댓글목록">
        <tr>
          <td>
          	<p class="mg_t20 mg_b5"><img src="${pageContext.request.contextPath}/resources/images/board/reply_title.gif" alt="" /><span class="bold"> 한줄덧글 달기</span></p>
            <p>  
                <textarea id="cmmt" name="cmmt" rows="3" cols="70" class="float_left mg_b10"></textarea>
                <span class="float_left"><a href="javascript:doCmmtAction('INSERT', '')"> <img src="${pageContext.request.contextPath}/resources/images/board/comment_write.png" alt="확인" class="pd_l10" /></a></span>
            </p>
          </td>
        </tr>
        <!-- Comment Start -->
        <c:forEach var="cmt" items="${board.commentList}">
          <tr>
            <td class="reply_view">
            	<p class="float_left mg_t3"><span class="reply_con bold">${cmt.reg_user_name}</span>&nbsp;[${cmt.reg_date}]</p>
              <p class="float_left pd_l20 mg_t3">${fn:replace(cmt.cmmt, cn, br)}
                <c:if test="${(user_type eq '[ROLE_SYSTEM]' || user_type eq '[ROLE_ADMIN]') || cmt.reg_user_no eq user_no}"> <a href="javascript:doCmmtAction('DELETE', '${cmt.cmmt_no}')">&nbsp;<img src="${pageContext.request.contextPath}/resources/images/board/comment_delete.gif" alt="덧글삭제" /> </a> </c:if>
              </p>
            </td>
          </tr>
        </c:forEach>        
		</table>
	</div>
</div>
</c:if>		
	  
<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
<input type="hidden" id="searchItem" name="searchItem" value="${param.searchItem}">
<input type="hidden" id="searchValue" name="searchValue" value="${param.searchValue}">

<input type="hidden" id="board_type" name="board_type" value="${param.board_type}">
<input type="hidden" id="board_subtype" name="board_subtype" value="${param.board_subtype}">
<input type="hidden" id="board_no" name="board_no" value="${board.board_no}">
<input type="hidden" id="cmmt_no" name="cmmt_no">
<input type="hidden" id="file_no" name="file_no">
	
</form:form>
	<!-- //관리자 상세정보/수정 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>

