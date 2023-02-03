<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" pageEncoding="UTF-8">
<title>오류</title>
</head>
<body>
<div id="page">
	<h3>오류</h3>
	<table>
		<tr>
			<th width="60">원인</th>
			<td>${exception.message }</td>
		</tr>
	</table><br />
	<div align="center">
		<input type="button" value="홈" onclick="location.href='/'" />
	</div>
</div>
</body>
</html>