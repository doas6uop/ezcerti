<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" align="left" valign="top" class="grayfont"> &nbsp;<img src="${pageContext.request.contextPath}/resources/images/admin/professor_list_title.png" width="79" height="17" alt="상세정보타이틀" /></td>
    <td align="right" class="grayfont">[총 ${pb.allCnt }건] &nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><table width="690" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="33" align="center" valign="middle" class="tdgray">NO</td>
        <td width="135" align="center" valign="middle" class="tdgray">강의일시</td>
        <td width="118" align="center" valign="middle" class="tdgray">학과</td>
        <td width="132" align="center" valign="middle" class="tdgray">과목</td>
        <td width="110" align="center" valign="middle" class="tdgray">교수</td>
        <td width="56" align="center" valign="middle" class="tdgray">수강인원</td>
        <td width="106" align="center" valign="middle" class="tdgraynone">상태</td>
      </tr>
      <c:forEach var="b" items="${pb.list }">
      <tr class="tr_over">
        <td class="tdwhite">${b.row_no }</td>
        <td class="tdwhite">${b.classday } (${b.classday_name }) ${b.classhour_start_time }</td>
        <td class="tdwhite">${b.prof_dept_name }</td>
        <td class="tdwhite">${b.class_name }</td>
        <td class="tdwhite">${b.prof_name }</td>
        <td class="tdwhite">${b.attendee_cnt }</td>
        <td class="tdwhitenone">${b.class_type_name }(${b.class_sts_name })</td>
      </tr>
      </c:forEach>
    </table></td>
  </tr>
   <tr>
    <td height="38" colspan="2" align="right" valign="bottom" class="grayfont"><a href="#"><img src="${pageContext.request.contextPath}/resources/images/admin/list_button.png" width="61" height="27" alt="목록버튼" /></a>&nbsp;</td>
  </tr>
  <tr>
    <td height="45" colspan="2" align="center" valign="top" class="paginggrayfont"><my:pageGroup/></td>
  </tr>
  <tr>
    <td colspan="2" align="center" valign="middle" class="searchbg"><table width="390" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><label for="list"></label>
          <select id="item" name="item" size="1" class="searchlistbox" id="list">
	            <option value="name"
				<c:if test="${param.item=='name'}">
					selected
				</c:if>
				>강의명</option>
				<option value="code"
				<c:if test="${param.item=='code'}">
					selected
				</c:if>
				>학과명</option>
				<option value="code"
				<c:if test="${param.item=='code'}">
					selected
				</c:if>
				>교수명</option>
         	</select></td>
        <td><label for="text"></label>
          <input type="text" id="value" name="value" value="${param.value}" class="searchtextbox"  /></td>
        <td align="right"><button><img src="${pageContext.request.contextPath}/resources/images/admin/search_button.png" width="69" height="26" alt="검색버튼" /></button></td>
      </tr>
    </table></td>
  </tr>
</table>
