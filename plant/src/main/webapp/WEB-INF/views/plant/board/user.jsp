<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <title>게시판목록</title>
</head>
<body>  
	<ul class="menu">
		<li><a href="http://localhost:8080/plant/" style="float:left;">로그인</a></li>
		<li><a href="/plant/user/view.do">마이페이지</a>
	</ul>
	<header>
		<h1>식물관리통합사이트</h1>
	</header>
	<nav>
		<ul class="category">
			<li><a href="/plant/notice/index2.do">공지사항</a></li>
			<li><a href="/plant/free/index.do">자유게시판</a></li>
		</ul>
	</nav>
        
</body>
</html>