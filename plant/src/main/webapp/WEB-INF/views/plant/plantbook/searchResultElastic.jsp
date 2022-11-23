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

#pagingUl {
	display: flex;
}

.pagingLi:hover a {
  color: #fdfdfd;
  background-color: #48663f;
}

.pagingLi.active a {
  color: #fdfdfd;
  background-color: #48663f;
}

.pagingLi a {
  border-radius: 0.2rem;
  color: #7d7d7d;
  text-decoration: none;
  text-transform: uppercase;
  display: inline-block;
  text-align: center;
  padding: 2px 7px 5px 7px;
  border: solid 1px #d7d7d7;
}
.paging{
    display: flex;
    justify-content: center; 
}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function search() {
	sword = $('input[name="sword"]').val();
	location.href = '/plant/plantbook/searchElastic.do?sword='+sword;
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
				$(".booksave"+plantbook_no).attr('src','/plant/img/petplant/bookmark1.png');
			} else {
				console.log(data+"해제사진");
				$(".booksave"+plantbook_no).attr('src','/plant/img/petplant/bookmark2.png');
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
		
	})
}

</script>
</head>
<body>

<div class="sub" id="wrapper">
	<div class="size" id="gdView">	
	
	<div class="">
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
	
	<div class="paging">
		<ul id="pagingUl">
			<c:if test="${list.prev == true }">
		   		<li class="pagingLi"><a href="search.do?page=${list.startPage -1}&stype=${param.stype}&sword=${param.sword}"><</a>
			</c:if>
			<c:forEach var="p" begin="${list.startPage }" end="${list.endPage }">
				<li class="pagingLi"><a href='search.do?page=${p }&sword=${param.sword}' <c:if test="${plantVO.page == p }">class='current'</c:if>>${p }</a></li>
			</c:forEach>
			<c:if test="${list.next == true }">
				<li class="pagingLi"><a href="search.do?page=${list.endPage+1 }&sword=${param.sword}">></a>
			</c:if>
		</ul> 
	</div>


</div>
</div>

                  
</body>
</html>
