<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 리스트</title>

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

<script type="text/javascript">
function view(pbreq_no) {
	location.href = "viewBookreq.do?pbreq_no="+pbreq_no;
}

function reqWrite(){
	<c:if test="${empty loginUserInfo}">
		alert('로그인 후 이용해주세요');
		location.href = "/plant/user/login.do";
	</c:if>
	<c:if test="${!empty loginUserInfo}">
		location.href = "/plant/plantbookreq/writeBookreq.do";
	</c:if> 
}


</script>


<body >


<div class="bbs" >
	<header class="title">식물 도감 요청 게시판</header>
	<div class="btnDiv">
		<c:if test="${!empty loginAdminInfo}">
			<button class="btn" onclick="reqWrite()" > 답변 작성하기 </button> 
		</c:if>
		<button class="btn" onclick="reqWrite()" > 작성하기</button> 
	</div>
	
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
				<th>글번호</th>
				<th>요청상황</th>
				<th>제목</th>
				<th class="writer">작성자</th>
				<th class="date">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty reqlist.reqlist}">
				<tr>
					<td class="first" colspan="8">등록된 글이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach items="${reqlist.reqlist}" var="reqlist">
				<tr>
					<td class="writer">${reqlist.pbreq_no}</td>
					<td class="writer">
						<c:if test="${reqlist.pbreq_status == 1}">
							요청중
						</c:if>
						<c:if test="${reqlist.pbreq_status == 2}">
							완료
						</c:if>
						<c:if test="${reqlist.pbreq_status == 3}">
							반려
						</c:if>
					</td>
					<td>
						<span class="txt_l" style="text-align:left;" onclick="view(${reqlist.pbreq_no})" >
						
							<c:if test="${reqlist.pbreq_admin == 1 }">
								<span style="padding: 0px 80px 0px 0px;"></span><img class="icon" src="/plant/img/petplant/pQnA_answer.png">
							</c:if>
							${reqlist.pbreq_title}
						</span>
					</td>
					<td class="writer">
						<c:if test="${reqlist.user_no == 0}">
							관리자
						</c:if>
						<c:if test="${reqlist.user_no != 0}">
							${reqlist.user_nick}
						</c:if>
					</td>
					
					<td class="date">
						<fmt:formatDate value="${reqlist.pbreq_regdate}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 처리 -->
	<div class="pagenate clear">
		<div class="paging">
			<ul id="ulBtn">
				<c:if test="${list.prev == true }">
					<li><a href="listBookreq.do?page=${list.startPage }"><</a>
				</c:if>
				<c:forEach var="p" begin="${list.startPage }" end="${list.endPage }">
					<li><a href='listBookreq.do?page=${p }' <c:if test="${plantBookreqVO.page == p }">class='current'</c:if>>${p }</a></li>
				</c:forEach>
				<c:if test="${list.next == true }">
					<li><a href="listBookreq.do?page=${list.endPage+1 }">></a>
				</c:if>
			</ul> 
		</div>
	</div>
                		
</div>


</body>
</html>