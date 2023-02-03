<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach var="list" items="${classroomList}">
	<option value="${list.classroom_no}" <c:if test="${classroom_no eq list.classroom_no}">selected</c:if>>${list.classroom_name}</option>
</c:forEach>
