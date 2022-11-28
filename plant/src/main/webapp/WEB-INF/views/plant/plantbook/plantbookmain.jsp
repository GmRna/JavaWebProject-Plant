<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.searchbox{
	margin-top: 60px;
}

.banner {
	background-image: url("/plant/img/petplant/searcharea.jpg")
} 


</style>

<link rel="stylesheet" href="/plant/css/petplant/plantbook.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function search() {
	var sword = $('input[name="sword"]').val();
	var stype = $('.stype').val();
	location.href = '/plant/plantbook/searchElastic.do?sword='+sword+'&stype='+stype;
}

$(function () {
	$("#headerArea").css("height", "0"); 
})
</script>
</head>

<body>

	<section id="banner" >
		<header>
			<div class="search-mode">
			    <div id="searchDiv">
					<div id="searchHeader">
						<h2> 📚 식 물 도 감 📚 </h2>
						<select class="stype">
							<option value="all">전체</option>
							<option value="cntntsSj">품종명</option>
							<option value="mainChartrInfo">내용</option>
						</select> 
						<input type="search" id="plantbookSearch" onkeyup="if(window.event.keyCode==13){search()}" name="sword" placeholder="검색어를 입력해주세요"> 
					</div>
				</div>
		    </div>
		</header>
	</section>

</body>
</html>