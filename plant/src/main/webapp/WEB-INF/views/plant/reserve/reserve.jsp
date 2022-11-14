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
<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>

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
<div class="sub" id="wrapper">
	<h2>가드너 메뉴 바로가기</h2>
	<div class="size" id="gdView">
		<button type='button' onclick='goGdReservationView(${loginGdInfo.gd_no})'>나의 예약 스케줄 관리</button>
		<button type='button' onclick='goCompletion(${loginGdInfo.gd_no})'>케어진행 내용 및 리뷰 관리</button>
	</div>
</div>
</body>
</html>