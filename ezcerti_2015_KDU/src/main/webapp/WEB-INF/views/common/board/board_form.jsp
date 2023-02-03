<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

function _sendAjax() {
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#boardFrm").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    if(!$("#title").val()){
    	alert("제목을 입력하세요.");
    	$("#title").focus();
    	return false;
    }
    
    $.ajax({
        type: "POST",

        url: "${pageContext.request.contextPath}/comm/board/board_form_submit",

        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},

        success: function(msg) {
        	alert(msg);
        	document.location.replace('${pageContext.request.contextPath}/comm/board/board_list');
        },
        error: function(msg){
        	alert(msg);
        }
	
    });
	
 };
 
 function sendAjax() {
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#boardFrm").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    var frm = new FormData(document.getElementById('boardFrm'));
    
    if(!$("#title").val()){
    	alert("제목을 입력하세요.");
    	$("#title").focus();
    	return false;
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/comm/board/board_form_submit",

        data: frm,
        dataType : 'text',
        processData : false,
        contentType : false,
        type : "POST",

        success: function(msg) {
        	alert(msg);
        	doList();
        },
        error: function(msg){
        	alert(msg);
        }
	
    });		
 };
 
function ajaxReturn(rlst, msg) {
	
	alert(msg);
	
	if(rlst == 'SUCCESS') {
		if(msg.indexOf("파일") == -1) {
			doList();
		}
	}
}
 
function doList(){
	var f = document.getElementById('boardFrm');
	f.method = 'post';
	f.action = '${pageContext.request.contextPath}/comm/board/board_list';
	f.submit();
}

</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">

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

<form id="boardFrm" enctype="multipart/form-data" onsubmit="javascript:sendAjax(); return false;">
	<div id="board">
		<div id="board_write">
			<table border="0" cellpadding="0" cellspacing="0" summary="글쓰기">
				<caption>글쓰기</caption>
				<c:if test="${param.board_type eq 'NOTICE'}">
					<tr>
						<th>선택</th>
						<td><label class="alternate" for="subject">선택</label>
							<select id="board_subtype" name="board_subtype">
								<option value="all">전체 공지</option>
								<option value="prof">교수 공지</option>
							</select>
						</td>
					</tr>
				</c:if>	
				<tr>
					<th>제목</th>
					<td><label class="alternate" for="subject">제목 입력</label>
					<input type="text" id="title" name="title" size="75"  value="" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><label class="alternate" for="contents">내용 입력</label>
					<textarea id="contents" name="contents" rows="5" cols="10" ></textarea></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><label class="alternate" for="file1">1번째 첨부파일 선택</label>
					<input type="file" id="uploadFile" name="uploadFile" /></td>
				</tr>
			</table>
		</div>
		<div class="btn_area">
			<span>
				<a href="javascript:doList()">
					<img src="${pageContext.request.contextPath}/resources/images/board/list_btn.gif" alt="목록" />
				</a>
			</span>
			<c:set var="varAuth" value="F" />
			<c:if test="${board.board_type eq 'NOTICE'}">
				<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF">
					<c:set var="varAuth" value="T" />
				</sec:authorize>
			</c:if>
			<c:if test="${board.board_type eq 'QNA'}">
				<sec:authorize ifAnyGranted="ROLE_SYSTEM, ROLE_ADMIN, ROLE_PROF, ROLE_STUDENT">
					<c:set var="varAuth" value="T" />
				</sec:authorize>
			</c:if>
			<c:if test="${varAuth eq 'T'}">
				<span class="pd_r10">
					<a href="javascript:sendAjax()">
						<img src="${pageContext.request.contextPath}/resources/images/board/write_btn.gif" alt="등록" />
					</a>
				</span>
			</c:if>	
		</div>
	</div>
	
	<input type="hidden" id="board_type" name="board_type" value="${board_type}">
	<c:if test="${param.board_type ne 'NOTICE'}">
		<input type="hidden" id="board_subtype" name="board_subtype" value="${board_subtype}">
	</c:if>
	
</form>

</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>
