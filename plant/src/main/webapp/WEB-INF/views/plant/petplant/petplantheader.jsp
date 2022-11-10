<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</script>
</head>
<body>

<nav>
	<div class="nav-container">
		<div class="nav-1">
			<img src="/plant/img/petplant/petplantMainicon.png" alt="logo_img">
			<div class="vl"></div>
	        <div class="goplantList" onclick="goplantList()"><h1> P L A N T </h1></div>
	    </div>
	    
	    <input id="searchInput" type="search" class="input-search"  onkeyup="if(window.event.keyCode==13){search()}" placeholder="검색">
	    
	    <div class="nav-2">
			<img src="/plant/img/common/house2.png" alt="홈" onclick="goHome()"><span id="txt" onclick="goHome()"></span>
			<!-- <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/explore.png" alt="탐색"> -->
			<c:if test="${!empty loginUserInfo}">
				<img src="/plant/img/common/editBlack.png" alt="글쓰기" onclick="goPetplantWrite()" > 
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