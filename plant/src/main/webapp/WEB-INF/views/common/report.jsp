<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/plant/css/instagram.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

	 
</script>
</head>
<body>
<div id="report_popup_layer" >
	<div class="reportDiv" id="reportDiv" >
		<form method="post" action="report.do">
			<p>신고 항목 선택</p>
				<div class="reportlist">
					<label><input type="radio" name="report_check" value="1"> 성적인 글 </label> <br>
					<label><input type="radio" name="report_check" value="2"> 잘못된 정보 </label> <br>
					<label><input type="radio" name="report_check" value="3"> 스팸 또는 광고 글 </label> <br>
					<label><input type="radio" name="report_check" value="4"> 욕설 및 비방 글 </label> <br>
					<label><input type="radio" name="report_check" value="5"> 폭력적 또는 혐오스러운 글</label> <br>
					<label><input type="radio" name="report_check" value="6"> 기타 작성
					<input type="text" name="report_etc">
					</label>
				</div>
				<input type="hidden" name="report_tablename" value="${reportList.report_tablename}">
				<input type="hidden" name="user_no" value="${reportList.user_no}">
				<input type="hidden" name="board_no" value="${reportList.board_no}">
				
			<p><input type="submit" value="신고"> <input type="reset" value="Reset">  <span id="close" title="닫기"> 닫기 </span> </p>
		</form>
	</div>
</div>


<script type="text/javascript">
$(function () {
	
	$(document).mouseup(function (e){
		var LayerPopup = $("#report_popup_layer"); 
		if(LayerPopup.has(e.target).length === 0){
			document.getElementById("report_popup_layer").style.display = "none";
		}
	});
	
	$("#close").click(function() {
		document.getElementById("report_popup_layer").style.display = "none";
	})
	
});
</script>

</body>
</html>