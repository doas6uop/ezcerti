<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${sessionScope.PROF_INFO.prof_adm_cd=='G026C002' }">
		<script>
			alert("학기가 마감되어 변경이 불가능합니다.");
			window.location.reload(true);
		</script>
	</c:when>
	<c:otherwise>
<!-- 휴/보강 취소 popup -->
<div id="restore_class">

<c:if test="${empty beforeClass}">
	<p align="center" style="background-image: url(${pageContext.request.contextPath}/resources/images/prof/title_bg.gif); 
	background-repeat:no-repeat;height:60px; padding-top:14px; color:#fff; font-weight:bold;">
		${currentClass.class_name }
	</p>
	<p>${currentClass.classday } (${currentClass.classday_name }) ${currentClass.classhour_start_time } ~ ${currentClass.classhour_end_time }</p>
	<c:if test="${currentClass.class_type_cd=='G019C003' }">
	<br>
		<p>선택한 보강정보가 삭제되며 복구하실 수 없습니다.</p>
		<p>강의를 삭제하시겠습니까?</p>
	</c:if>
	<c:if test="${currentClass.class_type_cd=='G019C002' }">
		<p>선택한 휴강이 정상강의로 변경되며 휴강취소됩니다.</p>
		<p>휴강을 취소하시겠습니까?</p>
	</c:if>
</c:if>
<c:if test="${not empty beforeClass}">
	<p align="center" style="background-image: url(${pageContext.request.contextPath}/resources/images/prof/title_bg.gif); 
	background-repeat:no-repeat;height:60px; padding-top:14px; color:#fff; font-weight:bold;">
		${currentClass.class_name}
	</p>
	<c:if test="${currentClass.class_type_cd=='G019C002' and beforeClass.class_type_cd=='G019C003' }">
		<p style="background-image: url(${pageContext.request.contextPath}/resources/images/prof/title_box.gif); 
	background-repeat:no-repeat;height:70px; padding-top:14px; line-height:27px;">
		<img src = "${pageContext.request.contextPath }/resources/images/admin/icon_01.png" align="absmiddle" style="margin-left:15px;">
	휴강일 : ${currentClass.classday } (${currentClass.classday_name }) ${currentClass.classhour_start_time }<br>
		<img src = "${pageContext.request.contextPath }/resources/images/admin/icon_01.png" align="absmiddle" style="margin-left:15px;">
			 보강일 : ${beforeClass.classday } (${beforeClass.classday_name }) ${beforeClass.classhour_start_time }
	</p>
	</c:if>
	<c:if test="${currentClass.class_type_cd=='G019C003' and beforeClass.class_type_cd=='G019C002' }">
		<p style="background-image: url(${pageContext.request.contextPath}/resources/images/prof/title_box.gif); 
	background-repeat:no-repeat;height:70px; padding-top:14px; line-height:27px;">
	<img src = "${pageContext.request.contextPath }/resources/images/admin/icon_01.png" align="absmiddle" style="margin-left:15px;">
	보강일 : ${currentClass.classday } (${currentClass.classday_name }) ${currentClass.classhour_start_time }<br>
	<img src = "${pageContext.request.contextPath }/resources/images/admin/icon_01.png" align="absmiddle" style="margin-left:15px;">
	휴강일 : ${beforeClass.classday } (${beforeClass.classday_name }) ${beforeClass.classhour_start_time }
	</p>
	</c:if>
	<br>	 
	<p>보강은 삭제되고 휴강은 정상강의로 전환됩니다.</p>
	<p>처리된 강의는 다시 복구할 수 없습니다.</p>
	<input type="hidden" name="before_classday" value="${beforeClass.classday }">
	<input type="hidden" name="before_classhour_start_time" value="${beforeClass.classhour_start_time }">
	<input type="hidden" name="before_class_type_cd" value="${beforeClass.class_type_cd }">
</c:if>
<br>
<input type="hidden" name="class_cd" value="${current.class_cd}">
<input type="hidden" name="current_classday" value="${currentClass.classday}">
<input type="hidden" name="current_classhour_start_time" value="${currentClass.classhour_start_time}">
<input type="hidden" name="current_class_type_cd" value="${currentClass.class_type_cd}">
 
</div>
<div id="ajax_indicator" style="display:none">
   <p style="text-align:center; padding:16px 0 0 0; left:50%; top:50%; position:absolute;">
   	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif" />
   </p>
</div>
<!-- //휴/보강 취소 popup -->
</c:otherwise>
</c:choose>