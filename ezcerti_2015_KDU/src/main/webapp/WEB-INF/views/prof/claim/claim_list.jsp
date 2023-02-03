<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" uri="/my-taglib" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prof_style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sub_style.css">
<script>
$(document).ready(function(){
	$(".menu116 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_community_on.gif");
	$(".menu116 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_community_on.gif");
	showElementTop(16);
	showElement(16);
	
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
			$.getJSON("<c:url value='/prof/class/getclass'/>",{year:$('#curr_year').val(), term_cd: $('#curr_term_cd').val()}, function(j){
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

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
<!-- 교수 이의신청내역 -->
<c:set var="pb" value="${pageBean }"/>
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom">
      <img src="${pageContext.request.contextPath}/resources/images/prof/professor_claim_title.png"  alt="이의신청  타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/student/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;강의출결 &nbsp; <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" />  &nbsp;이의신청 </td>
    </tr>
  </table>
</div>
<form id="searchForm" method="get" action="${pageContext.request.contextPath}/prof/claim/claim_list" autocomplete="off">
<table width="699" border="0" cellpadding="0" cellspacing="0" class="listcheckbg">
  <tr>
    <td align="center" valign="middle"><table width="665" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="70" height="33" align="left">학기 :</td>
        <td width="192" height="33" align="left">
        
        <select name="term_cd" id="lst_term" class="searchlistbox" onChange="javascript:doChangeTerm(this)">
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
        <td width="56" height="33" align="left">강의명 :</td>
        <td width="235" height="33" align="left">
	        <select name="class_cd" id="lst_class" class="searchlistbox" style="width:180px;">
        		<option value="">전체</option>
        	</select>
        </td>
        <td width="112" rowspan="2"><button><img src="${pageContext.request.contextPath}/resources/images/prof/check_button.png" width="111" height="53" alt="조회버튼" /></button></td>
      </tr>
      <tr align="left">
        <td height="33">처리상태 :</td>
        <td height="33" colspan="3">
        <select name="claim_sts_cd" class="searchlistbox" id="lst_claim">
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
    </table></td>
  </tr>
</table>
<br>

<div id="board">
	<p class="pd_r5 bold t_right mg_b5">[총 ${pb.allCnt }건]</p>

	<div id="board_list">	
		<table width="700" border="0" cellspacing="0" cellpadding="0">
			<caption>이의신청 목록</caption>
			<thead>
				<tr>
					<th width="82" class="bg_left" scope="col">처리결과</th>
					<th scope="col">강의명</th>
					<th width="112" scope="col">강의일시</th>
					<th width="112" scope="col">학생명</th>
					<th width="115" scope="col">이의신청내역</th>
					<th width="107" scope="col">신청일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="b" items="${pb.list}">
			<tr onclick="claimView('${b.claim_no}')" onmouseover="this.style.backgroundColor='#effaf0'" onmouseout="this.style.backgroundColor=''" style="cursor:pointer;">
				<td>${b.claim_sts_name }</td>
				<td>${b.class_name }</td>
				<td>${b.classday } ${b.classhour_start_time }</td>
				<td>${b.student_name }</td>
				<td>${b.before_claim_name } <img src="${pageContext.request.contextPath}/resources/images/student/small_arrow_icon.png" width="4" height="12" alt="화살표" /> ${b.ask_claim_name }</td>
				<td>
			    	<fmt:formatDate value="${b.reg_date}" type="date" pattern="yyyy-MM-dd"/>
			    	<fmt:formatDate value="${b.reg_date}" type="time" pattern="HH:mm"/>			
				</td>
			</tr>
			</c:forEach>
			<c:if test="${empty pb.list }">
			<tr>
				<td align="center" colspan="6">데이터가 존재하지 않습니다.</td>
			</tr>
			</c:if>
			
			</tbody>
		</table>
	</div> <!-- board_list -->
</div> <!-- board -->

<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
	    <td height="18" align="center" class="paginggrayfont"><my:pageGroup/></td>
	</tr>
</table>
<input type="hidden" id="currentPage" name="currentPage">
<input type="hidden" id="curr_year" name="curr_year">
<input type="hidden" id="curr_term_cd" name="curr_term_cd">

</form>
<div id="dialog_claim_view" title="이의신청내역 상세보기"></div>
<!-- //교수 이의신청내역 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>