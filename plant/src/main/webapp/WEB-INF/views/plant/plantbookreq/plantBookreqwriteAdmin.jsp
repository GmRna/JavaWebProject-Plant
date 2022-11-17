<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 게시판 관리자 작성</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="/plant/css/petplant/petdiary/petplantDiary.css" rel="stylesheet" type="text/css" />

<style>

header {
	margin: 0 0 2em 0;
}

#writeDiv{
	padding-top: 5%;
	width: 65em;
    margin: 0 auto;
}

#writeBox{
	height: 40%;
	margin: auto;
	padding: 3.5em 2.5em 2.5em 2.5em;
    width: 100%;
	background: white;
	box-shadow: 0px 1px 0px 0px rgb(0 0 0 / 25%);
}

#typeList{
	display: -webkit-box;
	list-style: none;
	margin: auto;
}

#typeList li a{
	color: b;
    margin-right: 10px;
    text-decoration: none;
}
#plantType{
	height: auto;
}

.selectList{
	height: auto;
}

a {
	color: b;
}

.divRow {
	display: flex;
    flex-wrap: wrap;
    box-sizing: border-box;
    align-items: stretch;
}

.divRow div{
    width: 100%;
}
.divRow *{
	margin: 7px 0 0 0;
}
form textarea {
	-webkit-appearance: none;
    border: 0;
    background: #eee;
    padding: 0.75em;
    width: 89%;
    height: 200px;
    
}
input[type=file]{
	margin-bottom: 1em;
}

#headerArea {
    height: 120px;
}

</style>

</head>
<script type="text/javascript">
function save() {
	$("#frm").submit();
}

function list() {
	location.href = "/plant/plantbookreq/listBookreq.do";
}

</script>
<body>


<div id="diaryDiv">
	<div id="diaryDivmain">
		<article id="contact" class="panel">
			<header><h2>식물 도감 요청 답변 작성</h2></header>
			<div>
			<form id="frm" method="post" action="insertAdminBookreq.do" enctype="multipart/form-data">
				<input type="hidden" name="pbreq_no" value="${reqlist.pbreq_no}">
				<input type="hidden" name="pbreq_gno" value="${reqlist.pbreq_no}">
				<input type="hidden" name="pbreq_ono" value="1">
				<header>
					<c:if test="${!empty loginAdminInfo}">
						제목 <input type="text" name="pbreq_title" value="답변완료" readonly="readonly">
					</c:if>
				</header>
				<div class="divRow">
					<select name="pbreq_status">
						<option value="2">완료</option>
						<option value="3">반려</option>
					</select>		
					<div>
						품종 <input type="text" name="pbreq_type" >
					</div>
					<div>
						<textarea name="pbreq_content"></textarea>
					</div>
					<div>
						<input type="file" name="file">
					</div>
				<button style="float: right;" class="btn" type="button" onclick="save()">답변작성완료</button>
				&nbsp;
				<button style="float: right;" class="btn" type="button" onclick="list()">목록으로</button>
				</div>
			</form>
		</div>
	</article>
</div>
		
</div>
</body>
</html>