<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/reserveHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
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

.custom_calendar_table td {
	text-align: center;
}

.custom_calendar_table thead.cal_date th {
	font-size: 1.5rem;
	color: #B1DDAA;
}

.custom_calendar_table thead.cal_date th button {
	font-size: 1.5rem;
	background: none;
	border: none;
	color: #B1DDAA;
}

.custom_calendar_table thead.cal_week th {
	background-color: #b1ddaa;
	color: #fff;
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
<meta charset="UTF-8">
<title>가드너 예약</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script>
	// 달력 출력
	$(function(){
		calendarMaker($("#calendarForm"), new Date());	
	})
	
	// gd_no
	var urlParams = new URL(location.href).searchParams;
	var gd_no = urlParams.get('gd_no');
	
	// 시간 변수
	var nowDate = new Date();
	
	// 현재 시간
	var nowYear = moment(nowDate).format('YYYY-MM-DD').substr(0,4);
	var nowMonth = moment(nowDate).format('YYYY-MM-DD').slice(5,7);
	var nowDay = moment(nowDate).format('YYYY-MM-DD').slice(8,10);
	var dateStr = nowYear + nowMonth + nowDay;

	// 예약가능 날짜, 시간, 종목 가져오기
	var reservable = new Array();
	<c:forEach items = "${reservable}" var = "r">
		reservable.push({
			reservable_no : "${r.reservable_no}"
			, reservable_date : "${r.reservable_date}"
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

	// 종목 가격정보
	var majorPrice = new Array();
	<c:forEach items = "${major}" var = "m">
		majorPrice.push({
			major_no : "${m.major_no}"
			, major : "${m.major}"
			, major_price : "${m.major_price}"
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
	        		res += "<h3>예약가능 스케줄</h3>";
        			res += "<table border='1' class='default'>";
    	    		res += "	<tr>";
	        		res += "		<td colspan='3'>";
        			res += "			"+date.format('YYYY-MM-DD')+"";
    	    		res += "		</td>";
	        		res += "	</tr>";
        			res += "	<tr>";
    	    		res += "		<td>예약 가능 시간</td>";
	        		res += "		<td>예약 가능 종목</td>";
        			res += "		<td>예약</td>";
        			res += "	</tr>";
        			res += "	<tr>";
        		if ($('#'+idValue+'').attr('class') === 'default') {
        			res += "<td colspan='5'>예약가능한 일정이 없습니다.</td>"
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
        					res += "	<td>";
        					res += "		<button type='button' onclick='reserveSelect(this.value, "+reservableDate[i].reservable_no+")' value='"+idValue+"_"+reservableDate[i].reservable_hour+"_"+reservableDate[i].reservable_major+"'>예약</button>";
        					res += "	</td>";
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

	// 예약 일정 선택하기
	function reserveSelect(value, id) {
		var reservableNo = id;
		// value값 '_' 구분자로 3등분
		var select = value.split('_', 3);
		// date값 Moment.js로 양식변경
		var date = moment(select[0]);
		// 종목리스트에서 선택된 종목가격 및 출장비
		var majorPay = (majorPrice.filter(v => v.major === select[2]))[0].major_price;
		var visitPay = (majorPrice.filter(v => v.major === '출장비용'))[0].major_price;
		// 가드너 출장 가능 주소
		var gdAbleaddr = $("#ableaddr").text();
		// 유저 출장 지역 주소
		var userAddr = "<%-- <%=(String)session.getAttribute('userAddr')%> --%>"
		// select Tr 길이
		var trLength = $("#select tr").length;
		// 선택된 날짜가 아닐 때 true
		var flag = true;
		// 출장비용 추가 부과
		var accept = true;
		// 내역 앞에 추가 여부
		var prepend = true;
		// 시간 지난 여부
		var time = false;
		// 시간이 지난 예약은 선택 불가능dateStr
		var newReservableDate = value.substring(0,8);
		if(Number(dateStr)+1 <= Number(newReservableDate)) {
			time = true;
		}	
		if(Number(dateStr)+1 > Number(newReservableDate)) {
			alert("현재일 : "+nowYear+"년 "+nowMonth+"월 "+nowDay+"일 \n현재일로부터 1일 이후 날짜만 예약 가능합니다.");
			flag = false;
		}	
		
		if(time){
			// 날짜 중복선택 방지
			for(var i=0; i<trLength; i++) {
				if(Number($('#select tr').eq(i).attr('id')) === reservableNo) {
					alert("이미 선택된 날짜 입니다.");
					flag = false;
					break;
				}
			}
			// 동일한 날짜만 선택가능
			var trReservable = $('#select tr').eq(0).attr('id');
			if(trLength > 0 && trReservable !== 'noSelect') {
				var tdReservableDate = $('#'+trReservable+'').find("td:eq(0)").attr('id');
				if(Number(tdReservableDate) !== Number(newReservableDate)) {
					alert("동일한 날짜만 선택이 가능합니다.");
					flag = false;
				}	
			}
		}
		if(flag){
			// 선택한 예약정보
			var res = "<tr id='"+reservableNo+"'>";
				res += "	<td id='"+select[0]+"'>"+date.format('YYYY-MM-DD')+"</td>";
				res += "	<td id='"+select[1]+"'>"+select[1]+"</td>";
				res += "	<td>"+select[2]+"</td>";
				res += "	<td><button type='button' onclick='javascript:deleteList(this.value)' value='"+reservableNo+"'>선택취소</input></td>";
				res += "</tr>";

			// 예약 가격정보
			var price = "<tr id='"+reservableNo+"Price'>";
				price += "	<td>"+select[2]+"</td>";
				price += "	<td>"+majorPay+"</td>";
			// 유저의 주소와 가드너 출장 주소가 같을 때
			if (gdAbleaddr === userAddr.includes(gdAbleaddr)) {
				price += "	<td>추가내역 없음</td>";
				price += "	<td>추가금액 없음</td>";
				price += "	<td class='subTotal' id='"+id+"subTotal'>"+Number(majorPay)+"</td>";
			}
			// 유저의 주소와 가드너 출장 주소가 같지 않을(출장비용 1회만 부과되도록)
			if (gdAbleaddr !== userAddr.includes(gdAbleaddr)) {
				var result = true;
				var find = false;
				for(var i=0; i<trLength; i++) {	
					// 선택일 값 비교
					if($('#select tr').eq(i).find("td:eq(0)").attr('id') === select[0]){
						// 선택 시간 비교
						if($('#select tr').eq(i).find("td:eq(1)").text() == Number(select[1])+1 || $('#select tr').eq(i).find("td:eq(1)").text() == Number(select[1])-1){
							find = true;
						}
					}
				}
				for(var i=0; i<trLength; i++) {
			 		// 선택일의 값 비교(같은 값만 비교)
					if($('#select tr').eq(i).find("td:eq(0)").attr('id') === select[0]){
						// 선택한 시간 +1 -1 인 경우
						if($('#select tr').eq(i).find("td:eq(1)").text() == Number(select[1])+1 || $('#select tr').eq(i).find("td:eq(1)").text() == Number(select[1])-1 || find){
							price += "	<td>연속된 시간으로 출장비용 없음</td>";
							price += "	<td>추가금액 없음</td>";
							price += "	<td class='subTotal' id='"+id+"subTotal'>"+Number(majorPay)+"</td>";
							result = false;
							break;
						}
						// 1시간이상 일정이 차이가 날때 확인
						if($('#select tr').eq(i).find("td:eq(1)").text() > Number(select[1])+1 || $('#select tr').eq(i).find("td:eq(1)").text() < Number(select[1])-1){
							if (!confirm("연속된 시간이 아닐경우 출장비용이 추가적으로 부과됩니다. 그래도 예약하시겠습니까?")) {
								accept = false;
								break;
				        	} else {
				        		price += "	<td>출장비용</td>";
								price += "	<td>"+visitPay+"</td>";
								price += "	<td class='subTotal' id='"+id+"subTotal'>"+(Number(majorPay) + Number(visitPay))+"</td>";
								result = false;
								break;
				        	}
						}
					}
				}
				if(result) {
					price += "	<td>출장비용</td>";
					price += "	<td>"+visitPay+"</td>";
					price += "	<td class='subTotal' id='"+id+"subTotal'>"+(Number(majorPay) + Number(visitPay))+"</td>";
				}
			}			
				price += "</tr>";
			if($("#noSelect").length > 0){
				$("#noSelect").remove();
			}
			if($("#noPrice").length > 0){
				$("#noPrice").remove();
			}
			if(accept){
				$("#price").append(price);
				$("#select").append(res);
			}
			// 가격 총합
			totalPrice();
			formData();
		}
	}

	// 선택취소 버튼 눌러서 내역 삭제 
	function deleteList(id) {
		var reservable_no = id;
		// 예약정보 삭제
		$("#"+reservable_no+"").remove();
		// 가격정보 삭제
		$("#"+reservable_no+"Price").remove();
	
		// tr 길이 측정
		var selectLength = $("#select tr").length;
		var priceLength = $("#price tr").length;
	
		// 예약내역없을 때 td 추가
		if(selectLength === 0) {
			var res = "<tr id='noSelect'><td colspan='5'>선택된 예약일정이 없습니다.</td></tr>";
			$("#select").html(res);
		}
		if(priceLength === 0) {
			var res = "<tr id='noPrice'><td colspan='5'>선택된 예약일정이 없습니다.</td></tr>";
			$("#price").html(res);
		}
		totalPrice();
		formData();
	}

	// 수정가능하도록 변
	function update() {
		$("#addr1").attr('readonly', false);
		$("#addr2").attr('readonly', false);
	}

	// 총합 가격 구하기
	function totalPrice() {  
		var priceLength = $("#price tr").length;
		var sum = 0;
	
		// 합계 계산
		for(var i = 0; i < priceLength; i++)  {
			sum += Number($(".subTotal").eq(i).text());
		}
	
		var res = "<td id='totalPrice'>"+sum+"원</td>"
		// 합계 출력
		$("#noTotalPrice").html(res);
	}

	// form에 data 추가 하기
	function formData() {
		// url에서 gd_no값 가져오기
		var urlParams = new URL(location.href).searchParams;
		var gd_no = urlParams.get('gd_no');
		// reserveInfo 값가져오기
		var trLength = $("#select tr").length; 
		var reservableNo = "";
		var form = "<input type='hidden' name='gd_no' value='"+gd_no+"'>";
			form += "<input type='hidden' name='user_no' value='2'>"; // 추후 세션값으로 고치기
		for(var i=0; i<trLength; i++) {
			if(i === 0) {
				reservableNo += ""+$('#select tr').eq(i).attr('id')+"";
			}
			if(i !== 0) {
				reservableNo += ","+$('#select tr').eq(i).attr('id')+"";
			}
		}
			form += "<input type='hidden' name='selectReserve' value='"+reservableNo+"'>";
		var reservableNoList = reservableNo.split(',');
		for(var i=0; i<reservableNoList.length; i++) {
			form += "<input type='hidden' name='selectReserveSubTotal' value='"+$('#'+reservableNoList[i]+'subTotal').text()+"'>";
		}
		$("#param").html(form);
	}	

	// 결제 페이지로 이동
	function goPay() {
		if(frm.selectReserve.value === 'noSelect') {
			alert("선택된 예약일자가 존재하지 않습니다.");
		}
		if(frm.selectReserve.value !== 'noSelect') {
			frm.submit();
		}
	}
	
	// 결제 페이지로 이동
	function goBack() {
		location.href="/plant/reserve/profileView.do?gd_no"+gd_no+"";
	}

</script>
</head>
<body>
	<table class='default'>
		<tr><th style='font-size: 20pt; text-align: center;'>예약 상세정보</th></tr>
	</table>
	<!-- 예약페이지 상단 -->
	<div>
		<!-- 가드너 프로필 -->
		<div>
			<table border="1" id="top" class='default'>
				<tr>
					<th colspan='6' style='text-align: center;'>가드너 프로필 카드</th>
				</tr>
				<tr>
					<td rowspan="7" style="width: 300px; text-align: center;">
						<img src='<%=request.getContextPath()%>/upload/${data.gd_picreal}' style='width:90px; height:90px;' >
					</td>
					<td>이름</td>
					<td>&nbsp${data.gd_name}&nbsp(만 ${data.gd_age}세)&nbsp</td>
					<td>연락처</td>
					<td>&nbsp${data.gd_hp}&nbsp</td>
				</tr>
				<tr>
					<td>e-mail</td>
					<td>&nbsp${data.gd_email}</td>
					<td>출장가능 지역</td>
					<td id="ableaddr">&nbsp${data.gd_ableaddr}&nbsp</td>
				</tr>
				<tr>
					<td>주요 케어 종목</td>
					<td colspan="3"><c:if test="${!empty data.gd_major1}">
							${data.gd_major1}
						</c:if> <c:if test="${!empty data.gd_major2}">
							,${data.gd_major2}
						</c:if> <c:if test="${!empty data.gd_major3}">
							,${data.gd_major3}
						</c:if> <c:if test="${!empty data.gd_major4}">
							,${data.gd_major4}
						</c:if> <c:if test="${!empty data.gd_major5}">
							,${data.gd_major5}
						</c:if> <c:if test="${!empty data.gd_major6}">
							,${data.gd_major6}
						</c:if> <c:if test="${!empty data.gd_major7}">
							,${data.gd_major7}
						</c:if></td>
				</tr>
				<tr>
					<td>총 케어 진행 횟수</td>
					<td>${completion.completion_count}</td>
					<td>평균 별점</td>
					<td>${data.starAverage}점</td>
				</tr>
				<tr>
					<td>이력</td>
					<td colspan="3">
						<div style="overflow: auto; width: 100%; height: 70px;">
							<c:forEach var="c" items="${career}">
								<p>${c.gd_career}</p>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<td>자격 사항</td>
					<td colspan="3">
						<div style="overflow: auto; width: 100%; height: 70px;">
							<c:forEach var="c" items="${certificate}">
								<p>${c.gd_certificate}</p>
							</c:forEach>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 달력 -->
		<div id="calendarForm"></div>
		<div>
			<div id="reservableSchedule"></div>
			<div>
				<table border='1' class='default'>
					<tbody>
						<tr>
							<td colspan='5'>선택한 예약 정보</td>
						</tr>
						<tr>
							<td>선택일</td>
							<td>선택 시간</td>
							<td>선택 종목</td>
							<td>선택 취소</td>
						</tr>
						<tr id="noSelect">
							<td colspan="4">선택된 예약일정이 없습니다.</td>
						</tr>
					</tbody>
					<tbody id="select">
					</tbody>
				</table>
				<table border='1' class='default'>
					<!-- 소계 가격 -->
					<tbody>
						<tr>
							<td colspan='5'>예약 가격</td>
						</tr>
						<tr>
							<td>케어종목</td>
							<td>종목가격</td>
							<td>추가내역</td>
							<td>추가금액</td>
							<td>소계</td>
						</tr>
						<tr id="noPrice">
							<td colspan="5">선택된 예약일정이 없습니다.</td>
						</tr>
					</tbody>
					<tbody id="price">
					</tbody>
				</table>
				<table border='1' class='default'>
					<!-- 합산 가격 -->
					<tbody>
						<tr>
							<td colspan='5'>총 가격</td>
						</tr>
					</tbody>
					<tbody id="totalPrice">
						<tr id="noTotalPrice">
							<td>0원</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div>
			<!-- 파라메터 전달을 위한 form -->
			<form method="post" name="frm" id="frm" action="pay.do">
				<div id="param">
					<input type="hidden" name="gd_no" value=""> <input
						type="hidden" name="user_no" value=""> <input
						type="hidden" name="selectReserve" value="noSelect">
				</div>
			</form>
			<table class='default'>
				<tr>
					<td>
						<button onclick="javascript:goBack()">뒤로가기</button>
					</td>
					<td>
						<button onClick="javascript:goPay()">이 일정으로 예약하기</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>