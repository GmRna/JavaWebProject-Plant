<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="ko">
<head>
<title>공지사항 등록</title>
<%@ include file="/WEB-INF/views/plant/include/headHtml.jsp" %>
<script>

function goSave() {
	if ($("#notice_title").val() == "") {
		alert('제목을 입력해 주세요.');
		$("#notice_title").focus();
		return false;
	}
	if ($("#notice_content").val() == "") {
		alert('내용을 입력해 주세요.');
		$("#notice_content").focus();
		return false;
	} 
	$('#frm').submit();
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>공지사항</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form name="frm" id="frm" action="write.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="notice_title" id="title" class="wid100" value=""/>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="notice_content" id="notice_content"></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="file">
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
				<a href="javascript:;" class="btn" onclick="goSave();">저장</a>
				<a class="btn" href="/plant/notice/index.do">돌아가기</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
