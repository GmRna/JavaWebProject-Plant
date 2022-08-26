<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 게시판</title>
</head>
<script type="text/javascript">
function save() {
	$("#frm").submit();
}
</script>
<body>

<div>
	<form id="frm" method="post" action="insertBookreq.do" enctype="multipart/form-data">
		<c:if test="${!empty loginInfo}">
			<input type="hidden" name="pbreq_status" value="1">
		</c:if>
		<c:if test="${!empty loginAdminInfo}">
			<select name="pbreq_status">
				<option value="2">완료</option>
				<option value="3">반려</option>
			</select>		
		</c:if>
		<c:if test="${!empty loginAdminInfo}">
			제목 <input type="text" name="pbreq_title" value="답변완료" readonly="readonly">
		</c:if>
		제목 <input type="text" name="pbreq_title" value="요청합니다." readonly="readonly">
		품종 <input type="text" name="pbreq_type" >
		내용 <textarea name="pbreq_content"></textarea>
		사진 <input type="file" name="file">
		<button onclick="save()">작성완료</button>		
	</form>
</div>
</body>
</html>