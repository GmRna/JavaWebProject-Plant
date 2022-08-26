<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>회원가입 완료</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div id="join_finish">
	<div class="box">
		<strong>{{$vo.user_name}} 고객님,</strong><br> 회원가입을 진심으로 환영합니다.
	</div>
	<div class="btn"><span class="box_btn w150 large"><a href="http://localhost:8080/plant/user/login.do">로그인 화면으로</a></span></div>
	<div class="btn"><span class="box_btn w150 large"><a href="http://localhost:8080/plant/">홈 화면으로</a></span></div>
</div>
</body>
</html>