<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 바</title>
<style type="text/css">
*{padding:0;margin:0}
li{list-style:none}
a{text-decoration:none;font-size:14px}
.menu {
  width: 800px;
  overflow: hidden;
  margin: 0px 0px 10px 0px;
}

.menu > li {
  width: auto; /*20*5=100%*/
  float: left;
  text-align: center;
  line-height: 40px;
  background-color: #5778ff;
}

.menu a {
  color: #fff;
}

.submenu > li {
  line-height: 50px;
  background-color: #94a9ff;
}

.submenu {
  height: 0; /*ul의 높이를 안보이게 처리*/
  overflow: hidden;
}
.menu > li:hover {
  background-color: #94a9ff;
  transition-duration: 0.5s;
}

.menu > li:hover .submenu {
  height: 250px; /*서브메뉴 li한개의 높이 50*5*/
  transition-duration: 1s;
</style>
</head>

<body>

 <ul class="menu">
      <li>
        <a href="">반려 식물 게시판</a>
        <ul class="submenu">
          <li><a href="/plant/plant/write.do">반려 식물 게시판 글쓰기</a></li>
          <li><a href="/plant/plant/list.do">반려 식물 게시판</a></li>
        </ul>
      </li>
      <li>
        <a href="">식물 도감 요청 리스트</a>
        <ul class="submenu">
          <li><a href="/plant/plantbookreq/writeBookreq.do">식물 도감 요청 리스트 글쓰기</a></li>
          <li><a href="/plant/plantbookreq/listBookreq.do">식물 도감 요청 리스트</a></li>
        </ul>
      </li>
      <li>
        <a href="/plant/user/login.do">로그인</a>
        <ul class="submenu">
          <li><a href="/plant/user/login.do">로그인</a></li> 
        </ul>
      </li>
      <li>
        <a href="#">MENU4</a>
        <ul class="submenu">
          <li><a href="#">submenu01</a></li>
        </ul>
      </li>
      <li>
        <a href="#">MENU5</a>
        <ul class="submenu">
          <li><a href="#">submenu01</a></li>
        </ul>
      </li>
    </ul>

</body>
</html>