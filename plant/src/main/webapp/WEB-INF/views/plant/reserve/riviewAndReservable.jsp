<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<c:forEach var="r" items="${review}" begin="0" end="2">
			<p>${r.review}${r.star}</p>
		</c:forEach>
		</td>
	</tr>
	<tr>
		<td>예약 가능 시간</td>
	</tr>
	<tr>
		<c:forEach var="ra" items="${reservable}">
			<td>
				<p>${ra.reservable_date} ${ra.reservable_hour} ${ra.reservable_major}</p>
			</td>
		</c:forEach>
	</tr>
</body>
</html>