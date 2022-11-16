<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 게시판</title>

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

$(function () {
	$(".selectList").css('display', 'none');
	
	$("#typeList li").on('click', function () {
		$(".selectList").css('display', 'block');
	})
	
	// 중분류
	$("#selectType").change(function(){
		stype = $("#selectType").val();
		plantTypelist2(stype);
	});
	
	// 소분류 -- 완전히 작물이름
	$("#selectType2").change(function () {
		$("#user_planttype").val( $("#selectType2").val());
	})
})




function save() {
	$("#frm").submit();
}

function plantTypelist(stype) {
	$.ajax ({
		url : '/plant/plantType/plantStypeF.do',   
		method : 'GET', 
		dataTpye : 'json',
		data : { stype : stype },
		success : function(list) {
			$("#selectType").html(list);
		}, error: function (xhr, desc, err) {
			alert('에러가 발생');
			console.log(err);
			return; 
	    }
	})
}


function plantTypelist2(stype) {
	console.log("@@@@@2"+stype);
	$.ajax ({
		url : '/plant/plantType/plantStypeF2.do',   
		method : 'GET', 
		dataTpye : 'json',
		data : { stype : stype },
		success : function(list) {
			$("#selectType2").html(list);
		}, error: function (xhr, desc, err) {
			alert('에러가 발생');
			console.log(err);
			return; 
	    }
	})
}

function list() {
	location.href = "/plant/plantbookreq/listBookreq.do";
	
}

</script>
<body>

<div id="diaryDiv">
	<div id="diaryDivmain">
		<article id="contact" class="panel">
			<header><h2>식물 도감 요청 작성</h2></header>
			<div>
				<form id="frm" method="post" action="insertBookreq.do" enctype="multipart/form-data">
					<header>
						<c:if test="${!empty loginUserInfo}">
							<input type="hidden" name="pbreq_status" value="1">
						</c:if>
						<input type="text" name="pbreq_title" value="요청합니다." readonly="readonly">
					</header>
					<div class="divRow">
						<div id="plantType">
							<span>품종</span>
							<ul id="typeList">
								<li><a id="FC" onclick="plantTypelist('FC')">식량 작물</a></li>
								<li><a id="IC" onclick="plantTypelist('IC')">특용 작물</a></li>
								<li><a id="VC" onclick="plantTypelist('VC')">채소</a></li>
								<li><a id="FT" onclick="plantTypelist('FT')">과수</a></li>
								<li><a id="FL" onclick="plantTypelist('FL')">화훼</a></li>
								<li><a id="FG" onclick="plantTypelist('FG')">녹비작물</a></li>
							</ul>
							<div class="selectList">
								<select id="selectType">
									<option>선택해주십시오</option>
								</select>
								
								<select id="selectType2">
									<option>선택해주십시오</option>
								</select>
							</div>
						</div>
						<div>
							<textarea name="pbreq_content"></textarea>
						</div>
						<div>
							<input type="file" name="file">
						</div>
					<button style="float: right;" class="btn" type="button" onclick="save()">작성완료</button>
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