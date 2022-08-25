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
<link rel="stylesheet" href="/plant/css/contents.css"/>
    
</head>

<script type="text/javascript">
function view(pbreq_no) {
	location.href = "viewBookreq.do?pbreq_no="+pbreq_no;
}
</script>

<body>


<div class="bbs">
	<table class="list">
		<colgroup>
		    <col width="80px" />
			<col width="150px" />
			<col width="*" />
			<col width="100px" />
			<col width="100px" />
		</colgroup>
		<thead>
			<tr>
				<th>글번호</th>
				<th>요청상황</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
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
								<img class="icon" src="/plant/img/answer.png">
							</c:if>
							${reqlist.pbreq_title}
						</span>
					</td>
					<td class="writer">${reqlist.user_nick}</td>
					<td class="date"><fmt:formatDate value="${reqlist.pbreq_regdate}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


</body>
</html>