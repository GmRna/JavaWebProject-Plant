<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h2>담은 리스트</h2>
	<table border="1">
		<tr>
			<th></th>
			<th>이미지</th>
			<th>품종명</th>
			<th>주요 특성</th>
			<th>다운로드</th>
		</tr>
	<c:forEach items="${list.list}" var="list" >
		<tr>
			<td><img id="booksave" class="booksave${list.plantbook_no}"src="/plant/img/petplant/save1.png" onclick="booksave(${list.plantbook_no})"></td>
			<td><img class="img" src="${list.imgFileLinkOriginal}"></td>
			<td>${list.cntntsSj}</td>
			<td>${list.mainChartrInfo}</td>
			<td><a href="${list.atchFileLink}">다운로드</a></td>
		</tr>
	</c:forEach>
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
</body>
</html>