<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script>
$(document).ready(function(){
	$("#topmenu_05").removeClass('submenugrayfont').addClass('menubluefont');

	var termVal = $("#lst_term option:selected").val();
	splitTerm(termVal);
	
	if("[ROLE_PROF]" == "${sessionScope.USER_TYPE}") {
		if($("select#lst_term").length>0){
			$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
				var options = "<option value=''>전체</option>";
				for (var i = 0; i < j.length; i++) 
				{
					if(j[i].class_cd=='<c:out value="${class_cd}"/>'){
						options += '<option value="' + j[i].class_cd + '" selected="selected">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
					}else{
						options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
					}
					
				}
				$("#lst_class").html(options);
				//$('#lst_dept option:first').attr('selected', 'selected');
			});
		}
	}
 });
 
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
	f.method = 'get';
	f.currentPage.value = currentPage;
	f.action = '${pageContext.request.contextPath}/prof/claim/claim_list';
	f.submit();
}
$(function(){
	if("[ROLE_PROF]" == "${sessionScope.USER_TYPE}") {
		$("select#lst_term").change(function(){
			$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$("#curr_year").val(), term_cd: $('#curr_term_cd').val()}, function(j){
				var options = "<option value=''>전체</option>";
				for (var i = 0; i < j.length; i++) 
				{
					options += '<option value="' + j[i].class_cd + '">(' + j[i].classday_name+') '+j[i].classhour_start_time+' | '+j[i].class_name+'</option>';
					
				}
				$("#lst_class").html(options);
				$('#lst_class option:first').attr('selected', 'selected');
			});
		});
	}
});
$(function() {
	  $( "#dialog_claim_view" ).dialog({
	    autoOpen: false,
	    resizable: false,
	    draggable: false,
	    width:310,
	    height:440,
	    modal: true,
        show: "drop",
        hide: "drop",	    
	    buttons: {
	      "처리완료": function() {
	    	  if($("#claim_sts_cd").val() == 'G028C002'){
    		  	alert("이미 처리되었습니다.");
    		  	return false;
	    	  }else if(!$("#reply_claim_content").val() && $("#resClassFlag").val() == "Y"){
	    		alert("처리내역을 입력해주세요.");
	    		$("#reply_claim_content").focus();
	    		return false;
	    	  }else{
	    		  <c:choose>
	    		  <c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
	    		  	alert("학기가 마감되어 변경이 불가능합니다.");
	    		  	window.location.reload(true);
	    		  </c:when>
	    		  <c:otherwise>		    		  
	    		var r=confirm("처리 하시겠습니까?");
	  	        $( this ).dialog( "close" );
	  	    	if (r==true){
		    		var postString = $("#frm_claim").serialize();
		    		
		    	    $.ajax({
		    	        type: "POST",
		    	        url: "${pageContext.request.contextPath}/prof/claim/claim_confirm",
		    	        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},
		    	        success: function(msg) {
		    	        	alert(msg);
		    	        	window.location.reload(true);
		    	        },
		    	        error: function(msg){
		    	        	alert(msg);
		    	        }
		    	    });	 
	  	    	}
	  	    	</c:otherwise>
	  	    	</c:choose>
	    	  }
	      },	    	
	      "닫기": function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
	});
function claimView(claim_no){
	$("#dialog_claim_view").load('${pageContext.request.contextPath}/prof/claim/claim_view',{claim_no:claim_no});
	$('#dialog_claim_view').dialog('open');
	
}
</script>
</head>

<body bgcolor="#f0f0f0">
<div>
	<jsp:include page="../../header.jsp"></jsp:include>
</div>
<!-- 이의신청내역 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebox">
<img src="${pageContext.request.contextPath}/resources_m/images/subtitleb_icon.png" style="max-width:13px;" alt="아이콘">&nbsp; 이의 신청</div>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/claim/claim_list" autocomplete="off">
<div class="subsearchbg">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="21%" height="40" align="right">학기 :</td>
      <td width="35%" align="left">
      
      <select name="term_cd" id="lst_term" class="searchlistbox" style="max-width:120px;" onChange="javascript:doChangeTerm(this)">
        	<c:forEach var="term" items="${termList }">
        		<c:choose>
        			<c:when test="${year eq term.year and term_cd==term.term_cd }">
        				<option value="${term.year}:${term.term_cd }" selected="selected">${term.term_name }</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${term.year}:${term.term_cd }">${term.term_name }</option>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>
      </select>
      
      </td>
      <td width="23%" align="right">처리상태 :</td>
      <td colspan="2" width="19%" align="left">
       <select name="claim_sts_cd" class="searchlistbox" id="lst_claim" style="max-width:100px;">
        <option value="">전체</option>
          <c:forEach var="c" items="${claimCodeList }">
        		<c:choose>
        			<c:when test="${claim_sts_cd==c.code }">
        				<option value="${c.code }" selected="selected">${c.code_name }</option>
        			</c:when>
        			<c:otherwise>
        				<option value="${c.code }">${c.code_name }</option>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>	
        </select>
     </td>
    </tr>
    <tr>
      <td width="21%" height="33" align="right">강의명 :</td>
      <td colspan="2" width="66%" align="left">
		<select name="class_cd" id="lst_class" class="searchlistbox" style="width:120px;">
        		<option value="">전체</option>
       	</select>
      </td>
      <td width="10%" align="center" valign="bottom"><div class="visual">
        <button><img src="${pageContext.request.contextPath}/resources_m/images/search_button.png" style="max-width:63px;" alt="검색버튼"></button>
      </div></td>
    </tr>
  </table>
</div>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5%" style="min-width:45px;">
    <c:if test="${cPage>1 }">
    <div class="visual">
    <a href="javascript:paging(${cPage-1 })"><img src="${pageContext.request.contextPath}/resources_m/images/beforeb_button.png" style="max-width:45px;" alt="이전버튼"></a>
    </div>
    </c:if>
    </td>
    <td width="90%" align="center" class="blackboldfont">[총 ${pb.allCnt }건]</td>
    <td width="5%" align="right" style="min-width:45px;">
    <c:if test="${pb.totalPage > cPage }">
    <div class="visual">
    <a href="javascript:paging(${cPage+1 })"><img src="${pageContext.request.contextPath}/resources_m/images/nextb_button.png" style="max-width:45px;" alt="다음버튼"></a>
    </div>
    </c:if>
    </td>
  </tr>
</table>
<div class="tablelayout">
<c:forEach var="b" items="${pb.list }">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="subbluebox" onclick="claimView('${b.claim_no}')">
  <tr>
    <td width="20%" rowspan="2" align="center" valign="middle" class="rightbluebox">
    <c:choose>
     <c:when test="${b.claim_sts_cd=='G028C001' }">
     처리전
     </c:when>
     <c:when test="${b.claim_sts_cd=='G028C002' }">
     처리<br>완료
     </c:when>
    </c:choose>
    </td>
    <td width="60%">&nbsp;${b.classday } ${b.classhour_start_time }</td>
    <td width="20%" align="right" style="padding-right:5px">${b.student_name }</td>
    </tr>
  <tr>
    <td height="33" class="graysmallfont">${b.class_name }</td>
    <td align="right" style="padding-right:5px">03-12</td>
    </tr>
</table>
</c:forEach>
<c:if test="${empty pb.list }">
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" class="subbluebox">
	<tr>
		<td align="center">데이터가 존재하지 않습니다.</td>
	</tr>
</table>
</c:if>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
	<tr>
	    <td height="25" align="center" class="paginggrayfont"><my:pageGroupMobile/></td>
	</tr>
</table>
</div>
<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="curr_year" name="curr_year">
<input type="hidden" id="curr_term_cd" name="curr_term_cd">
</form>
<div id="dialog_claim_view"></div>
<!-- //이의신청내역 -->
<div>
	<jsp:include page="../../footer.jsp"></jsp:include>
</div>
</body>
</html>
