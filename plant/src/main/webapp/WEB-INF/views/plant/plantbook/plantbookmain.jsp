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
</style>

<link rel="stylesheet" href="/plant/css/petplant/plantbook.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function search() {
	sword = $('input[name="sword"]').val();
	location.href = '/plant/plantbook/search.do?sword='+sword;
}

</script>
</head>

<body>
<div class="searchbox">
	<div id="searchDiv">
		<div id="searchHeader">
			<h2> 📚 식 물 도 감 📚 </h2>
			<input type="search" id="plantbookSearch" onkeyup="if(window.event.keyCode==13){search()}" name="sword" placeholder="검색어를 입력해주세요"> 
		</div>
	</div>
</div>
<div class="searchResult"></div>

</body>
</html>