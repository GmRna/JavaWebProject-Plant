<%@page import="com.plant.gd.GdVO"%>
<%@page import="com.plant.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function goHome() {
	location.href = "/plant/main/index.do";
}
function goMypage() {
	location.href = "/plant/user/myInfo.do";
}

function goLogin() {
	location.href = "/plant/user/login.do";
}

function goLogout() {
	location.href = "/plant/user/logout.do";
}

function goPetplantWrite() {
	location.href = "/plant/plant/write.do";
}
function goplantList() {
	location.href = "/plant/plant/list.do";
}

function search() {
	var sword = $("#searchInput").val();
	location.href = "/plant/plant/searchpet.do?sword="+sword;
}

function goMenu() {
	$( '.menunone' ).toggleClass( 'menudiv' );
}

function savepetList() {
	location.href = "/plant/plant/savepetList.do"; 
}

</script>
<style type="text/css">
#menu{
	moz-backface-visibility: hidden;
    -webkit-backface-visibility: hidden;
    -ms-backface-visibility: hidden;
    backface-visibility: hidden;
    -moz-transform: translateX(-275px);
    -webkit-transform: translateX(-275px);
    -ms-transform: translateX(-275px);
    transform: translateX(-275px);
    -moz-transition: -moz-transform 0.5s ease;
    -webkit-transition: -webkit-transform 0.5s ease;
    -ms-transition: -ms-transform 0.5s ease;
    transition: transform 0.5s ease;
    display: block;
    height: 100%;
    left: 0;
    overflow-y: auto;
    position: fixed;
    top: 0;
    width: 275px;
    z-index: 10002;
    border-right : 1px solid #0000002b;
    background-color: #fafafa;
    background-repeat: repeat, no-repeat;
    background-size: auto, 100% 100%;
    font-family: 'Open Sans Condensed', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
}
.menunone.menudiv #menu {
	-moz-transform: translateX(0);
    -webkit-transform: translateX(0);
    -ms-transform: translateX(0);
    transform: translateX(0);
}
ol, ul {
	list-style: none;
}

ul {
		list-style: disc;
		padding-left: 1em;
	}

		ul li {
			padding-left: 0.5em;
		}

	ol {
		list-style: decimal;
		padding-left: 1.25em;
	}

		ol li {
			padding-left: 0.25em;
		}
		
		
ul > li {
	display: inline-block;
	font-style: italic;
	margin: 0 0.35em 0 0.35em;
}
	
ul > li > a {
	border-radius: 5px;
	color: #5d5d5d;
	text-decoration: none;
	padding: 0.6em 1.2em 0.6em 1.2em;
	-moz-transition: background-color .25s ease-in-out;
	-webkit-transition: background-color .25s ease-in-out;
	-ms-transition: background-color .25s ease-in-out;
	transition: background-color .25s ease-in-out;
	outline: 0;
}
.amenu{
	display: block;
    color: #888;
    text-decoration: none;
    height: 44px;
    line-height: 44px;
    border-top: solid 1px rgba(255, 255, 255, 0.05);
    padding: 0 1em 0 1em;
    font-style: italic;
}

</style>
</head>
<body>

<nav>
	<div class="nav-container">
		<div class="nav-1">
			<div class="menunone">
				<div id="menu">
					<ul class="headerUl">
						<li><a class="amenu" >예약</a>
							<ul>
								<li><a class="amenu" href="/plant/reserve/explainReserve.do">예약 시스템 소개</a></li>
								<li><a class="amenu" href="/plant/reserve/searchGardener.do">가드너 검색</a></li>
								
								<c:if test="${!empty loginUserInfo}"> 
									<li><a class="amenu"  href="/plant/reserve/userReservationView.do?user_no=${loginUserInfo.user_no}">나의 예약 관리</a></li>
								</c:if>
								<c:if test="${!empty loginGdInfo}">
									<li><a class="menu"href="/plant/reserve/gdReservationView.do?gd_no=${loginGdInfo.gd_no}">나의 예약일정 관리</a></li>
									<li><a class="amenu"  href="/plant/reserve/completion.do?gd_no=${loginGdInfo.gd_no}">예약 완료 내역 입력 및 리뷰관리</a></li>
								</c:if> 
							</ul>
						</li>
						<li>
							<a class="amenu"  href="">식물 도감</a>
							<ul>
								<li><a class="amenu"  href="/plant/plantbook/main.do">식물 도감</a></li>
								<li><a class="amenu"  href="/plant/plantbookreq/listBookreq.do">식물 도감 요청 게시판</a></li>
							</ul>
						</li>
						<li>
							<a class="amenu" href="">커뮤니티</a>
							<ul>
								<li><a class="amenu"  href="/plant/free/index.do">자유 게시판</a></li>
								<li><a class="amenu"  href="/plant/questreply/index.do">질문 게시판</a></li>
							</ul>
						</li>
						<li>
							<a class="amenu" href="">공지/문의 사항</a>
							<ul>
								<li><a class="amenu" href="/plant/notice/index2.do">공지 사항  &nbsp;&nbsp;  </a></li>
								<li><a class="amenu" href="/plant/askreply/index.do">문의 사항</a></li>
							</ul>
						</li>
						<c:if test="${!empty loginUserInfo}"> 
						<li>
							<% 
							HttpSession sess = request.getSession();
							UserVO user = new UserVO();
							user = (UserVO)sess.getAttribute("loginUserInfo");
							%>
							<a class="amenu"  href="/plant/user/myInfo.do">My page</a>
								<ul>
									<li><a class="amenu"  href="/plant/user/myInfo.do">마이페이지</a></li>
									<li><a class="amenu" href="/plant/petplantDiary/listDiary.do">반려 식물 관찰일지</a></li>
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
							<a class="amenu" href="" class="mypage">Gardener page</a>
							<ul>
						        <li><a class="amenu" href="/plant/gd/myInfo.do">Gardener 정보 수정</a></li>
							</ul>
						</li>
						</c:if>
						<c:choose>
							<c:when test="${empty loginUserInfo and empty loginGdInfo}"> 
								<li>
									<a class="amenu" href="">로그인</a>
									<ul>
										<li><a class="amenu" href="/plant/user/login.do">일반 회원 로그인</a></li>
									   	<li><a class="amenu" href="/plant/gd/login.do">가드너 로그인</a></li>
									</ul>
								</li>
							</c:when>
							<c:otherwise> 
								<li>
									<c:if test="${!empty loginUserInfo and empty loginGdInfo}">
										<a class="amenu" href="/plant/user/logout.do">로그아웃</a>
									</c:if> 
									<c:if test="${!empty loginGdInfo and empty loginUserInfo}">
										<a class="amenu" href="/plant/gd/logout.do">로그아웃</a>
									</c:if>
								</li> 
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
				<img src="/plant/img/petplant/menu.png" alt="logo_img" onclick="goMenu();">
			<div class="vl"></div>
	        <div class="goplantList" onclick="goplantList()"><h1> P L A N T </h1></div>
	    </div>
	    
	    <input id="searchInput" type="search" class="input-search"  onkeyup="if(window.event.keyCode==13){search()}" placeholder="검색">
	    
	    <div class="nav-2">
			<c:if test="${!empty loginUserInfo}">
				<img src="/plant/img/common/editBlack.png" alt="글쓰기" onclick="goPetplantWrite()" > 
				<img src="/plant/img/petplant/save1.png" alt="담기목록" onclick="savepetList()"><span id="txt" onclick="goHome()"></span> 
				<img class="headerpic" src="<%=request.getContextPath()%>/upload/${loginUserInfo.user_plantfile_real}" alt="마이페이지" onclick="goMypage()">
			</c:if>
			<c:if test="${empty loginUserInfo }">
				<img src="/plant/img/login/login.png" alt="로그인이 필요합니다"><span onclick="goLogin()">&nbsp;&nbsp;로그인</span>
			</c:if>
			<c:if test="${!empty loginUserInfo }">
				<img src="/plant/img/login/logout.png" style="height: 25px;" onclick="goLogout()" alt="로그아웃">
			</c:if>
	    </div>
	</div>
</nav>

</body>
</html>