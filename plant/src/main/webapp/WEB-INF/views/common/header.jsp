<%@page import="com.plant.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 바</title>

<link rel="stylesheet" href="/plant/css/header/header.css"  type="text/css"/>

<!-- <link rel="stylesheet" href="../../../css/main/main.css?after"  type="text/css"/>
 -->
</head>

<body class="homepage is-preload">
<div id="page-wrapper">
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
					<a href="left-sidebar.html">My page</a>
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
				<li>
					<a href="/plant/user/login.do">로그인</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>




	<script src="/plant/js/header/jquery.min.js"></script>
	<script src="/plant/js/header/jquery.dropotron.min.js"></script>
	<script src="/plant/js/header/jquery.scrolly.min.js"></script>
	<script src="/plant/js/header/browser.min.js"></script>
	<script src="/plant/js/header/breakpoints.min.js"></script>
	<script src="/plant/js/header/util.js"></script>
	<script src="/plant/js/header/main.js"></script>
	
	
</body>
</html>