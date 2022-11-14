<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가드너 프로필</title>
<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>

<style>
.review {
	margin: 1px;
	display: block;
	color: black;
	width: 200px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

* {
	margin: 0;
	padding: 0
}
.custom_calendar_table{
    width: 100%;
    height: 450px;
  	border: 1px solid rgba(0,0,0,.1);
}
.custom_calendar_table td {
	text-align: center;
}

.custom_calendar_table thead.cal_date th {
	font-size: 1.5rem;
	color: #6C987E;
	
}

.custom_calendar_table thead.cal_date th button {
	font-size: 1.5rem;
	background: none;
	border: none;
	color: #6C987E;
}

.custom_calendar_table thead.cal_week th {
	background-color: #6C987E;
	color: #fff;
	vertical-align: middle;
}

.custom_calendar_table tbody td {
	cursor: pointer;
}

.custom_calendar_table tbody td:nth-child(1) {
	color: red;
}

.custom_calendar_table tbody td:nth-child(7) {
	color: #288CFF;
}

.custom_calendar_table tbody td.select_day {
	background-color: #288CFF;
	color: #fff;
}
.custom_calendar_table tbody td.reserved {
	background-color: #ff255d;
	color: #fff;
}
.custom_calendar_table tbody td.reservable {
	background-color: #73d5ac;
	color: #000000;
}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script>
	// 예약확인 일자 확인 버튼 클릭 이벤트
	$(function(){
		calendarMaker($("#calendarForm"), new Date());	
	})
	// 달력 출력
	var nowDate = new Date();
	
	// 예약가능 날짜, 시간, 종목 가져오기
	var reservable = new Array();
	<c:forEach items = "${reservable}" var = "r">
		reservable.push({
			reservable_date : "${r.reservable_date}"
			, reservable_hour : "${r.reservable_hour}"
			, reservable_major : "${r.reservable_major}"
		});
	</c:forEach>
	// 예약된 날짜, 시간, 종목 가져오기
	var reserved = new Array();
	<c:forEach items = "${reserved}" var = "rd">
		reserved.push({
			reserved_date : "${rd.reservable_date}"
			, reserved_hour : "${rd.reservable_hour}"
			, reserved_major : "${rd.reservable_major}"
		});
	</c:forEach>
	
	function calendarMaker(target, date) {
	    if (date == null || date == undefined) {
	        date = new Date();
	    }
	    nowDate = date;
	    if ($(target).length > 0) {
	        var year = nowDate.getFullYear();
	        var month = nowDate.getMonth() + 1;
	        $(target).empty().append(assembly(year, month));
	    } else {
	        console.error("custom_calendar Target is empty!!!");
	        return;
	    }

	    var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
	    var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);

	    var tag = "<tr>";
	    var cnt = 0;
	    //빈 공백 만들어주기
	    for (i = 0; i < thisMonth.getDay(); i++) {
	        tag += "<td></td>";
	        cnt++;
	    }
		
	    //날짜 채우기
	    for (i = 1; i <= thisLastDay.getDate(); i++) {
	        if (cnt % 7 == 0) { tag += "<tr>"; }
	        // 월이 한 자리 일때
			if (month < 10) {
				// 월이 한 자리이고 일이 한 자리 일 때
				if (i < 10) {	 
	        		tag += "<td id='"+year+"0"+month+"0"+i+"' class='default'>" + i + "</td>";
				}
				// 월이 한 자리이고 일이 두 자리 일 때
				if (i >= 10) {	
	        		tag += "<td id='"+year+"0"+month+""+i+"' class='default'>" + i + "</td>";
				}
			}
			// 월이 두 자리 일때
			if (month >= 10) {
				// 월이 두 자리이고 일이 한 자리 일 때
				if (i < 10) {	
					tag += "<td id='"+year+""+month+"0"+i+"' class='default'>" + i + "</td>";
				}
				// 월이 두 자리이고 일이 두 자리 일 때
				if (i >= 10) {	
					tag += "<td id='"+year+""+month+""+i+"' class='default'>" + i + "</td>";
				}
			}
	        cnt++;
	        if (cnt % 7 == 0) {
	            tag += "</tr>";
	        }
	    }
	    $(target).find("#custom_set_date").append(tag);
	    classChange();
	    calMoveEvtFn();
		
	    function assembly(year, month) {
	        var calendar_html_code =
	            "<table class='custom_calendar_table'>" +
	            	"<colgroup>" +
	           			"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            		"<col style='width:50px'/>" +
	            	"</colgroup>" +
	            	"<thead class='cal_date'>" +
	            		"<th><button type='button' class='prev'><</button></th>" +
	            		"<th colspan='5'>";
	        // 달이 한 자리일 때
			if (month < 10) {
				calendar_html_code += "<p id='"+year+"0"+month+"' class='yearMonth'>";
			}
	        // 달이 두 자리일 때
			if (month >= 10) {
				calendar_html_code += "<p id='"+year+""+month+"' class='yearMonth'>";
			}
			calendar_html_code += "<span>" + year + "</span>년 <span>" + month + "</span>월</p></th>" +
						"<th><button type='button' class='next'>></button></th>" +
	            	"</thead>" +
	            	"<thead  class='cal_week'>" +
	            		"<th colspan='7'>좌우 화살표로 다음(이전월)로 이동 가능하며 초록색은 예약가능한 날을 빨간색은 예약 불가능한 날을 나타냅니다.</th>" +
	            	"</thead>" +
	            	"<thead  class='cal_week'>" +
	            		"<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
	            	"</thead>" +
	            	"<tbody id='custom_set_date'>" +
	            	// 달력검색을 위한 클래스 생성
	            		"<tr>" +
	            			"<input type='hidden' class='reservable'>"+
	            			"<input type='hidden' class='reserved'>"+
	            		"</tr>"+
	            	"</tbody>" +
	            "</table>";
	        return calendar_html_code;
	    }
	    
	    function classChange() {
	    	// table id값 스캔
			var tdId = $('#custom_set_date').find('td');
	    	// 예약가능한 date class 값 변경
	    	for(var i=0; i<reservable.length; i++) {
	    		for(var j=0; j<tdId.length; j++) {
	    			if(reservable[i].reservable_date === $(tdId[j]).attr('id')) {
	    				var thisId = $(tdId[j]).attr('id');
	    				$('#'+thisId+'').attr('class','reservable');	    				
	    			}
	    		}
	    	}
	    	// 예약된 내역 date class 값 변경
	    	for(var x=0; x<reserved.length; x++) {
	    		for(var y=0; y<tdId.length; y++) {
	    			// 현재 id 값
	    			var thisId = $(tdId[y]).attr('id');
	    			// 현재 class값
	    			var thisClass = $('#'+thisId+'').attr('class');
	    			if(thisClass !== 'reservable'){
	    				if(reserved[x].reserved_date === thisId) {
	    					$('#'+thisId+'').attr('class','reserved');	    				
	    				}
	    			}
	    		}
	    	}
	    	// 예약없는 td class값 변경
	    	for(var z=0; z<tdId.length; z++) {
    			// 현재 id 값
    			var thisId = $(tdId[z]).attr('id');
    			// 현재 class값
    			var thisClass = $('#'+thisId+'').attr('class');
    			if(thisClass !== 'reservable' && thisClass !== 'reserved'){
    					$('#'+thisId+'').attr('class','default');	    				
    			}
    		}
	    }
	    
	    function calMoveEvtFn() {
	        // 전달 클릭
	        $(".custom_calendar_table").on("click", ".prev", function () {
	            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
	            calendarMaker($(target), nowDate);
	        });
	        // 다음날 클릭
	        $(".custom_calendar_table").on("click", ".next", function () {
	            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
	            calendarMaker($(target), nowDate);
	        });   
	        //일자 선택 클릭
	        $(".custom_calendar_table").on("click", "td", function () {
				// 클릭한 id값 찾기
				var idValue = $(this).attr('id');				
				// 클릭한 td id값에 맞는 예약가능 일자 true 처리
				function rbDate(reservable) {
					if(reservable.reservable_date === idValue) {
						return true;
					}
				}
				// 클릭한 td id값에 맞는 예약된 일자 true 처리
				function rdDate(reserved) {
					if(reserved.reserved_date === idValue) {
						return true;
					}
				}
				// true인 객체 배열화
	        	var reservableDate = reservable.filter(rbDate); // 예약 가능일자
				var reservedDate = reserved.filter(rdDate); // 예약 된 일자
	        	var res = "";
        		var date = moment(idValue); // 모맨트 js 활용 하여 데이터 포맷 변경
	        	// select_day 클래스 삭제
	            $(".custom_calendar_table .select_day").removeClass("select_day");
	        	// 삭제 후 예약데이터와 비교하여 다시 클래스 변경
	            classChange();
            	res += "<br>";
            	res += "<h3 id=''>예약가능 스케줄</h3>";
            	res += "<table border='1' class='default' id='reservedTable'>";
            	res += "	<tr>";
            	res += "		<td colspan='3'>";
            	res += "			"+date.format('YYYY-MM-DD')+"";
            	res += "		</td>";
            	res += "	</tr>";
            	res += "	<tr style='background-color:#89AD98; color:#fff;'>";
            	res += "		<td>예약 가능 시간</td>";
            	res += "		<td>예약 가능 종목</td>";
            	res += "		<td>예약가능여부</td>";
            	res += "	</tr>";
            	res += "	<tr>";
            	if ($('#'+idValue+'').attr('class') === 'default') {
            		res += "<td colspan='3'>예약가능한 일정이 없습니다.</td>"
            	}
	        	// select_day
            	if ($(".custom_calendar_table .select_day").hasClass("select_day")) {
            		$(this).removeClass("select_day").addClass("select_day");
            	}
            	if ($(".custom_calendar_table .reservable").hasClass("reservable")) {
            		$(this).removeClass("reservable").addClass("select_day");
            		// 예약가능 시간	
            		if (reservableDate.length > 0) {
            			res += "</tr><td colspan='3'>예약가능 내역</td><tr>";
            			for(var i=0; i<reservableDate.length; i++){
            				res += "	<td>"+reservableDate[i].reservable_hour+"</td>";
            				res += "	<td>"+reservableDate[i].reservable_major+"</td>";
            				res += "	<td>예약가능</td>";
            				res += "</tr>";
            				res += "<tr>";
            			}
            		}
            	}	  
            	if ($(".custom_calendar_table .reserved").hasClass("reserved")) {
            		$(this).removeClass("reserved").addClass("select_day");
            		// 예약된 시간
            		if (reservedDate.length > 0) {
            			res += "</tr><td colspan='3'>예약완료 내역</td><tr>";
            			for(var i=0; i<reservedDate.length; i++){
            				res += "	<td>"+reservedDate[i].reserved_hour+"</td>";
            				res += "	<td>"+reservedDate[i].reserved_major+"</td>";
            				res += "	<td>예약완료</td>";	
            				res += "</tr>";
            				res += "<tr>";
            			}
            		}
            	}
            	if ($(".custom_calendar_table .default").hasClass("default")) {
            		$(this).removeClass("default").addClass("select_day");
            	}	
            	res += "	</tr>";
            	res += "</table>";
            	$("#reservableSchedule").html(res);
	        });
	    }
	}
	
	$(function(){	
		$("#goReservation").on('click',function(){ 
			location.href="/plant/reserve/reservation.do"+location.search+"";
		});
		
		$("#goBack").on('click',function(){ 
			location.href="/plant/reserve/searchGardener.do";
		});
	});
</script>
</head>
<body>
	<div class="sub" id="wrapper">
		<h2>가드너 상세 프로필</h2>
		<div class="size" id="gdView">
		<!-- 가드너 상세 프로필 -->
		<div>
			<table id="gdViewtable" border="1" class='default'>
				<tr>
					<th colspan='6'>가드너 프로필 카드</th>
				</tr>
				<tr >
					<td rowspan="7" style="text-align: center; width: 250px;">
						<img src='<%=request.getContextPath()%>/upload/${data.gd_picreal}' style='width:90px; height:90px;' >
					</td>
					<td style='background-color:#89AD98; color:#fff;'>이름</td>
					<td>&nbsp${data.gd_name}&nbsp(만 ${data.gd_age}세)&nbsp</td>
					<td style='background-color:#89AD98; color:#fff;'>연락처</td>
					<td>&nbsp${data.gd_hp}&nbsp</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>e-mail</td>
					<td colspan="3">&nbsp${data.gd_email}</td>
				</tr>
				<tr>
					<td style="width:90px;background-color:#89AD98; color:#fff;">출장가능 지역</td>
					<td>&nbsp${data.gd_ableaddr}&nbsp</td>
					<td style='background-color:#89AD98; color:#fff;'>가드너 등록일</td>
					<td>&nbsp<fmt:formatDate pattern="yyyy년 MM월 dd일"
							value="${data.gd_regdate}" />&nbsp
					</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>주요 케어 종목</td>
					<td colspan="3">
						<c:if test="${!empty data.gd_major1}">
							${data.gd_major1}
						</c:if>
						<c:if test="${!empty data.gd_major2}">
							,${data.gd_major2}
						</c:if>
						<c:if test="${!empty data.gd_major3}">
							,${data.gd_major3}
						</c:if>
						<c:if test="${!empty data.gd_major4}">
							,${data.gd_major4}
						</c:if>
						<c:if test="${!empty data.gd_major5}">
							,${data.gd_major5}
						</c:if>
						<c:if test="${!empty data.gd_major6}">
							,${data.gd_major6}
						</c:if>
						<c:if test="${!empty data.gd_major7}">
							,${data.gd_major7}
						</c:if>
					</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;' >이력</td>
					<td colspan="3">
						<div style="overflow: auto; width: 100%; height: 70px;" >
							<c:forEach var="c" items="${career}">
								<p>${c.gd_career}</p>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>자격 사항</td>
					<td colspan="3">
						<div style="overflow: auto; width: 100%; height: 70px;">
							<c:forEach var="c" items="${certificate}">
								<p>${c.gd_certificate}</p>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>후기 & 별점</td>
					<td colspan="3">
						<div style="overflow: auto; width: 100%; height: 150px;">
							<div>평균 별점 : ${data.starAverage}점</div>
							<br>
							<br>
							<c:forEach var="r" items="${review}">
								<div id="review">
									<p>닉네임 : ${r.user_nick} 별점: ${r.star} <br>
										후기: ${r.review}</p>
								</div>
								<br>
							</c:forEach>
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		</div>
	</div>
	
	<div class="sub" id="wrapperView">
		<div class="size" id="gdView">
		<div>
			<div id="calendarForm"></div>
			<div id="reservableSchedule"></div>
		</div>
		<br>
		<div>
			<table class='default'>
				<tr>
					<td>
						<button onclick="javascript:goBack()">뒤로가기</button>
					</td>
					<td>
						<button id="goReservation">이 가드너로 예약하기</button>
					</td>
				</tr>
			</table>
		</div>
		</div>
	</div>


	
</body>
</html>