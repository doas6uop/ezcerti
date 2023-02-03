<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach var="list" items="${list}">
	<option value="${list.classhour_start_time }|${list.classhour_end_time}|${list.classhour_name}" <c:if test="${list.able_select_flag eq 'N'}">disabled="disabled"</c:if>>
		${list.classhour_start_time }~${list.classhour_end_time }
	</option>
</c:forEach>
