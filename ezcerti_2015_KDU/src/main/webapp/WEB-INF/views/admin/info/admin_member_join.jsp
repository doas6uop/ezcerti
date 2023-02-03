<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<sec:authorize ifAnyGranted="ROLE_SYSTEM">
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
<script>
$(document).ready(function(){
	$(".menu6 .top_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/top/topmenu_admin_on.gif");
	$(".menu6 .aside_menu_img").removeAttr("onmouseout").attr("src", "${pageContext.request.contextPath}/resources/images/aside/smenu_admin_on.gif");
	$("#in_topmenu6").css("display","block");
	$("#in_menu6").css("display","block");
});
var check=0;

$(function() {
	   $( "#idChkDialog" ).dialog({      
	       autoOpen: false,      
	       height: 300,      
	       width: 400,
	       modal: true,      
	       resizable: false,
	       buttons: {
	           확인: function() {
	        	   if(check!=1){
	        		   document.getElementById("searchValue").innerHTML="사번을 입력해 주세요.";
						idSearch.focus();
	        	   }else{
	        		   document.getElementById("admin_no").value = document.getElementById("idSearch").value;
		              $( this ).dialog( "close" );
	        	   }
	           }
	         }   
	      });
	  });
	  
function idChk(){
	 
	var sf = document.getElementById("searchForm");
	var idSearch = document.getElementById("idSearch");
	var idReg = /^[0-9]{5,19}$/g;
	
	if(idSearch.value==""){
		document.getElementById("searchValue").innerHTML="사번을 입력해주세요.";
		idSearch.focus();
		return false;
	}else if(!idReg.test($("#idSearch").val())){
		document.getElementById("searchValue").innerHTML="사번은 5자리 이상의 알파벳 또는 숫자만 입력가능합니다.";
    	$("#idSearch").focus();
    	return false; 
	}
	
	 $.ajax({
	        type: "POST",

	        url: "${pageContext.request.contextPath}//muniv/info/admin_member_chk",

	        data: {user_no: $("#idSearch").val() },   //post 형식 전송형태 data: {인자명 : 데이터, num:num},

	        success: function(msg) {
	        	if(msg.indexOf('no')>-1){
	        		document.getElementById("searchValue").innerHTML="이미 가입된 사번입니다.";
	        		$("#searchValue").focus();
	        		check=0;
	        	}else if(msg.indexOf('ok')>-1){
	        		document.getElementById("searchValue").innerHTML="사용가능한 사번입니다.";
	        		check=1;
	        	}else{
	        		document.getElementById("searchValue").innerHTML="오류가 발생하였습니다.";
	        	}
	        },
	        error: function(msg){
	        	
	        }
		
	    });
	
	
}	  
$(function(){
	$("select#lst_coll").change(function(){
		$.getJSON("<c:url value='/muniv/info/getdept'/>",{coll_cd: $('#lst_coll').val()}, function(j){
			var options = '<option value="">학과를 선택해주세요.</option>';
			for (var i = 0; i < j.length; i++) 
			{
				options += '<option value="' + j[i].dept_cd + '">' + j[i].dept_name+' ('+j[i].dept_cd+')'+'</option>';
				
			}
			$("#lst_dept").html(options);
			$('#lst_dept option:first').attr('selected', 'selected');
		});
	}); 	
});

function sendAjax() {
	
	var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	var email_regx=/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    var postString = $("#admin").serialize();
    var idReg = /^[0-9]{5,19}$/g;
    var regEmpPwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

    if(!$("#admin_no").val()){
    	alert("사번을 입력하세요.");
    	$("#admin_no").focus();
    	return false;
    }else if(!idReg.test($("#admin_no").val())){
    	alert("사번은 영문자 또는 숫자만 입력가능합니다.");
    	$("#admin_no").focus();
    	return false;    	
    }else if(!$("#lst_coll").val()){
    	alert("단과를 선택해주세요.");
    	$("#lst_coll").focus();
    	return false;
    }else if(!$("#lst_dept").val()){
    	alert("학과를 선택해주세요.");
    	$("#lst_dept").focus();
    	return false;
	}else if(!$("#admin_name").val()){
    	alert("관리자명을 입력하세요.");
    	$("#admin_name").focus();
    	return false;
	}else if(!$("#hp_no").val()){
    	alert("전화번호를 입력하세요.");
    	$("#hp_no").focus();
    	return false;
    }else if(!regExp.test($("#hp_no").val())){
    	alert("잘못된 전화번호입니다. 숫자, - 를 포함한 숫자만 입력하세요. 예) 010-XXXX-XXXX");
    	$("#hp_no").focus();
    	return false;
    }else if(!$("#email_addr").val()){
    	alert("이메일을 입력하세요.");
    	$("#email_addr").focus();
    	return false;
    }else if(!email_regx.test($("#email_addr").val())){
    	alert("잘못된 이메일 형식입니다.");
    	$("#email_addr").focus();
    	return false;
    }else if($("#admin_passwd1").val()!=$("#admin_passwd2").val()){
    	alert("비밀번호가 일치하지 않습니다.");
    	$("#admin_passwd1").focus();
    	return false;
    }else if(!regEmpPwd.test($("#admin_passwd1").val())){
        alert('8~15자의 영문/숫자/특수문자 혼용만 가능합니다.');
        $("#admin_passwd1").val();
        $("#admin_passwd1").focus();
        return false;
    }
    
    $.ajax({
        type: "POST",

        url: "${pageContext.request.contextPath}/muniv/info/admin_member_join",

        data: postString,   //post 형식 전송형태 data: {인자명 : 데이터, num:num},

        success: function(msg) {
        	alert(msg);
        	document.location.replace('${pageContext.request.contextPath}/muniv/info/admin_list');
        },
        error: function(msg){
        	alert(msg);
        }
	
    });
	
 };
</script>
</head>

<body>
<div id="wrap">
<div id="header"><jsp:include page="../../header.jsp"></jsp:include></div>
<div id="article">
<div id="contents">
	<!-- 관리자 등록 -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="75" align="left" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/sub_admin_title_03.png"  alt="강의일정보타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath}/resources/images/admin/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;관리자 &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp;사용자등록</td>
    </tr>
  </table>
</div>
<form:form commandName="admin" onsubmit="javascript:sendAjax(); return false;">
<table width="699" border="0" cellpadding="0" cellspacing="0" class="admininfobg">
  <tr>
    <td align="center" valign="middle"><table width="610" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="155" height="40" class="grayhd">소 속</td>
        <td class="deepgraytd" >
	        <form:select path="coll_cd" id="lst_coll" cssClass="searchlistbox">
	        	<form:option value="">단과를 선택해주세요.</form:option>		
	        <c:forEach var="c" items="${collList}" >
       			<form:option value="${c.coll_cd }" >${c.coll_name }</form:option>
	        </c:forEach>
	        </form:select>
	        <form:select path="dept_cd" id="lst_dept" cssClass="searchlistbox">
	        </form:select>
        </td>
      </tr>
      <tr>
        <td width="155" height="40" class="deepgrayhd">사 번</td>
        <td class="graytd">
        	<form:input path="admin_no" class="searchtextbox" onclick="$('#idChkDialog').dialog('open')" readonly="true"/>
        </td>
      </tr>
      <tr>
        <td width="155" height="40" class="grayhd">관리자명</td>
        <td class="deepgraytd">
        	<form:input path="admin_name" class="searchtextbox"/>
        </td>
      </tr>
      <tr>
        <td width="155" height="40" class="deepgrayhd">휴대전화</td>
        <td class="graytd"><form:input path="hp_no" cssClass="searchtextbox" /></td>
      </tr>
      <tr>
        <td width="155" height="40" class="grayhd">이메일</td>
        <td class="deepgraytd"><form:input path="email_addr" cssClass="searchtextbox" /></td>
      </tr>
      <tr>
        <td width="155" height="40" class="deepgrayhd">비밀번호</td>
        <td class="graytd"><form:password path="admin_passwd" id="admin_passwd1" cssClass="searchtextbox"/></td>
      </tr>
      <tr>
        <td width="155" height="40" class="grayhd">비밀번호확인</td>
        <td class="deepgraytd"><input type="password" id="admin_passwd2" class="searchtextbox"></td>
      </tr>
    </table></td>
  </tr>
</table>
  <div class="aligncenter">
  	<a href="javascript:window.location.href=parent.document.referrer;"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a>&nbsp;&nbsp;
  	<form:button><img src="${pageContext.request.contextPath}/resources/images/admin/register_button.png" width="61" height="27" alt="등록버튼" /></form:button>
  </div>
  </form:form>
	<div id="idChkDialog">
		<div id="searchValue">사번을 입력해주세요.</div>
		<form id="searchForm" action="javascript:idChk(); return false;">
	  		<input type="text" id="idSearch" name="idSearch" size="20">
	  		<input type="button" id="idSearchBtn" value="찾기" onclick="idChk()">
	 	</form>
	</div>  
	<!-- //관리자 등록 -->
</div>
</div>
<div id="right"><jsp:include page="../../aside.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="../../footer.jsp"></jsp:include></div>
</div>
</body>
</html>
</sec:authorize>
