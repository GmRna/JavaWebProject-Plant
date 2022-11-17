<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, admin-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>관리자 로그인</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    
    <link rel="stylesheet" href="/plant/css/login/userlogin.css"/>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function loginCheck1() {
    		if ($("#admin__id").val() == '') {
    			alert('아이디를 입력해 주세요');
    			$("#admin_id").focus();
    			return false;
    		}
    		if ($("#admin__pwd").val() == '') {
    			alert('비밀번호를 입력해 주세요');
    			$("#admin__pwd").focus();
    			return false;
    		}
    	}
    </script>
</head>
<body>

<section id="headerId">
	<h1><a href="/plant/main/index.do">P L A N T</a></h1>
</section>


<div class="page">
	<div class="container">
		<div class="left">
			<img src="/plant/img/login/82d888piCxbh1.jpg">
		</div>
		<div class="right">
			<div class="form">
		        <form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck1();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
		        	<label for="Id" style="color: black;">관리자 아이디</label>
						<input type="text" name="admin_id" id="email" >
					<label for="password"  style="color: black;">비밀번호</label>
						<input type="password" name="admin_pwd" id="password">
					<input type="submit" id="submit" value="관리자 로그인">
		        </form>
			</div>
		</div>
	</div>
</div>
        
</body>
</html>