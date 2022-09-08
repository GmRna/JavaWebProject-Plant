<%@page import="com.plant.gd.GdVO"%>
<%@page import="com.plant.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 바</title>

<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>

</head>

<body class="homepage is-preload">
<div id="page-wrapper">
	<nav id="nav">
		<ul>
			<li class="current"><a href="/plant/main/index.do">HOME</a></li>
	       
			<li><a>예약</a>
				<ul>
					<li><a href="/plant/reserve/explainReserve.do">예약 시스템 소개</a></li>
					<li><a href="/plant/reserve/searchGardener.do">가드너 검색</a></li>
					
					<c:if test="${!empty loginUserInfo}"> 
						<li><a href="/plant/reserve/userReservationView.do">나의 예약 관리</a></li>
					</c:if>
					<c:if test="${!empty loginGdInfo}">
						<li><a href="/plant/reserve/gdReservationView.do">나의 예약일정 관리</a></li>
						<li><a href="/plant/reserve/completion.do">예약 완료 내역 입력 및 리뷰관리</a></li>
					</c:if> 
				</ul>
			</li>
	      
			<li>
			   <a href="/plant/plant/list.do">반려식물</a>
			</li>
			
			<li>
				<a href="">식물 도감</a>
				<ul>
					<li><a href="/plant/plantbook/search.do">식물 도감</a></li>
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
				<a href="/plant/notice/index2.do">공지/문의 사항</a>
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
				<a href="/plant/user/myInfo.do">My page</a>
					<ul>
						<li><a href="/plant/user/myInfo.do">마이페이지</a></li>
						<li><a href="/plant/petplantDiary/listDiary.do">반려 식물 관찰일지</a></li>
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
					<li>
						<a href="">로그인</a>
						<ul>
							<li><a href="/plant/user/login.do">일반 회원 로그인</a></li>
						   	<li><a href="/plant/gd/login.do">가드너 로그인</a></li>
						</ul>
					</li>
				</c:when>
				<c:otherwise> 
					<li>
						<a href="/plant/gd/logout.do">로그아웃</a>
					</li>
				</c:otherwise>
			</c:choose>
	       
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