<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.img {
	width: 100px;
	height: 100px;
}
.searchbox{
	margin-top: 60px;
}
#booksave{
	width: 50px;
	height: 50px;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function search() {
	sword = $('input[name="sword"]').val();
	location.href = '/plant/plantbook/search.do?sword='+sword;
}

function booksave(plantbook_no) {
	<c:if test="${empty loginUserInfo}">
		alert("로그인 후 이용해주십시오.");
		location.href = "/plant/user/login.do";
	</c:if>
	
	$.ajax ({
		url : 'checkbook.do',
		data : { plantbook_no : plantbook_no},
		method : 'post',
		dataType: 'json',
		success : function (data) {
			if (data == 1){
				console.log(data+"담기사진");
				$(".booksave"+plantbook_no).attr('src','/plant/img/petplant/save1.png');
			} else {
				console.log(data+"해제사진");
				$(".booksave"+plantbook_no).attr('src','/plant/img/petplant/save2.png');
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
		
	})
}

$(function () {
	infiniteScroll({
	    container: "#container",
	    item: ".item",
	    next: ".next",
	    prev: ".prev"
	})
})


</script>
</head>
<body>

	<div class="searchbox">
		<input type="search" id="plantbookSearch" onkeyup="if(window.event.keyCode==13){search()}" name="sword" value="${param.sword}"> <input type="button" onclick="search()" value="검색">
	</div>

	<table border="1">
		<tr>
			<th></th>
			<th>이미지</th>
			<th>품종명</th>
			<th>주요 특성</th>
			<th>다운로드</th>
		</tr>
	<article id="container">
	
	<c:forEach items="${list.list}" var="list" >
		<div class="items">
		<tr>
			<c:if test="${list.count == 0}">
				<td><img id="booksave" class="booksave${list.plantbook_no}"src="/plant/img/petplant/save1.png" onclick="booksave(${list.plantbook_no})"></td>
			</c:if>
			<c:if test="${list.count == 1}">
				<td><img id="booksave" class="booksave${list.plantbook_no}"src="/plant/img/petplant/save2.png" onclick="booksave(${list.plantbook_no})"></td>
			</c:if>
			<td><img class="img" src="${list.imgFileLinkOriginal}"></td>
			<td>${list.cntntsSj}</td>
			<td>${list.mainChartrInfo}</td>
			<td><a href="${list.atchFileLink}">다운로드</a></td>
		</tr>
		</div>
	</c:forEach>
	</article>
	
	</table>
	
	<div class="pagenate clear">
		<ul class='paging'>
			<c:if test="${list.prev == true }">
				<li><a href="search.do?page=${list.startPage-1 }&sword=${param.sword}"><</a>
				</c:if>
				<c:forEach var="p" begin="${list.startPage }" end="${list.endPage }">
				<li><a href='search.do?page=${p }&sword=${param.sword}' <c:if test="${plantVO.page == p }">class='current'</c:if>>${p }</a></li>
				</c:forEach>
				<c:if test="${data.next == true }">
				<li><a href="search.do?page=${list.endPage+1 }&sword=${param.sword}">></a>
			</c:if>
		</ul> 
	</div>

<div class="paging">
	<a class="prev" href="search.do?page=${list.endPage+1 }&sword=${param.sword}"></a> 
    <a class="next" href="search.do?page=${list.endPage+1 }&sword=${param.sword}"></a> 
</div>



<!-- 스크롤 -->
<script src="https://cdn.jsdelivr.net/gh/marshallku/infinite-scroll/dist/infiniteScroll.js"></script>

                  
</body>
</html>

