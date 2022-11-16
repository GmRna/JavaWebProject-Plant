<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file ="../../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 된 게시판 리스트</title>

<link rel="stylesheet" href="/plant/css/reset.css"/>
<link rel="stylesheet" href="/plant/css/common.css"/>
<link rel="stylesheet" href="/plant/css/style.css"/>
<link rel="stylesheet" href="/plant/css/contents.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
    
<style type="text/css">
img {
	width: 24px;
	height: 24px;
}
.bbs{
	width: 60%;
    margin: auto;
    height: auto;
}
body {
	padding-top: 70px;
}
th {
	text-align: center;
}
tr:nth-child(even) {
  background-color: #e7eae833;
}
tr:nth-child(odd) {
  background-color: #fff;
}

#trthList th {
  background-color: #89AD98;
  color: white;
}

.noBorder {
    border:none !important;
}

.btnDiv{
    margin-bottom: 10px;
    float: right;
}

#ulBtn li a{
	background: white;
	border-radius : 5px;
}
td {
border: 1px solid rgba(0,0,0,.1);
}

header.title {
    font-size: 1.65em;
    font-family: 'Open Sans Condensed', sans-serif;
    font-weight: 700;
    text-transform: uppercase;
    color: #6b7770;
    margin: 0 0 0.5em 0;
    line-height: 1.3;
}
</style>

</head>
<body>

<div class="bbs" >
	<header class="title">신고 된 게시물 리스트</header>
	
	<table class="list">
		<colgroup>
		    <col width="80px" />
			<col width="150px" />
			<col width="*" />
			<col width="100px" />
			<col width="100px" />
		</colgroup>
		<thead>
			<tr id="trthList">
				<th>번호</th>
				<th>신고된 게시판 번호</th>
				<th>게시판 이름</th>
				<th class="writer">작성자</th>
				<th class="date">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list}">
				<tr>
					<td class="first" colspan="8">등록된 글이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach items="${list}" var="list">
				<tr>
					<td class="writer">${list.report_no}</td>
					<td class="writer">
						${list.board_no}
					</td>
					<td>
						<span class="txt_l" style="text-align:left;" onclick="view(${list.board_no}, ${list.report_tablename })" >
							<c:if test="${list.report_tablename eq 'petplant'}">
								반려 식물 게시판
							</c:if>
							<c:if test="${list.report_tablename eq 'free'}">
								자유 게시판
							</c:if>
							<c:if test="${list.report_tablename eq 'quest'}">
								질문 게시판
							</c:if>
						</span>
					</td>
					<td class="writer">
						${list.user_nick}
					</td>
					<td class="date">
						<fmt:formatDate value="${list.report_regdate}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>