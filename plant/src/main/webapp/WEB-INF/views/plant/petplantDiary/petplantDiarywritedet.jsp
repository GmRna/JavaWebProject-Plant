<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 관찰 일지 다음 작성</title>

<!-- //제이쿼리 ui css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/plant/css/petplant/petdiary/petplantDiary.css" rel="stylesheet" type="text/css" />

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

function list() {
	
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
<body  class="is-preload"> 
<div id="diaryDiv">
	<div id="diaryDivmain">
		<article id="contact" class="panel">
			<header><h2>관찰일지 작성</h2></header>
			<div>
				<form id="frm" method="post" action="insertTwoDiary.do"  enctype="multipart/form-data" >
					<div class="row">
						<div class="col-12" id="day">
							<input type="hidden" name="diary_no" value="${vo.diary_no }">
							<input type="hidden" name="diary_gno" value="${vo.diary_gno }">
							<span class="txt">기르기 시작한 날짜 <input type="text" id="datepicker" name="pet_regdate" value="${vo.pet_regdate}" readonly="readonly"></span>
						</div>
						<div class="col-12" id="day">
							<span id="todaypet" class="txt"></span>  <span class="txt">  일째</span>
							<input type="hidden" name="diary_day">
						</div>	
						<div class="col-12" >
							<span class="txt" >이름</span> <input type="text" name="user_plantname" value="${vo.user_plantname}" readonly="readonly"><br>
							<span class="txt">품종</span> <input type="text" name="user_planttype" value="${vo.user_planttype}" readonly="readonly"><br>
						</div>
						<div class="col-12" >
							<span class="txt" >제목</span> <input type="text" name="diary_title">
						</div>
						<div class="col-12" >
							<span class="txt" >날씨</span>
							<input type="radio" name="diary_weather" value="1"checked="checked"> 맑음
								<input type="radio" name="diary_weather" value="2" > 비
							  	<input type="radio" name="diary_weather" value="3" > 구름
							  	<input type="radio" name="diary_weather" value="4" > 눈
						</div>
						<div class="col-12">
							<textarea name="diary_content" id="content" placeholder="내용" rows="6"></textarea>
						</div>
						<div class="col-12" >
							<span class="txt" >사진</span> <input type="file" name="file" id="user_plantfile_org"><br>
						</div>
						<div class="col-12">
						</div>
					</div>
				</form>
					<button class="btn" onclick="save()">작성완료</button>
					<button class="btn" onclick="javascript:history.back();">목록으로</button>
			</div>
		</article>
	</div>
</div>


</body>
</html>