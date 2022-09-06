<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가드너</title>
<script>
	function goCompletion(gd_no) {
		location.href='/plant/reserve/completion.do?gd_no='+gd_no+''

	}
	
	function goGdReservationView(gd_no) {
		location.href='/plant/reserve/gdReservationView.do?gd_no='+gd_no+''
	}
	
</script>
</head>
<body>
	<table class='default'>
		<tr><th style='font-size: 20pt; text-align: center;'>가드너 메뉴 </th></tr>
	</table>
	<div>
		<table class='default'>
			<tr>
				<th style='text-align: center;'>
					가드너 페이지
				</th>
			</tr>
			<tr>
				<td style='text-align: center;'>
					<button type='button' onclick='goGdReservationView(${loginGdInfo.gd_no})'>나의 예약 스케줄 관리</button>
				<td>
			</tr>
			<tr>
				<td style='text-align: center;'>
					<button type='button' onclick='goCompletion(${loginGdInfo.gd_no})'>케어진행 내용 및 리뷰 관리</button>
				</td>	
			</tr>
		</table>
	</div>
</body>
</html>