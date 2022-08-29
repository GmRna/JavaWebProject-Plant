<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
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
</head>
<body>
    
        <form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck1();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">가드너 로그인</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="gd_id" name="gd_id" placeholder="아이디"></li>
                                    <li><input type="password" id="gd_pwd" name="gd_pwd" placeholder="비밀번호"></li>
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
                                    <a href="findEmail.do" class="btn">아이디 찾기</a>
                                    <a href="findPwd.do" class="btn">비밀번호 찾기</a>
                                </div>
                            </div>
                        </div>
                    </div>
        
                </div>
            </div>        
        </form>
        
</body>
</html>