<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 관찰 일지 작성 첫 작성</title>

<!-- //제이쿼리 ui css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/plant/css/petplant/petdiary/petplantDiary.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
// 기르기 시작한 날짜를 넣어주면 몇 일째 기르고 있는지 알려주는 함수
$(function() {
   $("#datepicker").datepicker({
		dateFormat: 'yy-mm-dd', //날짜 표시 형식 설정
	    showOtherMonths: true, //이전 달과 다음 달 날짜를 표시
	    showMonthAfterYear:true, //연도 표시 후 달 표시
	    changeYear: true, //연도 선택 콤보박스
	    changeMonth: true, //월 선택 콤보박스
	    showOn: "both", //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
	    yearSuffix: "년", //연도 뒤에 나오는 텍스트 지정
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	    minDate: "-10y", // -1D:하루전, -1M:한달전, -1Y:일년전
	    buttonImage: "/plant/img/petplant/calendar.png", //버튼에 띄워줄 이미지 경로
	    buttonImageOnly: true, //디폴트 버튼 대신 이미지 띄워줌
	    buttonText: "선택", //버튼 마우스오버 시 보이는 텍스트
	    
	    // 날짜 선택 시 
	    onSelect: function(petdate,i){
			checkday(petdate);
		}
	}); 
   
	$("#selectBtn").click (function () {
		$.ajax ({
			url : 'userplant.do',
			method : 'POST',
			dataTpye : 'json',
			success : function(plant) {
				$("input[name='user_plantname']").val(plant.user_plantname);
				$("input[name='user_planttype']").val(plant.user_planttype);
				$("#user_plantfile_org").val(plant.user_plantfile_org);
				console.log("불러온다.. " + plant.user_plantname );
			}, error: function (xhr, desc, err) {
		           alert('에러가 발생');
		           console.log(err);
		           return; 
		    }
		})
	});
	
	// 중분류
	$("#selectType").change(function(){
		stype = $("#selectType").val();
		console.log("@@@@@"+ stype);
		plantTypelist2(stype);
	});
	
	// 소분류 -- 완전히 작물이름
	$("#selectType2").change(function () {
		console.log("@@@@@2");
		$("#user_planttype").val( $("#selectType2").val());
	})
	
});
 
function checkday(petdate) {
	var now = new Date(); 
	var petdate = new Date(petdate); 
	
	let todaypet = petdate.getTime() - now.getTime();
	
	var result = Math.floor(todaypet / (1000 * 60 * 60 * 24)) * -1; 
	var resultTxt = result+" 일째";
	
	console.log("찍은 날짜 + " + petdate);
	console.log("지금 - 입력한 날짜 :" + todaypet);
	console.log("result : " + result);
	$("#todaypet").text(resultTxt);
	$("input[name='diary_day']").val(result);
}

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
	location.href = "/plant/petplantDiary/listDiary.do";
}

</script>

<style type="text/css">
img {
	width: 25px;
	height: 25px;
}
body {
	padding-top: 70px;
}            
.tdclass {
	background-color:#89AD98; 
	color:#fff;
}


</style>

                 
</head>
<body class="is-preload"> 
<div>



<div id="diaryDiv">
	<div id="diaryDivmain">
		<article id="contact" class="panel">
			<header><h2>관찰일지 작성</h2></header>
			<div>
				<form id="frm" method="post" action="insertDiary.do"  enctype="multipart/form-data" >
					<div class="row">
						<div class="col-12" id="day">
							<span class="txt">기르기 시작한 날짜</span>
							<input type="text" id="datepicker" name="pet_regdate" title="저장하면 수정 불가">
							<input type="hidden" name="diary_day">
						</div>
						<div class="col-12">
							<span id="todaypet" class="txt"></span>  
							<input type="hidden" name="diary_day">
						</div>
						<div class="col-12" >
							<button type="button" class="btn" id="selectBtn">등록한 반려 식물 정보 불러오기</button>
						</div>
						<div class="col-12" >
							<span class="txt" style="margin-right: 5px;">이름</span><input class="inputtxt" type="text" name="user_plantname" >
						</div>
						<div class="col-12" >
							<span>품종을 선택해 주십시오</span>
							<br>
							<span id="plantType">
								<a id="FC" onclick="plantTypelist('FC')">식량 작물</a>
								<a id="IC" onclick="plantTypelist('IC')">특용 작물</a>
								<a id="VC" onclick="plantTypelist('VC')">채소</a>
								<a id="FT" onclick="plantTypelist('FT')">과수</a>
								<a id="FL" onclick="plantTypelist('FL')">화훼</a>
								<a id="FG" onclick="plantTypelist('FG')">녹비작물</a>
							</span>
							<br>
							<select id="selectType">
								<option>선택해주십시오</option>
							</select>
							<select id="selectType2">
								<option>선택해주십시오</option>
							</select>
						</div>
						<div class="col-12">
							<span class="txt" style="margin-right: 5px;">품종명</span><input class="inputtxt" type="text" name="user_planttype" id="user_planttype" readonly="readonly">
						</div>
						<div class="col-12">
							<span class="txt">제목</span>
							<input type="text" name="diary_title" class="inputtxt">
						</div>
						<div class="col-12">
							<span class="txt">날씨</span>
							<input type="radio" name="diary_weather" value="1"checked="checked"> 맑음
							<input type="radio" name="diary_weather" value="2" > 비
						  	<input type="radio" name="diary_weather" value="3" > 구름
						  	<input type="radio" name="diary_weather" value="4" > 눈	
						</div>
						
						<div class="col-12">
							<textarea name="diary_content" id="content" placeholder="내용" rows="6"></textarea>
						</div>
						<div class="col-12">
							<div class="write">
								 <input type="file" name="file" id="user_plantfile_org">
							</div>
						</div>
						<div class="col-12">
						</div>
					</div>
				</form>
				<button class="btn" onclick="save()">작성완료</button>
				<button class="btn" onclick="list()">목록으로</button>
			</div>
		</article>
	</div>
</div>



</div>


</body>
</html>