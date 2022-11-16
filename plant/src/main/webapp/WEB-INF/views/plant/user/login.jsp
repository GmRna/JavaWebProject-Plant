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
	<nav id="nav">
		<ul>
			<li class="current"><a href="/plant/main/index.do">HOME</a></li>
			<li><a href="#">가드너 파견 서비스</a>
				<ul>
			        <li><a href="/plant/reserve/explainReserve.do">예약 시스템 소개</a></li>
					<li><a href="/plant/reserve/searchGardener.do">가드너 검색</a></li>
					<c:if test="${!empty loginUserInfo}"> 
			        	<li><a href="/plant/reserve/userReservationView.do?user_no=${loginUserInfo.user_no}">나의 예약 관리</a></li>
					</c:if>
					<c:if test="${!empty loginGdInfo}">
						<li><a href="/plant/reserve/gdReservationView.do?gd_no=${loginGdInfo.gd_no}">나의 예약일정 관리</a></li>
						<li><a href="/plant/reserve/completion.do?gd_no=${loginGdInfo.gd_no}">예약 완료 내역 입력 및 리뷰관리</a></li>
					</c:if> 
				</ul>
			</li>
			<li>
				<a href="/plant/plant/list.do">반려식물</a>
			</li>
			
			<li>
				<a href="">식물 도감</a>
				<ul>
			        <li><a href="/plant/plantbook/main.do">식물 도감</a></li>
			        <li><a href="/plant/plantbookreq/listBookreq.do">식물 도감 요청 리스트</a></li>
				</ul>
			</li>
			
			<li>
				<a href="">커뮤니티</a>
				<ul>
			    	<li><a href="/plant/free/index.do">자유 게시판</a></li>
			    	<li><a href="/plant/quest/index.do">질문 게시판</a></li>
				</ul>
			</li>
			
			<li>
				<a href="">공지/문의 사항</a>
				<ul>
					<li><a href="/plant/notice/index2.do">공지 사항</a></li>
               		<li><a href="/plant/askreply/index.do">문의 사항</a></li>
				</ul>
			</li>
			
			<c:if test="${!empty loginUserInfo}"> 
				<li>
					<% 
			     	HttpSession sess = request.getSession();
			     	UserVO user = new UserVO();
			     	user = (UserVO)sess.getAttribute("loginUserInfo");
			     	%>
					<a href="/plant/user/myInfo.do" class="mypage">My page</a>
					<ul>
				        <li><a href="/plant/user/myInfo.do">마이페이지</a></li>
				    	<li><a href="/plant/petplantDiary/listDiary.do">반려식물 관찰일지</a></li>
					</ul>
				</li>
			</c:if>
			
			<c:if test="${!empty loginGdInfo}"> 
				<li>
					<% 
			     	HttpSession sess = request.getSession();
			     	GdVO gd = new GdVO();
			     	gd = (GdVO)sess.getAttribute("loginGdInfo");
			     	%>
					<a href="" class="mypage">Gardener page</a>
					<ul>
				        <li><a href="/plant/gd/myInfo.do">Gardener 정보 수정</a></li>
					</ul>
				</li>
			</c:if>
			
			<c:choose>
				<c:when test="${empty loginUserInfo and empty loginGdInfo}"> 
					<li><a href="/plant/gd/login.do">가드너 로그인</a></li>
				</c:when>
				<c:otherwise> 
					<li>
						<a href="/plant/gd/logout.do">로그아웃</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
		</nav>
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

<!-- Scripts -->
	<script src="/plant/js/main/jquery.min.js"></script>
	<script src="/plant/js/main/jquery.dropotron.min.js"></script>
	<script src="/plant/js/main/browser.min.js"></script>
	<script src="/plant/js/main/breakpoints.min.js"></script>
	<script src="/plant/js/main/util.js"></script>
	<script src="/plant/js/main/main.js"></script>
	
	
</body>
</html>