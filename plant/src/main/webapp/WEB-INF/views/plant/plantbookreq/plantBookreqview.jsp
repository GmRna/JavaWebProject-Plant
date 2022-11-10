<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 게시판 view</title>

<style type="text/css">
.pad{
	padding-top: 60px;
}
</style>

</head>
<script type="text/javascript">
function modifyReq(pbreq_no) {
	$("#frm").submit();
}

function listReq() {
	location.href = "/plant/plantbookreq/listBookreq.do";
}
function replyReq(pbreq_no) {
	location.href = "/plant/plantbookreq/adminreplyBookreq.do?pbreq_no="+pbreq_no;
}
</script>
<body >
<div id="pad">
	<form id="frm" method="post" action="modifyBookreq.do" enctype="multipart/form-data">
		<input type="hidden" name="pbreq_no" value="${reqlist.pbreq_no}">
		<input type="hidden" name="user_no" value="${reqlist.user_no}">
		
		<span>
		요청 상황 : 
			<c:if test="${reqlist.pbreq_status == 1}">
				요청중
			</c:if>
			<c:if test="${reqlist.pbreq_status == 2}">
				완료
			</c:if>
			<c:if test="${reqlist.pbreq_status == 3}">
				반려
			</c:if>
		</span> 
		<br>
		제목 : ${reqlist.pbreq_title} <br>
		품종 : ${reqlist.pbreq_type} <br>
		내용 : ${reqlist.pbreq_content} <br>
		사진 <img src="<%=request.getContextPath() %>/upload/${reqlist.filename_real }"> <br>
	</form>
		<button onclick="listReq()">목록으로 가기</button>
		<c:if test="${reqlist.user_no eq loginUserInfo.user_no}">
			<button onclick="modifyReq(${reqlist.pbreq_no})">수정</button>
			<button onclick="deleteReq(${reqlist.pbreq_no})">삭제</button>
		</c:if>		
		<c:if test="${!empty loginAdminInfo}">
			<button onclick="replyReq(${reqlist.pbreq_no})">답변</button>
			<button onclick="deleteReq(${reqlist.pbreq_no})">삭제</button>
		</c:if>		
</div>
</body>
</html>