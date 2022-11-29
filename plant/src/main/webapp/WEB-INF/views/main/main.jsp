<%@page import="com.plant.gd.GdVO"%>
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
<script type="text/javascript">
function searchElastic() {
	var sword = $('input[name="headersword"]').val();
	var stype = "all";
	location.href = '/plant/plantbook/searchElastic.do?sword='+sword+'&stype='+stype+'&page=1';
}

</script>
</head>
<body class="homepage is-preload">
<div id="page-wrapper">
<!-- Header -->
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
			        <li><a href="/plant/plantbookreq/listBookreq.do">식물 도감 요청 게시판</a></li>
				</ul>
			</li>
			
			<li>
				<a href="">커뮤니티</a>
				<ul>
			    	<li><a href="/plant/free/index.do">자유 게시판</a></li>
			    	<li><a href="/plant/questreply/index.do">질문 게시판</a></li>
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
		
	</section>
	
	
	<!-- Banner -->
	<section id="banner">
		<header>
			<div class="search-mode">
			    <input type="text" name="headersword" class="searchtext" placeholder="   식물도감 검색" onkeyup="if(window.event.keyCode==13){searchElastic()}" >
			    <div class="searicon">
					<img class="searchimg"src="/plant/img/petplant/search.png" onclick="searchElastic()">
				</div>
		    </div>
		</header>
	</section>
	
	<!-- Footer -->
	<section id="footer">
		<div class="container">
			<div class="row">
				<div class="col-4 col-12-medium">
					<section>
						<ul class="contact">
							<li>
								<h3>css 참고</h3>
								<p><a href="https://velog.io/@eunjin/Javascript-Project%EC%9D%B8%EC%8A%A4%ED%83%80%EA%B7%B8%EB%9E%A8-%ED%81%B4%EB%A1%A0%EC%BD%94%EB%94%A9">반려식물 게시판-인스타</a></p>
								<p><a href="https://html5up.net/dopetrope">메인페이지 및 전반적인 페이지</a></p>
								<p><a href="https://html5up.net/txt">반려식물 관찰일지 페이지</a></p>
							</li>
						</ul>
					</section>
				</div>
				<div class="col-4 col-12-medium">
					<section>
						<ul class="contact">
							<li>
								<h3>조원</h3>
								<p>김우성 류휘문 박현정 송태호</p>
							</li>
						</ul>
					</section>
				</div>
				<div class="col-12">
					<!-- Copyright -->
					<div id="copyright">
						<ul class="links">
							<li>
								<p><a href="/plant/admin/login.do">관리자 로그인</a></p>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
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