<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	Date nowTime = new Date();
	SimpleDateFormat today = new SimpleDateFormat("yyyy년 MM월 dd일");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 관찰 일지 작성 첫 작성</title>

<script type="text/javascript">
// 기르기 시작한 날짜를 넣어주면 몇 일째 기르고 있는지 알려주는 함수

</script>


</head>
<body>

<div>
	<form id="frm" method="post" action=""  enctype="multipart/form-data" >
		기르기 시작한 날짜 <input type="date" name="date"> 
		오늘 날짜 <%= today.format(nowTime) %> 
		일째
		<button name="">가입시 등록한 반려식물 데이터 불러오기</button>
		이름 <input type="text" name="" >
		사진
		
		제목 <input type="text" name="title">
		관찰 내용 <textarea name="content"></textarea>
	</form>
</div>


</body>
</html>