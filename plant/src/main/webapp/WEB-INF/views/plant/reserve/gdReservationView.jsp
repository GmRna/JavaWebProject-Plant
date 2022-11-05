<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 예약 확인하기</title>
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

.set {
	background-color: #288CFF;
	color: #fff;
}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script>
	// 예약확인 일자 확인 버튼 클릭 이벤트
	$(function(){
		calendarMaker($("#calendarForm"), new Date());
	});
	
	// gd_no
	var urlParams = new URL(location.href).searchParams;
	var gd_no = urlParams.get('gd_no');
	
	// 달력 출력
	var nowDate = new Date();
	
	// 현재 시간
	var nowYear = nowDate.getFullYear();
	var nowMonth = ('0' + (nowDate.getMonth() + 1)).slice(-2);
	var nowDay = ('0' + nowDate.getDay()).slice(-2);
	var dateStr = nowYear + nowMonth + nowDay;
	
	// 결제 내역
	var gdPayHistoryList = new Array();
	<c:forEach items = "${gdPayHistoryList}" var = "p">
		gdPayHistoryList.push({
			pay_no : ${p.pay_no}
			, reserve_no : ${p.reserve_no}
			, pay_date : "${p.pay_date}"
			, pay_size : ${p.pay_size}
			, gd_no : ${p.gd_no}
			, user_no : ${p.user_no}
			, buyer_name : "${p.buyer_name}"
			, buyer_addr : "${p.buyer_addr}"
			, buyer_postcode : "${p.buyer_postcode}"
			, buyer_email : "${p.buyer_email}"
			, buyer_tel : "${p.buyer_tel}"
			, merchant_uid : "${p.merchant_uid}"
			, pay_method : "${p.pay_method}"
			, reserve_cancel : ${p.reserve_cancel}
		});
	</c:forEach>
	
	// 예약내역
	var reservationList = new Array();
	<c:forEach items = "${reservationList}" var = "r">
		reservationList.push({
			reserve_no : ${r.reserve_no}
			, gd_no : ${r.gd_no}
			, user_no : ${r.user_no}
			, reservable_no : ${r.reservable_no}
			, reserve_date : ${r.reserve_date}
			, reserve_hour : ${r.reserve_hour}
			, reserve_etc : "${r.reserve_etc}"
			, reserve_time : "${r.reserve_time}"
			, major : "${r.major}"
			, user_name : "${r.user_name}"
			, user_nick : "${r.user_nick}"
			, merchant_uid : "${r.merchant_uid}"
		});
	</c:forEach>
	
	// 예약내역
	var reservationCancelList = new Array();
	<c:forEach items = "${reservationCancelList}" var = "r">
		reservationCancelList.push({
			reserve_no : ${r.reserve_no}
			, gd_no : ${r.gd_no}
			, user_no : ${r.user_no}
			, reservable_no : ${r.reservable_no}
			, reserve_date : ${r.reserve_date}
			, reserve_hour : ${r.reserve_hour}
			, reserve_etc : "${r.reserve_etc}"
			, reserve_time : "${r.reserve_time}"
			, major : "${r.major}"
			, user_name : "${r.user_name}"
			, user_nick : "${r.user_nick}"
		});
	</c:forEach>
	
	// 예약가능
	var reservableList = new Array();
	<c:forEach items = "${reservableList}" var = "ra">
		reservableList.push({
			reservable_no : ${ra.reservable_no}
			, reservable_date : ${ra.reservable_date}
			, reservable_hour : ${ra.reservable_hour}
			, reservable_major : "${ra.reservable_major}"
		});
	</c:forEach>
	
	// 예약완료
	var reservedList = new Array();
	<c:forEach items = "${reservedList}" var = "rd">
		reservedList.push({
			reservable_no : ${rd.reservable_no}
			, reservable_date : ${rd.reservable_date}
			, reservable_hour : ${rd.reservable_hour}
			, reservable_major : "${rd.reservable_major}"
		});
	</c:forEach>
	
	// 종목 리스트
	var majorList = new Array();
	<c:forEach items = "${majorList}" var = "m">
		majorList.push({
			major_no : ${m.major_no}
			, major : "${m.major}"
			, major_price : ${m.major_price}
		});
	</c:forEach>
	
	// 취소 리스트
	var cancelList = new Array();
	<c:forEach items = "${cancelList}" var = "c">
		cancelList.push({
			cancel_no : ${c.cancel_no}
			, user_no : ${c.user_no}
			, gd_no : ${c.gd_no}
			, reserve_no : ${c.reserve_no}
			, cancel_date : "${c.cancel_date}"
			, cancel_comment : "${c.cancel_comment}"
			, user_name : "${c.user_name}"
			, user_nick : "${c.user_nick}"
		});
	</c:forEach>
	
	// 달력 호출
	function calendarMaker(target, date) {
	    if (date == null || date == undefined) {
	        date = new Date();
	    }
	    nowDate = date;
	    if ($(target).length > 0) {
	        var year = nowDate.getFullYear();
	        var month = nowDate.getMonth()+1;
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
	        		tag += "<td id='"+year+"0"+month+"0"+i+"'>" + i + "</td>";
				}
				// 월이 한 자리이고 일이 두 자리 일 때
				if (i >= 10) {	
	        		tag += "<td id='"+year+"0"+month+""+i+"'>" + i + "</td>";
				}
			}
			// 월이 두 자리 일때
			if (month >= 10) {
				// 월이 두 자리이고 일이 한 자리 일 때
				if (i < 10) {	
					tag += "<td id='"+year+""+month+"0"+i+"'>" + i + "</td>";
				}
				// 월이 두 자리이고 일이 두 자리 일 때
				if (i >= 10) {	
					tag += "<td id='"+year+""+month+""+i+"'>" + i + "</td>";
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
	
	
		/** 년도와 월로 table head 부분 작성
		*/
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
				// 달력검색을 위한 클래스 생성
				"<tbody id='custom_set_date'>" +
					"<tr>" +
						"<input type='hidden' class='reserved'>"+
						"<input type='hidden' class='reservable'>"+
						"<input type='hidden' class='default'>"+
					"</tr>"+
				"</tbody>" +
		        "</table>";
			return calendar_html_code;
		}
	    
		/** 저장된 array에 따라서 달력 class 값 변경
		*/
	    function classChange() {
	    	// table id값 스캔
			var tdId = $('#custom_set_date').find('td');
	    	// 예약가능한 date class 값 변경
	    	for(var i=0; i<reservableList.length; i++) {
	    		for(var j=0; j<tdId.length; j++) {
	    			if(reservableList[i].reservable_date === Number($(tdId[j]).attr('id'))) {
	    				var thisId = $(tdId[j]).attr('id');
	    				$('#'+thisId+'').attr('class','reservable');	    				
	    			}
	    		}
	   		}
	    	// 예약된 내역 date class 값 변경
	    	for(var x=0; x<reservedList.length; x++) {
	    		for(var y=0; y<tdId.length; y++) {
	    			// 현재 id 값
	    			var thisId = $(tdId[y]).attr('id');
	    			// 현재 class값
	    			var thisClass = $('#'+thisId+'').attr('class');
	    			if(thisClass !== 'reservable'){
	    				if(reservedList[x].reservable_date === Number(thisId)) {
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
	    
		/** 마우스로 달력 클릭시 예약 내역 표시
		*/
		function calMoveEvtFn() {
			// 전달 클릭
			$(".custom_calendar_table").on("click", ".prev", function () {
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
				calendarMaker($(target), nowDate);
			});
			// 다음달 클릭
			$(".custom_calendar_table").on("click", ".next", function () {
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
				calendarMaker($(target), nowDate);
			});    
			//일자 선택 클릭
			$(".custom_calendar_table").on("click", "td", function () {
				$('#reservedView').html('<div id="reservedView"></div>'); // 예약상세보기 초기화
				onclickCount = 0; // 온클릭 횟수 초기화
				var reset = true;
				if (addReservalbeReset) {
					reset = confirm("다른 날짜 클릭시 추가된 예약가능 일정이 모두 초기화 됩니다. 초기화 하시겠습니까?");
				}
				if (reservableChooseReset) {
					reset = confirm("다른 날짜 클릭시 추가된 예약가능 수정 및 삭제값이 모두 초기화 됩니다. 초기화 하시겠습니까?");
				}
				if(reset){
					reservableChooseReset = false;
					addReservalbeReset = false;
					// 클릭한 id값
					var idValue = $(this).attr('id');			
		    		// 모맨트 js 활용 하여 데이터 포맷 변경
		    		var date = moment(idValue); 
					// 클릭한 id값 SelectDate에 넣기
					if(Number(idValue)){
						var selectDate = ""
							selectDate += "<tr>";
							selectDate += "		<td>선택일</td>";
							selectDate += "		<td  id='"+idValue+"'>"+date.format('YYYY-MM-DD')+"</td>";
							selectDate += "		<td><button type='button' onclick='addReservable("+idValue+")'>예약가능일정 추가하기</button></td>";
							selectDate += "</tr>";
							selectDate += "<tr>";
							selectDate += "		<td>예약가능시간</td>"; 
							selectDate += "		<td>케어종목</td>";
							selectDate += "		<td>선택</td>";
							selectDate += "</tr>";
						var addReservableSchedule = "<tr><td colspan='3'>예약가능일정을 추가하여 주세요</td></tr>"
						$('#selectDate').html(selectDate);
						$('#addReservableSchedule').html(addReservableSchedule);
					} else {
						var selectDate = ""
							selectDate += "<td>선택일</td>";
							selectDate += "<td>정확한 일자를 선택해주세요</td>";
						$('#selectDate').html(selectDate);
						$('#addReservableSchedule').html("<div id='addReservableSchedule'></div>");
					}
					// 클릭한 td id값에 맞는 예약가능 일자 true 처리
					function rbDate(reservableList) {
						if(reservableList.reservable_date === Number(idValue)) {
							return true;
						}
					}
					// 클릭한 td id값에 맞는 예약된 일자 true 처리
					function rdDate(reservedList) {
						if(reservedList.reservable_date === Number(idValue)) {
							return true;
						}
					}
					// 클릭한 td id값에 맞는 예약된 일자 true 처리
					function rDate(reservationCancelList) {
						if(reservationCancelList.reserve_date === Number(idValue)) {
							return true;
						}
					}
					// true인 객체 배열화
		        	var reservableDate = reservableList.filter(rbDate); // 예약 가능일자
					var reservedDate = reservedList.filter(rdDate); // 예약 된 일자
					var reservationCancelDate = reservationCancelList.filter(rDate); // 예약 된 일자
							    			
			        // select_day 클래스 삭제
					$(".custom_calendar_table .select_day").removeClass("select_day");
		    			
					// 삭제 후 예약데이터와 비교하여 다시 클래스 변경       	
					classChange();
					
					// default
					if ($('#'+idValue+'').attr('class') === 'default') {
						var noReserve = "";
							noReserve += "<table border='1' class='default'>";
							noReserve += "	<tr>";
							noReserve += "		<td colspan='2'>예약이 없는 일정</td>";	
							noReserve += "	</tr>";	            	
							noReserve += "	<tr>";            			
							noReserve += "		<td>선택일</td>";	
		        			noReserve += "		<td>"+date.format('YYYY-MM-DD')+"</td>";	
		        			noReserve += "	</tr>";	            	
		        			noReserve += "	<tr>";
		        			noReserve += "		<td colspan='2'>예약되거나 예약된 일정이 없습니다.</td>";
		        			noReserve += "	</tr>";
		        			noReserve += "</table>";        			
		            	$("#noReserve").html(noReserve);
		            	reservableChooseListDeleteAll();
		            }
			        // select_day
		            if ($(".custom_calendar_table .select_day").hasClass("select_day")) {
		            	$(this).removeClass("select_day").addClass("select_day");
		            }
			        // reservable
		        	if ($(".custom_calendar_table .reservable").hasClass("reservable")) {
		        		$(this).removeClass("reservable").addClass("select_day");
		        		var reservable = "";
		        		// 예약가능 시간	
		        		if (reservableDate.length > 0) {
		        			$("#noReserve").html("<div id='noReserve'></div>");
		        			reservable += "<table border='1' class='default'>";
		        			reservable += "	<tr>";
		        			reservable += "		<td colspan='10'>예약가능 일정</td>";	
		            		reservable += "	</tr>";	            	
		            		reservable += "	<tr>";            			
		            		reservable += "		<td>예약일</td>";	
		            		reservable += "		<td colspan='10'>"+date.format('YYYY-MM-DD')+"</td>";	
		            		reservable += "	</tr>";	            	
		            		reservable += "	<tr>";
		        			for(var i=0; i<reservableDate.length; i++){
		        				reservable += "	<td>예약가능 일정</td>";
		        				reservable += "	<td>"+reservableDate[i].reservable_hour+"시</td>";
		        				reservable += "	<td>케어 종목</td>";
		        				reservable += "	<td>"+reservableDate[i].reservable_major+"</td>";
		        				reservable += "	<td>수정 및 삭제하기</td>";
		        				reservable += "	<td>";
		        				reservable += "		<button type='button' onclick='javascript:reservableChoose(this.value, "+reservableDate[i].reservable_no+")' value='"+idValue+"_"+reservableDate[i].reservable_hour+"_"+reservableDate[i].reservable_major+"'>선택</button>";
		        				reservable += "	</td>";
		        				reservable += "</tr>";
		        				reservable += "<tr>";
		        			}
		        		}
		        		reservable += "</tr>";
		                reservable += "</table>";
		                $("#reservableSchedule").html(reservable);
		        	}
			        // reserved
		            if ($(".custom_calendar_table .reserved").hasClass("reserved")) {
		            	$(this).removeClass("reserved").addClass("select_day");
		            	var reserved = "";
		            	// 예약된 시간
		            	if (reservedDate.length > 0) {
		            		$("#noReserve").html("<div id='noReserve'></div>");
		            		reserved += "<table border='1' class='default'>";
		            		reserved += "	<tr>";
		        			reserved += "		<th colspan='10' style='text-align: center;'>예약된 일정</th>";	
		        			reserved += "	</tr>";	            	
		        			reserved += "	<tr>";            			
		        			reserved += "		<td>예약일</td>";	
		            		reserved += "		<td colspan='10'>"+date.format('YYYY-MM-DD')+"</td>";	
		            		reserved += "	</tr>";	            	
		            		reserved += "	<tr>";
		        			for(var i=0; i<reservedDate.length; i++){
		        				reserved += "	<td>예약된 일정</td>";
		        				reserved += "	<td>"+reservedDate[i].reservable_hour+"시</td>";
		       					reserved += "	<td>케어 종목</td>";
		       					reserved += "	<td>"+reservedDate[i].reservable_major+"</td>";
		       					reserved += "	<td>";
		       					reserved += "		<button type='button' onclick='javascript:reservedView(this.value, "+reservedDate[i].reservable_no+")' value='"+idValue+"_"+reservedDate[i].reservable_hour+"_"+reservedDate[i].reservable_major+"'>상세보기</button>";
		       					reserved += "	</td>";
		       					reserved += "</tr>";
		       					reserved += "<tr>";
		       				}
		           		}
		           		reserved += "</tr>";
		           		reserved += "</table>";
		               	$("#reservedSchedule").html(reserved);
						reservableChooseListDeleteAll();
					}
		            if ($(".custom_calendar_table .default").hasClass("default")) {
		           		$(this).removeClass("default").addClass("select_day");
		           	}
					// 취소 내역
					var cancel = "";
					if (reservationCancelDate.length > 0) {
							cancel += "<table border='1' class='default'>";
							cancel += "		<tr>";
							cancel += "			<td colspan='5'>예약취소내역</td>";	
							cancel += "		</tr>";	            	
							cancel += "		<tr>";            			
							cancel += "			<td colspan='2'>선택일</td>";	
		        			cancel += "			<td colspan='3'>"+date.format('YYYY-MM-DD')+"</td>";	
		        			cancel += "		</tr>";	            	
							cancel += "		<tr>";            			
							cancel += "			<td>예약시간</td>";	
		        			cancel += "			<td>케어종목</td>";	
		        			cancel += "			<td>취소한 닉네임</td>";	
		        			cancel += "			<td>취소시간</td>";	
		        			cancel += "			<td>취소사유</td>";		
		        			cancel += "		</tr>";	            	
						for(var i=0; i<reservationCancelDate.length; i++) {
							for(var j=0; j<cancelList.length; j++){
								if(reservationCancelDate[i].reserve_no == cancelList[j].reserve_no){
									cancel += "		<tr>"; 
									cancel += "			<td>"+reservationCancelDate[i].reserve_hour+"</td>";	
		        					cancel += "			<td>"+reservationCancelDate[i].major+"</td>";	
		        					cancel += "			<td>"+cancelList[j].user_nick+"</td>";	
		        					cancel += "			<td>"+cancelList[j].cancel_date.substr(0,16)+"</td>";	
		        					cancel += "			<td>"+cancelList[j].cancel_comment+"</td>";	
		        					cancel += "		</tr>";	            	
								}
							}
						}
		        			cancel += "</table>"; 
					}
		        	$('#reserveCancel').html(cancel);
				}
			});
		}
	}
	
	// reservableChoose(), reservableChooseListDelete(), reservableChooseDelete(), 
	// updateConfirm(), reservableChooseUpdate(), reservableChooseListDeleteAll() 에서 사용하는 예약가능 리스트
	var reservableChooseList = new Array();
	/** 예약 가능한 번호와 밸류(예약가능일시 종목) 파라미터로 받아와서 리스트에 저장 후 출력
		value = String 
		reserve_no = int
	*/
	// 예약가능일정 수정 삭제 선택내역 리셋 확인을 위한 boolean
	var reservableChooseReset = false;
	function reservableChoose(value, reserve_no) {
		
		var valueList = value.split('_', 3);
		var rcListLength = $("#rcList tr").length;
		
		var flag = true
		// 날짜 중복선택 방지
		for(var i=0; i<rcListLength; i++) {
			if(Number($('#rcList tr').eq(i).attr('id')) === reserve_no) {
				alert("이미 선택된 날짜 입니다.");
				flag = false;
				break;
			}
		}
		
		if(flag){
			reservableChooseList.push({
				reserve_no : reserve_no
				, reserve_date : valueList[0]
				, reserve_hour : valueList[1]
				, reserve_major : valueList[2]
			});
			var choose = "";
				choose += "<table border='1' class='default'>";
				choose += "		<tr>";
				choose += "			<td colspan='10'>시간수정 및 삭제 선택 내역</td>";	
				choose += "		</tr>";	            	
				choose += "		<tr>";            			
				choose += "			<td>예약일</td>";	
				choose += "			<td>시간</td>";	
				choose += "			<td>케어종목</td>";
				choose += "			<td>취소</td>";
				choose += "		</tr>";	            	
				choose += "		<tbody id='rcList'>";	            	
				for(var i=0; i<reservableChooseList.length; i++) {
					choose += "		<tr id='"+reservableChooseList[i].reserve_no+"'>";            			
					choose += "			<td>"+reservableChooseList[i].reserve_date+"</td>";	
					choose += "			<td id='"+reservableChooseList[i].reserve_date+"'>"+reservableChooseList[i].reserve_hour+"</td>";
					choose += "			<td>"+reservableChooseList[i].reserve_major+"</td>";	
					choose += "			<td><button type='button' value='"+reservableChooseList[i].reserve_no+"' onClick='reservableChooseListDelete(this.value)'>부분 선택 취소</button></td>";	
					choose += "		</tr>";	
				}
				choose += "		</tbody>";
				choose += "		<tr>";
				choose += "			<td>옵션</td>";
				choose += "			<td id='reservableDelete'>";
				choose += "				<button type='button' onClick='reservableChooseDelete()'>삭제</button>";
				choose += "			</td>";
				choose += "			<td id='updateConfirm'>";
				choose += "				<button type='button' onClick='reservableChooseUpdate()'>수정</button>";
				choose += "			</td>";
				choose += "			<td>";
				choose += "				<button type='button' onClick='reservableChooseListDeleteAll()'>전체 선택 취소</button>";
				choose += "			</td>";
				choose += "		</tr>";
				choose += "</table>";
			if(reservableChooseList.length === 0) {
				var empty = "<div id='reservableChoose'></div>"
				$('#reservableChoose').html(empty);
			}
			if(reservableChooseList.length !== 0) {
				$('#reservableChoose').html(choose);
				reservableChooseReset = true;
			}
		}
	}
	
	/** 예약번호로 선택된 내역에서 해당하는 배열 요소 지우기
		reserve_no = String 
	*/
	function reservableChooseListDelete(reserve_no) {
		console.log(reserve_no);
		var a = reservableChooseList.indexOf(reserve_no); // 출력 : 1

		reservableChooseList.splice(a, 1); // a부터 1만큼 삭제 ( 자기자신 )
		
		var choose = "";
		choose += "<table border='1' class='default'>";
		choose += "		<tr>";
		choose += "			<td colspan='10'>시간수정 및 삭제 선택 내역</td>";	
		choose += "		</tr>";	            	
		choose += "		<tr>";            			
		choose += "			<td>예약일</td>";	
		choose += "			<td>시간</td>";	
		choose += "			<td>케어종목</td>";
		choose += "			<td>취소</td>";
		choose += "		</tr>";	            	
		choose += "		<tbody id='rcList'>";	            	
		for(var i=0; i<reservableChooseList.length; i++) {
			choose += "		<tr id='"+reservableChooseList[i].reserve_no+"'>";            			
			choose += "			<td>"+reservableChooseList[i].reserve_date+"</td>";	
			choose += "			<td id='"+reservableChooseList[i].reserve_date+"'>"+reservableChooseList[i].reserve_hour+"</td>";	
			choose += "			<td>"+reservableChooseList[i].reserve_major+"</td>";	
			choose += "			<td><button type='button' value='"+reservableChooseList[i].reserve_no+"' onClick='reservableChooseListDelete(this.value)'>부분 선택 취소</button></td>";	
			choose += "		</tr>";	
		}
		choose += "		</tbody>";
		choose += "		<tr>";
		choose += "			<td>옵션</td>";
		choose += "			<td id='reservableDelete'>";
		choose += "				<button type='button' onClick='reservableChooseDelete()'>삭제</button>";
		choose += "			</td>";
		choose += "			<td id='updateConfirm'>";
		choose += "				<button type='button' onClick='reservableChooseUpdate()'>수정</button>";
		choose += "			</td>";
		choose += "			<td>";
		choose += "				<button type='button' onClick='reservableChooseListDeleteAll()'>전체 선택 취소</button>";
		choose += "			</td>";
		choose += "		</tr>";
		choose += "</table>";

		if(reservableChooseList.length === 0) {
			var empty = "<div id='reservableChoose'></div>"
			$('#reservableChoose').html(empty);
		}
		if(reservableChooseList.length !== 0) {
			$('#reservableChoose').html(choose);
		}
	}
	
	/** reservableChooseList 배열 비우기
	*/
	function reservableChooseListDeleteAll() {
		reservableChooseList.length = 0;
		var empty = "<div id='reservableChoose'></div>"
		$('#reservableChoose').html(empty);
		reservableChooseReset = false;
	}
	
	/** 선택된 예약가능 리스트의 시간값 종목값 수정가능하게 바꾸고 삭제버튼 없애기
	*/
	function reservableChooseUpdate() {
		alert('시간 수정 후 수정확인 버튼을 눌러주세요');
		// 종목값 selectList
		var select = "";
		for(var j=0; j<majorList.length; j++) {
			for(var i = 0; i<reservableChooseList.length; i++) {
				if(majorList[j].major_no !== 7) {
					if(reservableChooseList[i].reserve_major === majorList[j].major){
						select += "<option value='"+majorList[j].major+"' selected>"+majorList[j].major+"</option>"
						break;
					}
					if(reservableChooseList[i].reserve_major !== majorList[j].major){
						select +="<option value='"+majorList[j].major+"'>"+majorList[j].major+"</option>"
						break;
					}
					break;
				}
			}
		}
		
		for(var i = 0; i<reservableChooseList.length; i++) {
			$('#rcList tr').eq(i).find("td:eq(1)").html("<input type='text' value='"+reservableChooseList[i].reserve_hour+"'/>");
			$('#rcList tr').eq(i).find("td:eq(2)").html("<select id='majorList' name='majorList'>"+select+"</select>");
		}	
		$('#updateConfirm').html("<td><button type='button' onClick='updateConfirm()'>수정확인</button></td>");
		$('#reservableDelete').html("시간부분은 9시~20시 사이의 숫자만 입력해주세요.");
	}
	
	/** 수정된 Text를 기반으로 예약가능 정보 수정
	*/
	function updateConfirm() {
		// url 송신을 위한 boolean 
		var flag = false;
		// 잘못 입력된 부분 캐치를 위한 log
		var log = "";
		// 잘못 입력된 부분 원상 복구를 위한 i값 넘기기
		var num = 0;
		// 중복된 시간 부분을 위한 boolean
		var overlap = true;
		// 중복 부분 체크
		for(var i = 0; i<reservableChooseList.length; i++) {
			var dateVal = $('#rcList tr').eq(i).find("td:eq(0)").text(); // input hour값
			var hourVal = $('#rcList tr').eq(i).find("td:eq(1)").find("input").val(); // input hour값
			var ableDate = reservableList.filter(v => v.reservable_date === Number(dateVal));
			var noDate = reservedList.filter(v => v.reservable_date === Number(dateVal));
			var ableHour = ableDate.filter(v => v.reservable_hour === Number(hourVal));
			var noHour = noDate.filter(v => v.reservable_hour === Number(hourVal));
			if (ableHour.length !== 0 || noHour.length !== 0) {
				overlap = false;
				num += i;
				log += "예약일 :"+reservableChooseList[i].reserve_date+" 예약시간 : "+reservableChooseList[i].reserve_hour+"";
				break;
			}
		}
		for(var i = 0; i<reservableChooseList.length; i++) {
			var go = false;
			var dateVal = $('#rcList tr').eq(i).find("td:eq(0)").text(); // input hour값
			var hourVal = $('#rcList tr').eq(i).find("td:eq(1)").find("input").val(); // input hour값

			if (Number(hourVal) >= 9 && Number(hourVal) <= 20) { // 9시 ~20시 일때만 실행
				go = true;
			} else { // 9시~20시가 아닐 때 for문 중지후 오류난 부분값 저장
				go = false;
				flag = false;
				num += i;
				log += "예약일 :"+reservableChooseList[i].reserve_date+" 예약시간 : "+reservableChooseList[i].reserve_hour+"";
				break;
			}
			if(go) {
				var majorVal = $('#rcList tr').eq(i).find("td:eq(2)").find("select").val();
				if(i == 0) {
					var reserveNoArrange = ""+reservableChooseList[i].reserve_no+"";
					var hourArrange = ""+hourVal+"";
					var majorArrange = ""+majorVal+"";
					var result = "(변경전)Day:"+reservableChooseList[i].reserve_date+" Hour: "+reservableChooseList[i].reserve_hour+" Major: "+reservableChooseList[i].reserve_major+"";
						result += "-> (변경후)Day:"+reservableChooseList[i].reserve_date+" Hour: "+hourVal+" Major: "+majorVal+"";
				}
				if(i > 0) {
					reserveNoArrange += ","+reservableChooseList[i].reserve_no+"";
					hourArrange += ","+hourVal+"";
					majorArrange += ","+majorVal+"";
					result += "\n(변경전)Day:"+reservableChooseList[i].reserve_date+" Hour: "+reservableChooseList[i].reserve_hour+" Major: "+reservableChooseList[i].reserve_major+"";
					result += "-> (변경후)Day:"+reservableChooseList[i].reserve_date+" Hour: "+hourVal+" Major: "+majorVal+"";
				}
				flag = true;
			}
		}
		if(overlap == false) {
			alert("이미 예약된 시간이거나 이미 존재하는 시간입니다. \n 잘못입력한 곳 :"+log+"");
			$('#rcList tr').eq(num).find("td:eq(1)").html("<input type='text' value='"+reservableChooseList[num].reserve_hour+"'/>");
		}
		if(flag == false) {
			alert("9시~20시 사이의 숫자만 입력해주세요 \n 잘못입력한 곳 :"+log+"");
			$('#rcList tr').eq(num).find("td:eq(1)").html("<input type='text' value='"+reservableChooseList[num].reserve_hour+"'/>");
		}
		if(flag && overlap) {
			var defind = confirm(""+result+"\n위와같이 예약정보를 변경하시겠습니까?\n(수정완료창이 보일때까지 잠시 기다려주세요)");
			if (defind == false) {
				alert("예약정보가 수정되지 않았습니다.");
			}
			if (defind) {
				$.ajax({
  	    			url : "reservableChooseUpdate.do"
  	    			, contentType: 'application/json'
  	    			, method : "POST"
  	   				, data : JSON.stringify({
  	   					reserveNoArrange : reserveNoArrange
  	   					, hourArrange : hourArrange
  	   					, majorArrange : majorArrange
  	   				
  	    			})
  	    			, success : function(res) {
  	    				console.log(res);
  	    				alert(""+result+"\n예약정보가 위와같이 수정되었습니다.");
  	    				reservableChooseListDeleteAll();
  	    				location.reload();
  	   				}
  	   			});
			}
		}

	}

	/** 선택된 reserve_no로 데이터 삭제
	*/
	function reservableChooseDelete() {
		// reservable_no 저장
		for(var i = 0; i<reservableChooseList.length; i++) {
			if(i == 0) {
				var reserveNoArrange = ""+reservableChooseList[i].reserve_no+"";
				var result = ""+reservableChooseList[i].reserve_date+"_"+reservableChooseList[i].reserve_hour+"_"+reservableChooseList[i].reserve_major+"";
			}
			if(i > 0) {
				reserveNoArrange += ","+reservableChooseList[i].reserve_no+"";
				result += "\n"+reservableChooseList[i].reserve_date+"_"+reservableChooseList[i].reserve_hour+"_"+reservableChooseList[i].reserve_major+"";
			}
		}
		console.log(reserveNoArrange);
		console.log(result);		
		var defind = confirm(""+result+"\n해당하는 예약정보를 정말로 삭제하시겠습니까?\n(삭제완료창이 보일때까지 잠시 기다려주세요)");
		if (defind == false) {
			alert("예약정보가 삭제되지 않았습니다.");
		}
		if (defind) {
			$.ajax({
  	    		url : "reservableChooseDelete.do"
  	    		, method : "POST"
  	   			, data : ({
  	   				selectReserve : reserveNoArrange
  	    		})
  	    		, success : function(res) {
  	    			console.log(res);
  	    			alert(""+result+"\n예약정보가 삭제되었습니다.");
  	    			reservableChooseListDeleteAll();
  	    			location.reload();
  	   			}
  	   		});
		}
	}
	
	/** reservable_date를 받아서 예약가능일정 추
		reservable_date = int
	*/
	// 다른 일정 클릭시 일정추가표 삭제 확인을 위한 boolean
	var addReservalbeReset = false;
	// 버튼 클릭횟수 알기위한 변수
	var onclickCount = 0;
	function addReservable(reservable_date) {
		onclickCount++;
		// 추가되는 row
		var add = "";
			add += "<tr id='addReservableTr_"+onclickCount+"'>";
			add += "	<td>";
			add += "		<input type='text' value='(9시~20시 사이의 값을 입력해주세요)' onfocus=this.value=''>";
			add += "	</td>";
			add += "	<td>";
			add += "		<select id='addMajorList' name='addMajorList'>";
			for(var i=0; i<majorList.length; i++) {
					if(majorList[i].major_no !== 7) {
						add += "<option value='"+majorList[i].major+"'>"+majorList[i].major+"</option>"
					}
			}
			add += "		</select>";
			add += "	</td>";
			add += "	<td>";
			add += "		<button type='button' onclick='removeThis("+onclickCount+")'>지우기</button> ";
			add += "	</td>";
			add += "</tr>";
		// 추가되는 button (ajax 송신을 위한 onclick 버튼)
		var submit = "";
			submit += "<tr>";
			submit += "		<td colspan='3'>";
			submit += "			<button type='button' onclick='addReservableListSubmit()'>위의 일정 추가하기</button> ";
			submit += "		</td>";
			submit += "</tr>";
		if($('#addReservableSchedule tr td').length == 1){
			$('#addReservableSchedule').html(add);
			$('#addReservableSubmit').html(submit);			
			addReservalbeReset = true;
		} else {
			$('#addReservableSchedule').append(add);
			addReservalbeReset = true;
		}
	}
	
	/** 추가하기 버튼 누른 횟수를 변수로 받아 해당하는 row 삭제
		onclickCount = int
	*/
	function removeThis(onclickCount) {
		$('#addReservableTr_'+onclickCount+'').remove();
		if($('#addReservableSchedule tr').length == 0) {
			$('#addReservableSchedule').html("<tr><td colspan='3'>예약가능일정을 추가하여 주세요</td></tr>");
			$('#addReservableSubmit').html("");
		}
	}
	
	/** 추가된 일정과 기존 예약된 일정 데이터 값 비교하여 겹치지 않는 데이터 insert
	*/
	function addReservableListSubmit() {
		var trLength = $('#addReservableSchedule tr').length;
		var excute = false;
		var check = false;
		var go = true;
		var log = "";
		var num = 0;
		var result = "";
		var dateData = $('#selectDate tr').eq(0).find("td:eq(1)").attr("id");
		for(var i=0; i<trLength; i++) {
			var hourData = $('#addReservableSchedule tr').eq(i).find("td:eq(0)").find("input").val();
			var majorData = $('#addReservableSchedule tr').eq(i).find("td:eq(1)").find("select").val();
			if(Number(hourData) >= 9 && Number(hourData) <= 20) { // 9시 ~20시 일때만 실행
				excute = true;
			} else { // 9시~20시가 아닐 때 for문 중지후 오류난 부분값 저장
				excute = false;
				num += i+1;
				log += "예약가능시간 :"+hourData+" \n 케어종목 : "+majorData+"";
				break;
			}
			// 겹치는 시간 없는지 확인
			if(excute) {
				if(reservableList.length == 0){
					check = true;
				}
				for(var j=0; j<reservableList.length; j++) {
					if(Number(dateData) == reservableList[j].reservable_date) {
						if(Number(hourData) == reservableList[j].reservable_hour){
							check = false;
							go = false;
							num += i+1;
							log += "예약가능시간 :"+hourData+" \n 케어종목 : "+majorData+"";
							break;
						} 
					}
				}
				if(log == ""){
					check = true;
				}
				if(check) {
					for(var j=0; j<reservedList.length; j++) {					
						if(Number(dateData) == reservedList[j].reservable_date) {
							if(Number(hourData) == reservedList[j].reservable_hour){
								go = false;
								num += i+1;
								log += "예약가능시간 :"+hourData+" \n 케어종목 : "+majorData+"";
								break;
							}
						}
					}
					// false일때 for문 탈출
					if(go == false) {
						break;
					}
				}
				console.log(go);
				if(go) {
					$.ajax({
		  	    		url : "addReservableSchedule.do"
		  	  	    	, method : "POST"
		  	  	   		, data : ({
		  	  	   			gd_no : Number(gd_no)
		  	   				, reservable_date : Number(dateData)
		  	   				, reservable_hour : Number(hourData)
		  	   				, reservable_major : majorData
		  	    		})
		  	    		, success : function(res) {
		  	   			}
		  	    		, error : function(res) {
		  	    			alert("입력중 에러발생하였습니다.");
		  	    		}
		  	   		});
				}
			}
		}
		// 시간값 잘못 입력했을 때
		if(excute == false) {
			alert("9시~20시 사이의 숫자를 입력해주세요. \n 잘못 입력한 부분: "+num+"행 \n "+log+"");
		}
		// 중복시간이 있을 때
		if(check == false || go == false) {
			alert("이미 예약된 시간입니다. 확인 후 다른 시간을 입력해주세요. \n 잘못 입력한 부분: "+num+"행 \n "+log+"");
			console.log(check);
			console.log(go);
		}
		if(excute && check && go) {
			alert("정상적으로 일정추가 되었습니다.");
			location.reload();
		}
	}
	
	/** 예약된 예약가능번호, 예약일, 예약 시간, 예약종목으로 예약정보 상세보기 
		value(예약일_예약시간_예약종목) = String
		reserved_no = int
	*/
	function reservedView(value, reserved_no) {
		var reserveInfo = "";
		for(var i=0; i<reservationList.length; i++) {
			if(reservationList[i].reservable_no === reserved_no) {
				reserveInfo += "<table border='1' class='default'>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td colspan='4'>예약된 일정 상세보기</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>회원이름(닉네임)</td>";
				reserveInfo += "		<td colspan='3'>"+reservationList[i].user_name+"("+reservationList[i].user_nick+")</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>주문자(예약당시 입력된 이름)</td>";
				for(var j=0; j<gdPayHistoryList.length; j++) {
					if(reservationList[i].reserve_no === gdPayHistoryList[j].reserve_no) {
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].buyer_name+"</td>";
						reserveInfo += "</tr>";
						reserveInfo += "<tr>";
						reserveInfo += "	<td>연락처(이메일)</td>";
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].buyer_tel+"("+gdPayHistoryList[j].buyer_email+")</td>";
						reserveInfo += "</tr>";
						reserveInfo += "<tr>";
						reserveInfo += "	<td>출장요청주소</td>";
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].buyer_addr+"</td>";
						reserveInfo += "</tr>";
						reserveInfo += "<tr>";
						reserveInfo += "	<td>결제번호<button type='button' onclick='thisPaidRserve("+reservationList[i].reserve_no+","+gdPayHistoryList[j].merchant_uid+")'>함께 결제된 다른 예약 확인</button></td>";
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].merchant_uid+"</td>";
						reserveInfo += "</tr>";
						break;
					}
				}
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약일</td>";
				reserveInfo += "		<td colspan='3'>"+moment(String(reservationList[i].reserve_date)).format('YYYY-MM-DD')+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약시간</td>";
				reserveInfo += "		<td colspan='3'>"+reservationList[i].reserve_hour+"시</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약종목</td>";
				reserveInfo += "		<td colspan='3'>"+reservationList[i].major+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>특이사항 및 요청사항</td>";
				reserveInfo += "		<td colspan='3'>"+reservationList[i].reserve_etc+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tbody id='thisPaidRserve'>";
				reserveInfo += "	</tbody>";
				reserveInfo += "</table>";
				break;
			}
		}
		$('#reservedView').html(reserveInfo);
	}
	
	/** 결제 번호로 같이 결제한 예약리스트 불러오기
		reserve_no = Int
		merchant_uid = Int
	*/
	function thisPaidRserve(reserve_no, merchant_uid) {
		var paidOthers = "";
		for(var i=0; i<gdPayHistoryList.length; i++) {
			if(Number(gdPayHistoryList[i].merchant_uid) === merchant_uid) {
				if(gdPayHistoryList[i].reserve_no === reserve_no) {
					paidOthers += "<tr>";
					paidOthers += "		<td colspan='4'>함께 결제된 다른 예약</td>";
					paidOthers += "</tr>";
					paidOthers += "<tr>";
					paidOthers += "		<td>예약일</td>";
					paidOthers += "		<td>예약시간</td>";
					paidOthers += "		<td>예약종목</td>";
					paidOthers += "		<td>해당 날짜로 이동</td>";
					paidOthers += "</tr>";
					for(var j=0; j<reservationList.length; j++) {
						if(reservationList[j].reserve_no === reserve_no) {
							paidOthers += "<tr>";
							paidOthers += "		<td>"+reservationList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+reservationList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+reservationList[j].major+"</td>";
							paidOthers += "		<td>현재 선택된 예약건</td>";
							paidOthers += "</tr>";
						}
						if(reservationList[j].reserve_no !== reserve_no) {
							if(Number(reservationList[j].merchant_uid) === Number(merchant_uid)){
								paidOthers += "<tr>";
								paidOthers += "		<td>"+reservationList[j].reserve_date+"</td>";
								paidOthers += "		<td>"+reservationList[j].reserve_hour+"</td>";
								paidOthers += "		<td>"+reservationList[j].major+"</td>";
								paidOthers += "		<td><button type='button' onclick='move("+reservationList[j].reserve_date+")'>이동</button></td>";
								paidOthers += "</tr>";
							}
						}
					}
				}
			}
		}
		$('#thisPaidRserve').html(paidOthers);
	}
	
	/** id(년월일)로 달력클릭이벤트 실행
		date = Int
	*/
	function move (date) {
		var moveYear = String(date).substr(0,4);
		var moveMonth = String(date).slice(4,6);
		var moveDay = String(date).slice(6,8);
		var thisCalYearDate = $('#calendarForm table .cal_date tr th p').attr('id');
		var thisCalYear = thisCalYearDate.substr(0,4);
		var thisCalMonth = thisCalYearDate.slice(4,6);
		if(moveYear !== thisCalYear) {
			alert("같은 해의 예약만 이동가능합니다.")
		}
		if(moveYear === thisCalYear) {
			if(moveMonth === thisCalMonth) {
				$('#'+date+'').trigger('click');
				$('#reservedView').html('<div id="reservedView"></div>');
			}
			if(Number(moveMonth) > Number(thisCalMonth)) {
				var num = Number(moveMonth) - Number(thisCalMonth);
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + num, nowDate.getDate());
				calendarMaker($("#calendarForm"), nowDate);
				$('#'+date+'').trigger('click');
				$('#reservedView').html('<div id="reservedView"></div>');
			}
			if(Number(moveMonth) < Number(thisCalMonth)) {
				var num = Number(thisCalMonth) - Number(moveMonth);
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - num, nowDate.getDate());
				calendarMaker($("#calendarForm"), nowDate);
				$('#'+date+'').trigger('click');
				$('#reservedView').html('<div id="reservedView"></div>');
			}
		}
		
	}
	
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/reserveHeader.jsp"></jsp:include>
	<table class='default'>
		<tr><th style='font-size: 20pt; text-align: center;'>가드너 예약 확인 및 관리</th></tr>
	</table>
	<div>
		<!-- 상단 -->
		<div>
			<!-- 달력 -->
			<div>
				<div id="calendarForm"></div>
			</div>
			<!-- 예약된 내역 리스트 확인 -->
			<div>
				<div id="reservedSchedule"></div> 
			</div>
			<!-- 예약 가능한 일정 확인 -->
			<div>
				<div id="reservableSchedule"></div>
			</div>
			<!-- 결제취소 내역 확인 -->
			<div>
				<div id="reserveCancel"></div> 
			</div>
			<!-- 예약된 내역 상세보기 -->
			<div>
				<div id="reservedView"></div> 
			</div>
			<!-- 예약된 내역 상세보기 -->
			<div>
				<div id="noReserve"></div> 
			</div>
			<!-- 결제취소 내역 상세보기 -->
			<div>
				<div id="reserveCancelView"></div> 
			</div>
		</div>
		
		<!-- 하단 -->
		<div>
			<!-- 선택된 예약일정 확인 -->
			<div>
				<div id="reservableChoose"></div>
			</div>
			<!-- 예약 추가 하기 -->
			<div>
				<div>
					<table border="1" class='default'>
						<tr>
							<td colspan='3'>예약가능일 추가하기</td>
						</tr>
						<tbody  id="selectDate">
							<tr>
								<td>선택일</td>
								<td>달력에서 날짜를 선택해주세요</td>
							</tr>
						</tbody>
						<tbody id="addReservableSchedule">
						</tbody>
						<tbody id="addReservableSubmit">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>