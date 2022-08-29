<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>게시판목록</title>
</head>
<style>
      .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.3);
        z-index: 1000;

        /* 숨기기 */
        z-index: -1;
        opacity: 0;
      }

      .show {
        opacity: 1;
        z-index: 1000;
        transition: all 0.5s;
      }

      .window {
        position: relative;
        width: 100%;
        height: 100%;
      }

      .popup {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ffffff;
        box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

        /* 임시 지정 */
        width: 750px;
        height: 750px;

        /* 초기에 약간 아래에 배치 */
        transform: translate(-50%, -40%);
      }

      .show .popup {
        transform: translate(-50%, -50%);
        transition: all 0.5s;
      }
    </style>
<body>  
	<ul class="menu">
		<li><a href="http://localhost:8080/plant/" style="float:left;">로그인</a></li>
		<li><a href="/plant/user/logout.do" style="float:left;">로그아웃</a></li>
	</ul>
	<header>
		<h1>식물관리통합사이트</h1>
	</header>
	<nav>
		<ul class="category">
			<li><a href="/plant/notice/index2.do">공지사항</a></li>
			<li><a href="/plant/free/index.do">자유게시판</a></li>
			<li><a href="/plant/user/myInfo.do">My Page</a></li>
		</ul>
	</nav>
	<button id="show">Profile</button>
				    <div class="background">
				      <div class="window">
				        <div class="popup">
				          <button id="close">닫기</button><br>
				          <div class="sub">
            <div class="size">
                <h3 class="sub_title">Profile</h3>
                <div class="bbs">
                    <table class="list">
                        <caption>회원 상세정보</caption>
                        <!-- 최소 범위 : 닉네임, 프로필 사진(반려 식물) -->
                        <!-- 부분 공개 : 반려식물 이름 -->
                        <!-- 전체 공개 : 관심있는 식물 -->
                        <thead>
                            <tr>  
                                <th>닉네임</th>
                                <th>관심있는 식물</th>
                                
                                <th>반려식물 이름</th>
                                <th>반려식물 종류</th>
                            </tr>
                        </thead>
                        <tbody>         
                            <tr>
                                <td>
                                   ${vo.user_nick }
                                </td>
                                <td>
                                    ${vo.user_favrplant }
                                </td>
                               	<td>
                                    ${vo.user_plantname }
                                </td>
                                <td>
                                    ${vo.user_planttype }
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
            </div>
        </div> 
	<div class='btnSet'>
		
		<a class='btn btn-info m-btn--air' onclick="if( confirm('정말 탈퇴하시겠습니까?') ){ href='/plant/user/delete.do?user_no=${vo.user_no }'}">탈퇴</a>
	</div>
				        </div>
				      </div>
				    </div>
	<script>
      function show() {
        document.querySelector(".background").className = "background show";
      }

      function close() {
        document.querySelector(".background").className = "background";
      }

      document.querySelector("#show").addEventListener("click", show);
      document.querySelector("#close").addEventListener("click", close);
    </script>
        
</body>
</html>