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
    <title>일반회원 비밀번호 찾기</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function findPwd() {
    		if ($("#user_hp").val() == '') {
    			alert('전화번호를 입력해 주세요');
    			$("#hp").focus();
    			return false;
    		}
    		if ($("#user_email").val() == '') {
    			alert('복구이메일을 입력해 주세요');
    			$("#user_email").focus();
    			return false;
    		}
    		// ajax조회
    		$.ajax({
    			url : 'findPwd.do',
    			method : 'post',
    			data : {
    				user_hp : $("#user_hp").val(),
    				user_email : $("#user_email").val()
    			},
    			success : function(res) {
    				if (res.trim() == '') {
    					alert('해당 회원이 존재하지 않습니다.');
    				} else {
    					alert('임시 비밀번호가 복구이메일로 발송되었습니다.');
    					$("#user_hp, #user_email").val('');
    				}
    			}
    		});
    		return false;
    	}
    </script>
</head>
<body>
    
        <form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return findPwd();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">일반회원 비밀번호 찾기</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="user_hp" name="user_hp" placeholder="전화번호"></li>
                                    <li><input type="text" id="user_email" name="user_email" placeholder="이메일"></li>
                                </ul>
                                <div class="login_btn"><input type="submit" value="비밀번호 찾기" alt="비밀번호 찾기" /></div>
                            </fieldset>
                            <div class="btnSet clear">
                                <div>
                                    <a href="login.do" class="btn">로그인</a> 
                                    <a href="findEmail.do" class="btn">아이디 찾기</a>
                                </div>
                            </div>
                        </div>
                    </div>
        
                </div>
            </div>
        </form>
        
</body>
</html>