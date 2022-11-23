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
    <title>일반회원 로그인</title>
    <link rel="stylesheet" href="/plant/css/login/userlogin.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function loginCheck1() {
    		if ($("#user__id").val() == '') {
    			alert('아이디를 입력해 주세요');
    			$("#user_id").focus();
    			return false;
    		}
    		if ($("#user__pwd").val() == '') {
    			alert('비밀번호를 입력해 주세요');
    			$("#user__pwd").focus();
    			return false;
    		}
    	}
    </script>
</head>
<body>

<!-- 헤더 홈화면으로 가기 -->
<section id="header">
	<h1><a href="/plant/main/index.do">P L A N T</a></h1>
</section>
	
<!-- 로그인창 -->
<div class="page">
	<div class="container">
		<div class="left">
			<img src="/plant/img/login/sunflower.jpg">
		</div>
		<div class="right">
			<div class="form">
				<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck1();">
					<label for="Id">Id</label>
						<input type="email" name="user_id" id="email">
						
					<label for="password">Password</label>
						<input type="password" name="user_pwd" id="password">
						
					<input type="submit" id="submit" value="Login">
				</form>
				<label class="btnjoin"><a href="/plant/user/join.do"><span class="btnjoin">일반 회원가입</span></a></label>
				<label class="btnfind">
					<a href="/plant/user/findEmail.do" class="btnfind" >아이디 찾기</a>&nbsp; 
				    &nbsp;&nbsp;<a href="/plant/user/findPwd.do" class="btnfind" >비밀번호 찾기</a>
				</label>
			</div>
		</div> 
	</div>
</div>


</body>
</html>