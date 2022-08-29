<%@page import="com.plant.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<link rel="stylesheet" href="/plant/css/main/main.css"  type="text/css"/>

</head>
<body class="homepage is-preload">
<div id="page-wrapper">
<!-- Header -->
	<section id="header">
	
		<h1><a href="plant/main/index.do">P L A N T</a></h1>
		
		<nav id="nav">
		<ul>
			<li class="current"><a href="/plant/main/index.do">HOME</a></li>
			
			<li><a href="right-sidebar.html">예약하기</a></li>
			
			<li>
				<a href="#">반려식물</a>
				<ul>
					<li><a href="/plant/plant/write.do">반려 식물 게시판 글쓰기</a></li>
			        <li><a href="/plant/plant/list.do">반려 식물 게시판</a></li>
			        <li><a href="/plant/plantbookreq/writeBookreq.do">식물 도감 요청 리스트 글쓰기</a></li>
			        <li><a href="/plant/plantbookreq/listBookreq.do">식물 도감 요청 리스트</a></li>
			    	<li><a href="/plant/petplantDiary/writeDiary.do">관찰일지 쓰기</a></li>
				</ul>
			</li>
			
			<li>
				<a href="left-sidebar.html">게시판</a>
				<ul>
			    	<li><a href="/plant/petplantDiary/writeDiary.do">자유 게시판</a></li>
			    	<li><a href="/plant/petplantDiary/writeDiary.do">질문 게시판</a></li>
				</ul>
			</li>
			
			<li>
				<a href="left-sidebar.html">공지/문의 사항</a>
				<ul>
					<li><a href="/plant/plant/write.do">공지 사항</a></li>
			        <li><a href="/plant/plant/list.do">문의 사항</a></li>
				</ul>
			</li>
			
			
			<c:if test="${!empty loginUserInfo}"> 
				<li>
					<% 
			     	HttpSession sess = request.getSession();
			     	UserVO user = new UserVO();
			     	user = (UserVO)sess.getAttribute("loginUserInfo");
			     	%>
					<a href="left-sidebar.html" class="mypage">My page</a>
					<ul>
				        <li><a href="/plant/plantbookreq/writeBookreq.do">마이페이지</a></li>
				    	<li><a href="/plant/petplantDiary/writeDiary.do">관찰일지 쓰기</a></li>
					</ul>
				
				</li>
				<li>
					<a href="left-sidebar.html">로그아웃</a>
				</li>			
			</c:if>
			
			<c:if test="${empty loginUserInfo}"> 
				<a href="/plant/user/login.do">로그인</a>
			</c:if>
		</ul>
		</nav>
		
	</section>
	
	
	<!-- Banner -->
	<section id="banner">
		<header>
			<h2>Howdy. This is Dopetrope.</h2>
			<p>A responsive template by HTML5 UP</p>
		</header>
	</section>
	
	
	
	
	
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