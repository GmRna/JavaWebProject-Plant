<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<form id="frm" method="post" action="insertBookreq.do" >
		제목 <input type="text" name="" value="요청합니다." readonly="readonly">
		품종 이름 <input type="text" name="name">
		내용 <textarea name="content"></textarea>
		<button onclick="save()">작성완료</button>		
	</form>
</div>
</body>
</html>