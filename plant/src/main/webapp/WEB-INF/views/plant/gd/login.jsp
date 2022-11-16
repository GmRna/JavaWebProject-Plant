<%@page import="com.plant.gd.GdVO"%>
<%@page import="com.plant.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, gd-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    
    <title>가드너 로그인</title>
    
    <link rel="stylesheet" href="/plant/css/login/userlogin.css"/>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function loginCheck1() {
    		if ($("#gd__id").val() == '') {
    			alert('아이디를 입력해 주세요');
    			$("#gd_id").focus();
    			return false;
    		}
    		if ($("#gd__pwd").val() == '') {
    			alert('비밀번호를 입력해 주세요');
    			$("#gd__pwd").focus();
    			return false;
    		}
    	}
    	
    	$.ajax({
			type : 'post',
			url : '<c:url value="/gd/login" />',
			data : JSON.stringify(gd),
			contentType: 'application/json'
			dataType:"text",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				if(data === 'idFail'){
					alert('존재하지 않는 회원입니다!');
					//$('.loginForm').submit();
					console.log('db에 존재하지 않는 회원');
				} else if (data === 'pwFail'){
					alert('비밀번호가 틀렸습니다');
					console.log('db에 존재하는 회원, 비번틀림');
				} else if (data === 'wait'){
					alert('가입 승인 중 입니다. 잠시만 기다려 주세요');
				}else if (data === "refusal"){
					alert('가입이 거절 되었습니다.')
				}else if(data === "drop"){
					alert(gd_id+'님은 로그인 제제 상태입니다. 관리자에게 문의 해주세요.')
				}else {
					alert(gd_id+'님 반갑습니다.');
					console.log('로그인 성공');
					location.href='/plant/';
				}
			},
			error : function(status, error) {
				console.log('에러발생!!');
				console.log(gd);
				console.log(status, error);
			}
		});
    </script>
    <style type="text/css">
    #email, #password{
		background: #70707514;
	    border-radius: 2px;
	}
    </style>
</head>
<body>
        
<!-- 헤더 홈화면으로 가기 -->
<section id="headerId">
	<h1><a href="/plant/main/index.do">P L A N T</a></h1>
</section>
	
<!-- 로그인창 -->
<div class="page">
	<div class="container">
		<div class="left">
			<img src="/plant/img/login/gardener.jpg">
		</div>
		<div class="right">
			<div class="form">
				<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck1();">
					<label for="Id">Gardener Id</label>
						<input type="email" name="gd_id" id="email">
					<label for="password">Password</label>
						<input type="password" name="gd_pwd" id="password">
					<input type="submit" id="submit" value="Login">
				</form>

				<label class="btnjoin"><a href="/plant/gd/join.do"><span class="btnjoin">가드너 회원가입</span></a></label>
				<label class="btnfind">
					<a href="findEmail.do" class="btnfind" >아이디 찾기</a>&nbsp; 
				    &nbsp;&nbsp;<a href="findPwd.do" class="btnfind" >비밀번호 찾기</a>
				</label>
			</div>
		</div> 
	</div>
</div>



<!-- Scripts -->
	<script src="/plant/js/main/jquery.min.js"></script>
	<script src="/plant/js/main/jquery.dropotron.min.js"></script>
	<script src="/plant/js/main/browser.min.js"></script>
	<script src="/plant/js/main/breakpoints.min.js"></script>
	<script src="/plant/js/main/util.js"></script>
	<script src="/plant/js/main/main.js"></script>
	
	
</body>
</html>