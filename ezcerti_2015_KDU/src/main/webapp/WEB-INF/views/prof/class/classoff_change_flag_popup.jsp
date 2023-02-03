<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div id="classoff_form">
		<table style="width: 100%;">
			<tbody>
				<tr>
					<td>
						<textarea name="sayu" rows="5" cols="25"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="chk_no" value="${chk_no}">
		<input type="hidden" name="classoff_flag" value="N">
	</div>
	
