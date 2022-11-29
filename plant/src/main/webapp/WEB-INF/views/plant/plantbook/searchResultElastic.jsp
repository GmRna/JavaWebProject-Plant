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
<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>


<style type="text/css">
.img {
	width: 100px;
	height: 100px;
}
.boxxx{
	margin-top: 20px;
}
#booksave{
	width: 50px;
	height: 50px;
}

#plantbookSearch{
	border: 2px solid #eee;
    border-radius: 50px;
    width: 20em;
    height: 3em;
    padding: 0px 0px 0px 15px;
    font : menu;
}

th {
	padding: 10px 10px;
    vertical-align: middle;
    background-color: #89AD98;
    color: #fff;
}
th.down {
	width: 55px;
}

#button {
    font-size: 12px;
}

#wrapper {
    width: 80em;
   }

#maplistBtn {
	padding-top: 15px;
    padding-bottom: 15px;
    float: right;
}

li.elastic:hover a {
  color: #fdfdfd;
  background-color: #89AD98;
}

li.elastic.active a {
  color: #fdfdfd;
  background-color: #89AD98;
}

a.current{ 
	color: #fdfdfd;
	background-color: #89AD98; 
}

.ulBtn{
    display: flex;
    justify-content: center;
}

li.elastic a {
  border-radius: 0.2rem;
  color: #7d7d7d;
  text-decoration: none;
  text-transform: uppercase;
  display: inline-block;
  text-align: center;
  padding: 2px 7px 5px 7px;
  border: solid 1px #d7d7d7;
}  
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function search() {
	var sword = $('input[name="sword"]').val();
	var stype = $('.stype').val();
	location.href = '/plant/plantbook/searchElastic.do?sword='+sword+'&stype='+stype+'&page=1';
}
</script>
</head>
<body>

<div class="sub" id="wrapper">
	<div class="size" id="gdView">	
	
	<div class="">
		<select class="stype">
			<option value="all">전체</option>
			<option value="cntntsSj">품종 명</option>
			<option value="mainChartrInfo">주요 특성</option>
		</select> 
		<input type="search" id="plantbookSearch" onkeyup="if(window.event.keyCode==13){search()}" name="sword" value="${param.sword}"> <input type="button" id="button" onclick="search()" value="검색">
	</div>
	
	<div class="boxxx">
	</div>
	
	<c:if test="${empty list.list}">
			<span>" ${param.sword}" 에 대한 검색 결과가 없습니다.</span>
	</c:if>
	
	<c:if test="${!empty list.list}">
	<span>" ${param.sword}" 에 대한 검색 결과 총 ${totalcount} 개</span>
	<table border="1">
		<tr>
			<th>이미지</th>
			<th>품종명</th>
			<th>주요 특성</th>
			<th class="down">다운로드</th>
		</tr>
		
		
			<c:forEach items="${list.list}" var="list" >
			<tr>
				<td><img class="img" src="${list.imgFileLinkOriginal}"></td>
				<td>${list.cntntsSj}</td>
				<td>${list.mainChartrInfo}</td>
				<td><a href="${list.atchFileLink}">다운로드</a></td>
			</tr>
			</c:forEach>
	</table>
	</c:if>
	
	<div class="boxxx">
	</div>
	<!-- 페이징 처리 -->
	<div class="pagenate clear">
		<div class="paging">
			<ul class="ulBtn" >
				<c:if test="${paging.prev == true }">
					<li class="elastic"><a href="searchElastic.do?page=${paging.page }&stype=${param.stype}&sword=${param.sword}"><</a></li>
				</c:if>
				<c:forEach var="p" begin="${paging.startPage }" end="${paging.endPage }">
					<li class="elastic"><a href='searchElastic.do?page=${p }&stype=${param.stype}&sword=${param.sword}' <c:if test="${plantBookVO.page == p }"> class='current' </c:if>>${p }</a></li>
				</c:forEach>
				<c:if test="${paging.next == true }"> 
					<li class="elastic"><a href="searchElastic.do?page=${paging.endPage+1 }&stype=${param.stype}&sword=${param.sword}">></a></li>
				</c:if>
			</ul> 
		</div>
	</div>
	

</div>
</div>

                  
</body>
</html>

