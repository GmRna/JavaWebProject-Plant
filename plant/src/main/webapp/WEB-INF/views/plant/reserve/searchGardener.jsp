<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/reserveHeader.jsp" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="shortcut icon" href="#">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>가드너 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="../css/datepicker.min.css">
    
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

* {
	margin: 0;
	padding: 0;
}
body{
	padding: 20px 5em 0 4em;
}
.double div {
	float: left;
}

.sub {
	position: relative;
    margin-top: 45px;
}
.gardenerCard{
	margin: 0 auto;
	margin-top: 45px;
    max-width: calc(100% - 50px);
    width: 1200px;
    text-align: center;
    font-size: 15px;
}

.row > .profileView {
   	width: 33.33333%;
}
.profileView{
    background: #fff;
    box-shadow: inset 0px 0px 0px 1px rgb(0 0 0 / 15%), 0px 2px 3px 0px rgb(0 0 0 / 10%);
    text-align: center;
    padding: 2em;
}
input {
	padding:0px 0px 0px 10px;
	font-size:13px;
	border-radius:10px;
	border: none;
	outline: none;
	height: 30px;
	background: #80808026;
}
  
h1 {
	color: #252122;
	font-weight: 900;
	font-size: 2.5em;
	letter-spacing: -0.035em;
	line-height: 1;
	font-family: 'Jeju Gothic', sans-serif;
	text-align: center;
	
}
h1, h2, h3, h4, h5, h6 {
	font-family: 'Jeju Gothic', sans-serif;
	text-transform: uppercase;
	color: #6b7770;
	margin: 0 0 0.5em 0;
	line-height: 1.3;
}

h3, h4, h5, h6{
    font-weight: 500;
}
h1 a, h2 a, h3 a, h4 a, h5 a, h6 a {
	text-decoration: none;
	color: inherit;
}

hr.hr-6 {
  border: 0;
  border-top: 2px dotted #8c8c8c;
}
hr.hr-0 {
	border: 0;
	border-top: #e7eae8;
}
.search{
	background: #fff;
	border-radius: 30px;
	padding: 20px;
	border: 5px solid #5fb7544a;
}
table {
	margin-bottom: 1em;
}
.profileCard{
	border: 1px solid black;
	text-align: left;
}
td{
	padding: 0px 15px 0px 15px;
}

button {
	border: none;
	display: block;
	position: relative;
	width: 120px;
	padding: 0;
	margin: 10px 20px 10px 0;
	font-weight: 600;
	text-align: center;
	line-height: 50px;
	color: #FFF;
	border-radius: 5px;
	transition: all 0.2s ;
	background: #00AE68;
}
button:hover {
	background: #21825B;
}

select {
	border: 1px solid #0a8f00;
	padding: 1px;
	-webkit-appearance: button;
	outline: none;
}



</style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="../js/datepicker.min.js"></script>
    <script src="../js/lang/datepicker.ko.js"></script>
    <script>
  	//두개짜리 제어 연결된거 만들어주는 함수
  	$(function(){
    	datePickerSet($("#dateStart"), $("#dateEnd"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
    	/*
        * 달력 생성기
        * @param sDate, 
        * @param eDate 2개 넣으면 연결달력 생성되어 서로의 날짜를 넘어가지 않음
        * @example   datePickerSet($("#dateStart"), $("#dateEnd"));
        */
    	function datePickerSet(sDate, eDate, flag) {

	    	//시작 ~ 종료 2개 짜리 달력 datepicker	
	    	if (!isValidStr(sDate) && !isValidStr(eDate) && sDate.length > 0 && eDate.length > 0) {
        		var sDay = sDate.val();
         	  	var eDay = eDate.val();
          		if (flag && !isValidStr(sDay) && !isValidStr(eDay)) { //처음 입력 날짜 설정, update...			
                	var sdp = sDate.datepicker().data("datepicker");
                	sdp.selectDate(new Date(sDay));

                	var edp = eDate.datepicker().data("datepicker");
                	edp.selectDate(new Date(eDay));
          		}

            	//시작일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
            	if (!isValidStr(eDay)) {
                	sDate.datepicker({
                  		maxDate: new Date(eDay)
                	})
            	}
           		sDate.datepicker({
                	language: 'ko',
                	autoClose: true,
                	onSelect: function () {
                    	datePickerSet(sDate, eDate)
                	}
            	});

            	//종료일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
            	if (!isValidStr(sDay)) {
               		eDate.datepicker({
                    	minDate: new Date(sDay)
                	})
            	}
            	eDate.datepicker({
                	language: 'ko',
                	autoClose: true,
                	onSelect: function () {
                    	datePickerSet(sDate, eDate)
                	}
            	});

        	}

        	function isValidStr(str) {
            	if (str == null || str == undefined || str == "")
                	return true;
            	else
                	return false;
        	}
    	}
  	});  	
  	
  	// 가드너 프로필 카드
    function btnClick(){
    	$.ajax({
    		url : "/plant/reserve/profileCard.do"
    		, data : {
    			searchName : $("#searchName").val()
    			, array : $("#array").val()
    			, dateStart : Number($("#dateStart").val().replace(/\-/g,'')) // 숫자로 형변환하고 -를 빈칸으로 변환
    			, dateEnd : Number($("#dateEnd").val().replace(/\-/g,''))  // 숫자로 형변환하고 -를 빈칸으로 변환
    			, searchMajor : $("#searchMajor").val()
    			, searchAbleaddr : $("#searchAbleaddr").val()
    			, category : $("#category").val()
    		}
    		, success : function(res) {
    			$("#profile").html(res); // profile에 프로필 카드 호출
    		}
    	});
    	document.getElementById('profile').scrollIntoView();
    }
  	
  	// 대표후기 및 예약가능시간과 해당하는 시간의 예약가능 종목 보기
  	function riviewAndReservable(e){
  	   	$.ajax({
  	    	url : "/plant/reserve/riviewAndReservable.do"
  	   		, data : {
  	   			gd_no : $(e).attr("id")
  	   			, dateStart : Number($("#dateStart").val().replace(/\-/g,''))
  	   			, dateEnd : Number($("#dateEnd").val().replace(/\-/g,''))
  	   			, searchMajor : $("#searchMajor").val()
  	    	}
  	    	, success : function(res) {
  	    		console.log("성공");
  	   			$("#riviewAndReservable").html(res);
  	   		}
  	   	})
  	}
  	
	// 가드너 프로필 상세보기 화면으로 이동
	function profileView() {
		$(".profileView").click(function(){
	   		var no = $(this).attr("id");
			location.href="/plant/reserve/profileView.do?gd_no="+no+"";
		})
	}
</script>
</head>
<body>
	<div class="sub">
	<h1>가드너 검색</h1>
	<hr class="hr-6">
		<div class="size">
			<div class="subtitle">
				<!--  검색 -->
				<div class="bbsSearch">
					<form method="get" name="search" id="search" action="">
						<div class="search">
							<!-- 향후 자바스크립트 처리로 달력 뜰 수 있게 하기 -->
							<!-- 검색 시작 일자 ~ 종료 일자 -->
							<h2>예약일로 가드너 검색</h2>
							<h4>원하는 예약일</h4>
							<input type="text" id="dateStart" name="dateStart"> ~
							<input type="text" id="dateEnd" name="dateEnd">
							<hr class="hr-0">
							<!-- 예약가능 종목, 출장주소, 이름으로 검색 -->
							<h2>검색 옵션</h2>
							<table >
								<tr>
									<th><h4>케어종목</h4><th>
									<td>
									<!-- 케어가능 종목 -->
									<select id="searchMajor" name="searchMajor" class="dSelect">
											<option value="">선택하지 않음</option>
										<c:forEach var="m" items="${major}">
											<c:if test="${m.major_no ne 7 and m.major_no ne 8 and m.major_no ne 9 and m.major_no ne 10}">
												<option value="${m.major}">${m.major}</option>
											</c:if>
										</c:forEach>
									</select>
									</td>
									<th><h4>출장가능지역</h4></th>
									<!-- 출장가능지역 -->
									<td>
									<select id="searchAbleaddr" name="searchAbleaddr" class="dSelect" title="출장가능지역">
										<option class="option" value="">선택하지 않음</option>
										<option class="option" value="서울">서울</option>
										<option value="인천">인천</option>
										<option value="대구">대구</option>
										<option value="부산">부산</option>
										<option value="광주">광주</option>
										<option value="대전세종">대전세종</option>
										<option value="경기북부">경기북부</option>
										<option value="경기남부">경기남부</option>
										<option value="강원북부">강원북부</option>
										<option value="강원남부">강원남부</option>
										<option value="충청북도">충청북도</option>
										<option value="충청남도">충청남도</option>
										<option value="전라북도">전라북도</option>
										<option value="전라남도">전라남도</option>
										<option value="경상북도">경상북도</option>
										<option value="경상남도">경상남도</option>
										<option value="제주도">제주도</option>
									</select>
									</td>
									<th><h4>가드너 이름</h4></th>
									<td>
										<!-- 가드너 이름 -->
										<input type="text" id="searchName" name="searchName" value="">
									</td>
									<th><h4>정렬 옵션</h4></th>
									<td>
									<!-- 정렬기능 -->
									<div class="category">
										<select id="category" name="category" title="정렬">
											<option value="manyReview">리뷰 많은 순</option>
											<option value="littleReview">리뷰 적은 순</option>
											<option value="highStar">평균 별점 높은 순</option>
											<option value="lowStar">평균 별점 낮은 순</option>
											<option value="manyCancel">예약 취소 많은 순</option>
											<option value="littleCancel">예약 취소 적은 순</option>
											<option value="manyReserve">예약 많은 순</option>
											<option value="littleReserve">예약 적은 순</option>
										</select>
									</div>
									</td>
								</tr>
							</table>
								<!-- 검색 버튼 -->
								<button type="button" onClick="javascript:btnClick()">검색</button>
						</div>
					</form>
					<!-- 프로필카드 -->
					<div id="profile"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>