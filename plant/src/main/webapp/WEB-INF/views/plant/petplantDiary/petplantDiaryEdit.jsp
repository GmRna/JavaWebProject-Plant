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
<link href="/plant/css/petplant/petdiary/petplantDiary.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
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
<div id="diaryDiv">
	<div id="diaryDivmain">
		<article id="contact" class="panel">
			<header><h2>관찰일지 수정</h2></header>
			<div>
				<form id="frm" method="post" action="updateDiary.do"  enctype="multipart/form-data" >
					<div class="row">
						<div class="col-12" id="day">
							<input type="hidden" name="diary_no" value="${diary.diary_no}">
							<input type="hidden" name="diary_gno" value="${diary.diary_gno}">
							<span class="txt">기르기 시작한 날짜 <input type="text" id="datepicker" name="pet_regdate" value="${diary.pet_regdate}" readonly="readonly"></span>
						</div>
						<div class="col-12" > 
							<span id="todaypet" class="txt"> ${diary.diary_day}일째</span>
						</div>
						<div class="col-12" > 
							<span class="txt">이름</span> <input type="text" name="user_plantname" value="${diary.user_plantname}" readonly="readonly">
							<span class="txt">품종</span> <input type="text" name="user_planttype" value="${diary.user_planttype}" readonly="readonly">						
						</div>
						<div class="col-12"> 
							<span class="txt">사진</span> <input type="file" name="file" >
							<input type="hidden" name="user_plantfile_org" value="${diary.user_plantfile_org }">
							<input type="hidden" name="user_plantfile_real" value="${diary.user_plantfile_real }">
						</div>
						<div class="col-12"> 
							<span class="txt">제목</span><input type="text" name="diary_title" value="${diary.diary_title}">
						</div>
						<div class="col-12" > 
							<span class="txt">날씨</span>
							<input type="radio" name="diary_weather" value="1"checked="checked"> 맑음
							<input type="radio" name="diary_weather" value="2" > 비
						  	<input type="radio" name="diary_weather" value="3" > 구름
						  	<input type="radio" name="diary_weather" value="4" > 눈
						 </div>
						 <div class="col-12"> 
						 	<textarea name="diary_content" id="content">${diary.diary_content}</textarea>
						 </div>
					</div>
				</form>
				<button class="btn" onclick="update()">작성완료</button>
				<button class="btn" onclick="javascript:history.back();">목록으로</button>
			</div>
		</article>
	</div>
</div>

</body>
</html>