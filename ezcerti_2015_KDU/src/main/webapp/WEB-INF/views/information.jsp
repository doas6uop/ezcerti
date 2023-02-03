<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta charset="utf-8">
<title><spring:eval expression="@config['univ_title']"/> :: 온라인출석부</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/smoothness/jquery-ui-1.10.3.custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/sub_style.css">
<style>
img { border:0 }
.titlebg {
	margin-top:15px;
	background-image: url(${pageContext.request.contextPath }/resources/images/common/sub_title_bg.jpg);
	background-repeat: no-repeat;
	background-position: left bottom;
	height: 94px;
	width: 700px;
	text-align: center;
	font-family: "돋움", "돋움체";
	font-size: 12px;
	color: #515151;
}
.topback {
	font-family: "돋움", "돋움체";
	font-size: 12px;
	line-height: 18px;
	color: #000;
	background-color: #FFF;
	background-image: url(${pageContext.request.contextPath }/resources/images/common/faq_top_back.png);
	background-repeat: repeat-x;
	background-position: bottom;
	padding: 7px;
	margin-top: 5px;
	margin-bottom: 38px;
	border: 1px solid #BEBDBE;
	height: 120px;
	width: 685px;
}
.thdeepgray {
	font-family: "돋움", "돋움체";
	font-size: 12px;
	line-height: 18px;
	font-weight: bold;
	color: #FFF;
	background-color: #747474;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #bebdbe;
	padding: 5px;
}
.tdinfo {
	font-family: "돋움", "돋움체";
	font-size: 12px;
	line-height: 18px;
	color: #000;
	background-color: #EFEFEF;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #FFF;
	padding: 5px;
}
.bluebigfont {
	font-family: "돋움", "돋움체";
	font-size: 14px;
	line-height: 18px;
	font-weight: bold;
	color: #2E5E92;
}
.buttondiv {
	text-align: right;
	width: 690px;
	margin-top: 2px;
	margin-bottom: 20px;
}
</style>
<script>
$(document).ready(function(){
});
$(function() {

    $( "#accordion" ).accordion({
      collapsible: true,
      heightStyle: "content"
    });
  });
</script>
</head>

<body class="sub_body">
<div id="wrap">
<sec:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USER,ROLE_SYSTEM,ROLE_PROF,ROLE_STUDENT">
<div id="header">
	<jsp:include page="header.jsp"></jsp:include>
</div>
</sec:authorize>
<div id="article">
<div id="contents">
<!-- section -->
<div class="titlebg">
  <table width="670" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td width="320" height="65" align="left" valign="bottom"><img src="${pageContext.request.contextPath }/resources/images/common/sub_information_title.png" alt="FAQ 타이틀" /></td>
      <td width="340" align="right" valign="bottom"><img src="${pageContext.request.contextPath }/resources/images/common/home_icon.png" width="22" height="12" alt="홈아이콘" /> &nbsp;이용안내&nbsp;  <img src="${pageContext.request.contextPath }/resources/images/common/small_arrow_icon.png" width="4" height="12" alt="화살표" /> &nbsp; 이용안내</td>
    </tr>
  </table>
</div>
<br />
<sec:authorize access="isAnonymous()">
<div class="topback">
  <table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="120" height="120" rowspan="2" align="left"><img src="${pageContext.request.contextPath }/resources/images/common/menu_left_icon.png" /></td>
      <td width="200" height="45" align="left" class="bluebigfont">사용자 매뉴얼 다운로드</td>
      <td width="120" align="left" style="padding-right:150px;"></td>
    </tr>
    <tr>
      <td height="50" align="left" valign="top">
      등록일 : 2014-04-02<br>
      파일유형 : PDF<br>
      </td>
	  <td valign="top">
	      <a href="${pageContext.request.contextPath }/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath }/resources/images/common/btn_prof_manualdownload.png" style="margin-right:10px;"/></a>
	      <a href="${pageContext.request.contextPath }/resources/doc/student_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath }/resources/images/common/btn_student_manualdownload.png" /></a>
      </td>      
    </tr>
  </table>
</div>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_PROF">
<div class="topback">
  <table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="120" height="120" rowspan="2" align="left"><img src="${pageContext.request.contextPath }/resources/images/common/menu_left_icon.png" /></td>
      <td width="200" height="45" align="left" class="bluebigfont">이용방법 안내</td>
      <td width="120" align="left" style="padding-right:150px;"></td>
    </tr>
    <tr>
      <td height="50" align="left" valign="top">
      등록일 : 2014-04-29<br>
      파일유형 : PDF<br>      
      </td>
	  <td valign="top">
	      <a href="${pageContext.request.contextPath }/resources/doc/prof_manual.pdf" target="_blank"><img src="${pageContext.request.contextPath }/resources/images/common/btn_prof_manualdownload.png" style="margin-right:10px;"/></a>
	      <a href="${pageContext.request.contextPath }/resources/doc/교수-보강등록.pdf"><img src="${pageContext.request.contextPath }/resources/images/common/btn_class_add.png" style="margin-right:10px;"/></a>
	      <a href="${pageContext.request.contextPath }/resources/doc/교수-일괄처리.pdf"><img src="${pageContext.request.contextPath }/resources/images/common/btn_class_batch.png" /></a>
      </td>      
    </tr>
  </table>
</div>
</sec:authorize>
<h1 style="margin:20px 0;">FAQ</h1>
<div id="accordion">
  <h3>로그인 아이디 확인은 어떻게 하나요?</h3>
  <div>
    <p>교수님께서는 사번, 학생은 학번으로 로그인 하실 수 있습니다.</p>
  </div>
  <h3>비밀번호를 분실했습니다.</h3>
  <div>
    <p>로그인 화면 하단의 비밀번호 찾기를 통해 이메일로 임시 비밀번호를 발송해 드리고 있습니다.<br>
       회원정보에 이메일 주소가 등록되어있지 않다면 고객센터로 연락바랍니다.
    </p>
  </div>
  <h3>올바른 아이디와 패스워드로 로그인 시도를 해도 반응이 없습니다.</h3>
  <div>
    	인터넷 익스플로러의 문서모드가 표준모드(기본값)인지 확인해주세요.
    	<br>
    	<br>
    	<h4>＊Internet Explorer 8 ~ 10 사용자</h4>
    	<br>
    	<img src="${pageContext.request.contextPath }/resources/images/common/faq/faq_comp_02.jpg">
    	<br>
    	<br>
    	<h4>＊Internet Explorer 11 사용자</h4>
    	<br>
    	<img src="${pageContext.request.contextPath }/resources/images/common/faq/faq_comp_01.jpg">
    	<br>
  </div>
  <h3>사용방법은 어떻게 되나요?</h3>
  <div>
    <p>상단의 사용자 매뉴얼을 다운받으셔서 안내받아주십시오.</p>
  </div>
  <h3>정상적으로 출석했는데 출석상태가 결석으로 표시됩니다.</h3>
  <div>
    <p>강의가 종료되면 모든 학생이 자동으로 결석처리 되며<br> 
       강의의 출결정보가 아직 입력되지 않았기 때문입니다.<br>
       담당 교수님이나 조교님에게 문의바랍니다.
    </p>
  </div>
  <h3>고객센터 업무시간은 언제인가요?</h3>
  <div>
    <p>전화 상담<br>
      -고객센터 전화번호 : 1544-5105<br>
      -상담시간 : 평일(09:00 ~ 18:00)<br>
    </p>
  </div>
</div>
<!-- //section -->
</div>
</div>
<div id="right"><jsp:include page="aside1.jsp"></jsp:include></div>
<div style="clear: both;"></div>
<div id="footer"><jsp:include page="footer.jsp"></jsp:include></div>
</div>
</body>
<div id="not_visible"></div>
</html>

 