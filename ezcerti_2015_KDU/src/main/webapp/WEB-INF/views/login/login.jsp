<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script type="text/javascript">
function checkForm(f) {
	/* 
	if($('input:radio[name=input_rdo_user]:checked').length < 1){
		alert("선택해주세요.");
		return false;
	}
	 */
	if($("#j_username").val() == ""){
		alert("교번 / 사번을 입력해주세요.");
		$("#j_username").focus();
		return false;
	}
	 if($("#j_password").val() == ""){
		alert("비밀번호를 입력해주세요.");
		$("#j_password").focus();
		return false;
	}
}
</script>
	<!-- 로그인 이전 -->
	<sec:authorize access="isAnonymous()">
	<div id="login_area" style="width:100%;">
	<c:if test="${not empty error }">
		<div align="center" class="error-text">${error }</div>
	</c:if>
	<form action="${pageContext.request.contextPath}/static/j_spring_security_check" method="post" id="frm_login" onsubmit="return checkForm(this)">
	<table>
		<tr>
			<td colspan="2">
				<label><input type="radio" name="input_rdo_user" value="admin">학교관리자</label>
				<label><input type="radio" name="input_rdo_user" value="prof">교수</label>
				<label><input type="radio" name="input_rdo_user" value="student">학생</label>
			</td>
		</tr>
		<tr>
			<td class="frm_left">학번</td>
			<td>
				<input type="text" id="j_username" name="j_username" size="15">
			</td>
		</tr>
		<tr>
			<td class="login_area_left">비밀번호</td>
			<td class="login_area_right">
				<input type="password" id="j_password" name="j_password" size="15">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<label><input type="checkbox" name="_spring_security_remember_me">자동로그인</label><br>
				<button type="button" name="password_lost_btn">비밀번호찾기</button>
				<button type="submit" id="login_btn" name="login_btn">로그인</button>
			</td>
		</tr>
	</table>
	</form>
	</div>
	</sec:authorize>
	<!-- //로그인 이전-->
	
	<!-- 로그인 이후 -->
	<sec:authorize access="isAuthenticated()">
	<div id="login_area" style="width:100%;">
		<sec:authentication property="principal.username"/>
		<a href="${pageContext.request.contextPath}/static/j_spring_security_logout">로그아웃</a>
	</div>
	</sec:authorize>
	<!-- //로그인 이후 -->
