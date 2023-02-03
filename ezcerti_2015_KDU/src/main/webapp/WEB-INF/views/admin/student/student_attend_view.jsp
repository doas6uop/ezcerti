<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 강의별출결 popup -->
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" align="left" valign="top" class="grayfont">&nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/student_list_title_02.png"  alt="출결현황타이틀" /></td>
  </tr>
  <tr>
    <td align="center" valign="middle" class="studentlistbg"><table width="655" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="235" height="29" align="left">· 단과 : ${attendDetailHistoryList[0].student_coll_name }</td>
        <td width="226" align="left">· 학과 : ${attendDetailHistoryList[0].student_dept_name }</td>
        <td width="194" align="left">· 이름 : ${attendDetailHistoryList[0].student_name } (${attendDetailHistoryList[0].student_no })</td>
      </tr>
      <tr>
        <td height="29" colspan="3" align="left">· 과목명 : ${lecture.class_name }</td>
        </tr>
    </table></td>
  </tr>
</table>
<div class="photobox">
<c:forEach var="list" items="${attendDetailHistoryList }">
	<c:choose>
		<c:when test="${list.attend_sts_cd=='G023C001'&&list.class_type_cd=='G019C001' }">
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
			  <tr>
			    <td class="whitetop"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }</td>
			    </tr>
			  <tr>
			    <td class="whitebottom">${list.class_sts_name }<br />
			      ${list.attend_sts_name }</td>
			    </tr>
			</table>
		</c:when>
		<c:when test="${list.attend_sts_cd=='G023C001'&&(list.class_type_cd=='G019C002'||list.class_type_cd=='G019C003') }">
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
			  <tr>
			    <td class="graytop"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }</td>
			    </tr>
			<c:if test="${list.class_type_cd=='G019C002' }">
			  <tr>
			    <td class="graybottom">보강일<br>
					<c:if test="${empty list.before_classday}">없음</c:if>
				  	<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
			    </td>
			  </tr>
			</c:if>    
			<c:if test="${list.class_type_cd=='G019C003' }">
			  <tr>
			    <td class="graybottom">휴강일<br>
					<c:if test="${empty list.before_classday}">없음</c:if>
				  	<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
				  	<br/>${list.attend_sts_name }
			    </td>
			  </tr>
			</c:if>    
			</table>
		</c:when>
		<c:when test="${list.attend_sts_cd=='G023C002' }">
			<c:set var="attendTopStyle" value="bluetop" /> 
			<c:set var="attendBottomStyle" value="bluebottom" /> 
		
			<c:if test="${list.attend_sts_name eq '공결'}">
				<c:set var="attendTopStyle" value="puppletop" /> 
				<c:set var="attendBottomStyle" value="pupplebottom" /> 
			</c:if>
		
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
			  <tr>
			    <td class="${attendTopStyle}"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }</td>
			    </tr>
			  <tr>
			    <td class="${attendBottomStyle}">${list.class_sts_name }<br />
			      ${list.attend_sts_name }</td>
			    </tr>
			</table>
		</c:when>
		<c:when test="${list.attend_sts_cd=='G023C003' }">
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
			  <tr>
			    <td class="yellowtop"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }</td>
			    </tr>
			  <tr>
			    <td class="yellowbottom">${list.class_sts_name }<br />
			      ${list.attend_sts_name }</td>
			    </tr>
			</table>
		</c:when>
		<c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd!='G019C002' }">
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
			  <tr>
			    <td class="redtop"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
			      ${list.class_type_name }</td>
			    </tr>
			  <tr>
			    <td class="redbottom">${list.class_sts_name }<br />
			      ${list.attend_sts_name }</td>
			    </tr>
			</table>
		</c:when>
		<c:when test="${list.attend_sts_cd=='G023C004'&&list.class_type_cd=='G019C002' }">
			<table class="phototable" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:5px;">
				<tr>
					<td class="graytop"><fmt:formatDate value="${list.classday}" pattern="yyyy-MM-dd"/><br />
				   ${list.class_type_name }</td>
				</tr>
				<tr>
				  <td class="graybottom">보강일<br>
					<c:if test="${empty list.before_classday}">없음</c:if>
					<c:if test="${not empty list.before_classday}"><fmt:formatDate value="${list.before_classday }" pattern="yyyy-MM-dd"/></c:if>
				  </td>
				</tr>
			</table>
		</c:when>
	</c:choose>
</c:forEach>
</div>
<!-- //강의별출결 popup -->