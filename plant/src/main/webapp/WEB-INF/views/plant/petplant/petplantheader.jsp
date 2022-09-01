<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/plant/css/instagram.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function goHome() {
	location.href = "/plant/main/index.do";
}

function goMypage() {
	location.href = "/plant/user/myInfo.do";
}
</script>
</head>
<body>

<nav>
	<div class="nav-container">
		<div class="nav-1">
	    	<img src="/plant/img/petplant/petplantMainicon.png" alt="logo_img">
			<div class="vl"></div>
	        <h1> P L A N T </h1>
	    </div>
	    
	    <input id="searchInput" type="search" class="input-search" placeholder="검색">
	    
	    <div class="nav-2">
	      <img src="/plant/img/common/house2.png" alt="홈" onclick="goHome()"><span id="txt" onclick="goHome()">&nbsp;&nbsp;HOME</span>
	      <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/explore.png" alt="탐색">
	      <img src="/plant/img/common/user.png" alt="마이페이지" onclick="goMypage()"><span onclick="goMypage()">&nbsp;&nbsp;My page</span>
	    </div>
	</div>
</nav>

</body>
</html>