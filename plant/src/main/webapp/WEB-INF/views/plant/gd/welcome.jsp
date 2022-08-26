<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원가입 완료</title>
    <%@ include file="/WEB-INF/views/plant/include/headHtml.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div id="join_finish">
	<div class="box">
		<strong>{{$vo.gd_name}} 고객님,</strong><br> 회원가입을 진심으로 환영합니다.
		승인심사 후 홈페이지 예약 관리 시스템 사용가능합니다.
	</div>
	<div class="btn"><span class="box_btn w150 large"><a href="http://localhost:8080/plant/gd/login.do">로그인 화면으로</a></span></div>
	<div class="btn"><span class="box_btn w150 large"><a href="http://localhost:8080/plant/">홈 화면으로</a></span></div>
</div>
</body>
</html>