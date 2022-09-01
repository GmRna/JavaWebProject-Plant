<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 관찰 일지 작성 첫 작성</title>

<!-- //제이쿼리 ui css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript">
// 기르기 시작한 날짜를 넣어주면 몇 일째 기르고 있는지 알려주는 함수
$(function() {
	
});

function update() {
	$("#frm").submit();
}
</script>

<style type="text/css">
img {
	width: 25px;
	height: 25px;
}
body {
	padding-top: 70px;
}

</style>


</head>
<body>

<div>
	<form id="frm" method="post" action="updateDiary.do"  enctype="multipart/form-data" >
		<input type="hidden" name="diary_no" value="${diary.diary_no}">
		
		<span>기르기 시작한 날짜 <input type="text" id="datepicker" name="pet_regdate" value="${diary.pet_regdate}" readonly="readonly"></span> 
		<span id="todaypet"></span> ${diary.diary_day}일째
		
		<br><br>
		이름 <input type="text" name="user_plantname" value="${diary.user_plantname}" readonly="readonly"><br>
		품종 <input type="text" name="user_planttype" value="${diary.user_planttype}" readonly="readonly"><br>
		사진 <input type="file" name="file" id="user_plantfile_org" value="${diary.user_plantfile_org }"><br>
		파일이름 : ${diary.user_plantfile_org}<br>
		
		<br><br><br>
		제목 <input type="text" name="diary_title" value="${diary.diary_title}">
		날씨 <br>
				<input type="checkbox" name="diary_weather" value="1"checked="checked"> 맑음
				<input type="checkbox" name="diary_weather" value="2" > 비
			  	<input type="checkbox" name="diary_weather" value="3" > 구름
			  	<input type="checkbox" name="diary_weather" value="4" > 눈
		<br><br><br>
		관찰 내용 <textarea name="diary_content">${diary.diary_content}</textarea>
	</form>
	<button onclick="update()">작성완료</button>
</div>


</body>
</html>