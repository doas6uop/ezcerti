<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<style type="text/css">
img { border:0 }
.divback {
	background-image: url(${pageContext.request.contextPath }/resources/images/common/popback.jpg);
	background-repeat: no-repeat;
	margin: 0px;
	height: 450px;
	width: 400px;
	font-family: "돋움", "돋움체";
	font-size: 12px;
	line-height: 18px;
	color: #333;
}
.closebutton {
	text-align: center;
	height: 30px;
	width: 400px;
	padding-top: 5px;
}
.titlefont {
	font-family: "돋움", "돋움체";
	font-size: 16px;
	font-weight: bold;
	color: #FFF;
}
</style>
</head>
<body topmargin="0" leftmargin="0">
<div class="divback">&nbsp;
  <table width="330" border="0" align="center" style="margin-top:65px;" cellpadding="0" cellspacing="0">
    <tr>
      <td height="49" colspan="2" align="left" valign="top" class="titlefont" style="padding-left:115px;">대전대학교 온라인 출석부 시스템 오픈 일정 변경 공지</td>
    </tr>
    <tr>
      <td height="22" align="center" valign="top" style="padding-top:7px;"><img src="${pageContext.request.contextPath }/resources/images/common/pop_icon.png" width="14" height="15" alt="icon" /></td>
      <td width="298" align="left"><strong>시스템 오픈 일정 변경 공지</strong><br /></td>
    </tr>
    <tr>
      <td height="36" align="left">&nbsp;</td>
      <td align="left">
        안녕하세요 대전대학교 학사서비스팀입니다.
        <br>
		<br>
		금일 오픈 예정이었던 온라인 출석부 시스템의 정식 오픈 일정이
		아래와 같이 변경되었습니다.
		<br>
		<br>
		정식 오픈일 : 2014-03-31 오전 09:00
		<br>
		<br>
		테스트 사이트(http://test.ezcerti.com/dju)는 정상적인 사용이 가능합니다.
		<br>
		자세한 사항은 대전대학교 학사서비스팀으로 문의바랍니다.
		<br>
		<br>
		대전대학교 30주년기념관 4층 406호
		<br>
		TEL : (042)280-2033~5
		<br>
		E-MAIL : onestop@dju.ac.kr
      </td>
    </tr>
  </table>
</div>
<div class="closebutton"><a href="javascript:window.close();"><img src="${pageContext.request.contextPath }/resources/images/common/close_button.png" alt="닫기버튼" /></a></div>
</body>
</html>