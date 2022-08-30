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
	    
	var date = new Date();
	
	var petdate = $("input[name='pet_regdate']").val();
	var petdate = new Date(petdate);
	
	let todaypet = petdate.getTime() - date.getTime();
	
	var result = Math.floor(todaypet / (1000 * 60 * 60 * 24)) * -1; 
		
	console.log("찍은 날짜 + " + petdate);
	console.log("now : " + date);
	console.log("지금 - 입력한 날짜 :" + todaypet);
	console.log("result : " + result);
	
	$("#todaypet").text(result);
	$("input[name='diary_day']").val(result);
	
});

function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

function save() {
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
	<form id="frm" method="post" action="insertTwoDiary.do"  enctype="multipart/form-data" >
		<input type="hidden" name="diary_no" value="${vo.diary_no }">
		<input type="hidden" name="diary_gno" value="${vo.diary_gno }">
		<span>기르기 시작한 날짜 <input type="text" id="datepicker" name="pet_regdate" value="${vo.pet_regdate}" readonly="readonly"></span> 
		<span id="todaypet"></span>    일째
		<input type="hidden" name="diary_day">
		
		<br><br>
		이름 <input type="text" name="user_plantname" value="${vo.user_plantname}" readonly="readonly"><br>
		품종 <input type="text" name="user_planttype" value="${vo.user_planttype}" readonly="readonly"><br>
		사진 <input type="file" name="file" id="user_plantfile_org"><br>
		
		<br><br><br>
		제목 <input type="text" name="diary_title"><br>
		날씨 <br>
				<input type="checkbox" name="diary_weather" value="1"checked="checked"> 맑음
				<input type="checkbox" name="diary_weather" value="2" > 비
			  	<input type="checkbox" name="diary_weather" value="3" > 구름
			  	<input type="checkbox" name="diary_weather" value="4" > 눈
		<br><br><br>
		관찰 내용 <textarea name="diary_content"></textarea>
	</form>
	<button onclick="save()">작성완료</button>
</div>


</body>
</html>