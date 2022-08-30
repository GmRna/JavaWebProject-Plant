<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>     
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
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
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
    
        <form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck1();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">일반회원 로그인</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="user_id" name="user_id" placeholder="아이디"></li>
                                    <li><input type="password" id="user_pwd" name="user_pwd" placeholder="비밀번호"></li>
                                    <li><label><input type="checkbox" name="reg1" id="reg1"/> 아이디저장</label></li>
                                </ul>
                                <div class="login_btn"><input type="submit" value="로그인" alt="로그인" /></div>
                            </fieldset>
                            <div class="btnSet clear">
                                <div style="padding:10px;"> 
                                    <a href="/plant/user/join.do" class="btn">일반 회원가입</a> 
                                    <a href="/plant/gd/join.do" class="btn">가드너 회원가입</a> 
                                </div>
                                <div style="padding:10px;"> 
                                    <a href="/plant/user/findEmail.do" class="btn">아이디 찾기</a>
                                    <a href="/plant/user/findPwd.do" class="btn">비밀번호 찾기</a>
                                </div>
                            </div>
                        </div>
                    </div>
        
                </div>
            </div>        
        </form>
        
</body>
</html>