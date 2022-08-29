<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>케어진행 완료 확인 페이지</title>
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
}

.custom_calendar_table thead.cal_date th button {
	font-size: 1.5rem;
	background: none;
	border: none;
}

.custom_calendar_table thead.cal_week th {
	background-color: #288CFF;
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

.custom_calendar_table tbody td.noCompletion {
	background-color: #FA5858;
	color: #fff;
}

.custom_calendar_table tbody td.completion {
	background-color: #81F781;
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
	
	// 가드너
	var urlParams = new URL(location.href).searchParams;
	var gd_no = urlParams.get('gd_no');
	var gd_name = "${gd.gd_name}";
	
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
	
	// 케어진행내역
	var completionList = new Array();
	<c:forEach items = "${completionList}" var = "c">
		completionList.push({
			reserve_no : ${c.reserve_no}
			, gd_no : ${c.gd_no}
			, user_no : ${c.user_no}
			, user_name : "${c.user_name}"
			, user_nick : "${c.user_nick}"
			, reserve_major : "${c.major}"
			, reserve_date : ${c.reserve_date}
			, reserve_hour : ${c.reserve_hour}
		});
	</c:forEach>
	
	// 케어미진행내역
	var noCompletionList = new Array();
	<c:forEach items = "${noCompletionList}" var = "nc">
		noCompletionList.push({
			reserve_no : ${nc.reserve_no}
			, gd_no : ${nc.gd_no}
			, user_no : ${nc.user_no}
			, user_name : "${nc.user_name}"
			, user_nick : "${nc.user_nick}"
			, reserve_major : "${nc.major}"
			, reserve_date : ${nc.reserve_date}
			, reserve_hour : ${nc.reserve_hour}
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
					"<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
				"</thead>" +
				// 달력검색을 위한 클래스 생성
				"<tbody id='custom_set_date'>" +
					"<tr>" +
						"<input type='hidden' class='reserved'>"+
						"<input type='hidden' class='completion'>"+
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
	    	for(var i=0; i<completionList.length; i++) {
	    		for(var j=0; j<tdId.length; j++) {
	    			if(completionList[i].reserve_date === Number($(tdId[j]).attr('id'))) {
	    				var thisId = $(tdId[j]).attr('id');
	    				$('#'+thisId+'').attr('class','completion');	    				
	    			}
	    		}
	   		}
	    	// 예약된 내역 date class 값 변경
	    	for(var x=0; x<noCompletionList.length; x++) {
	    		for(var y=0; y<tdId.length; y++) {
	    			// 현재 id 값
	    			var thisId = $(tdId[y]).attr('id');
	    			// 현재 class값
	    			var thisClass = $('#'+thisId+'').attr('class');
	    			if(thisClass !== 'reservable'){
	    				if(noCompletionList[x].reserve_date === Number(thisId)) {
	    					$('#'+thisId+'').attr('class','noCompletion');	    				
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
				if(thisClass !== 'completion' && thisClass !== 'noCompletion'){
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
				viewReserveInfoDelete() // 상세보기 내역 삭제
				// 클릭한 id값
				var idValue = $(this).attr('id');			
		   		// 모맨트 js 활용 하여 데이터 포맷 변경
		   		var date = moment(idValue); 
				// 클릭한 td id값에 맞는 예약가능 일자 true 처리
				function cDate(completionList) {
					if(completionList.reserve_date === Number(idValue)) {
						return true;
					}
				}
				// 클릭한 td id값에 맞는 예약된 일자 true 처리
				function ncDate(noCompletionList) {
					if(noCompletionList.reserve_date === Number(idValue)) {
						return true;
					}
				}
				// true인 객체 배열화
		       	var completionDate = completionList.filter(cDate); // 케어진행 완료
				var noCompletionDate = noCompletionList.filter(ncDate); // 케어미진행
					
		        // select_day 클래스 삭제
				$(".custom_calendar_table .select_day").removeClass("select_day");
		    		
				// 삭제 후 예약데이터와 비교하여 다시 클래스 변경       	
				classChange();
				
				// default
				if ($('#'+idValue+'').attr('class') === 'default') {

		        }
			    // select_day
		        if ($(".custom_calendar_table .select_day").hasClass("select_day")) {
		          	$(this).removeClass("select_day").addClass("select_day");
		        }
			    // completion
		      	if ($(".custom_calendar_table .completion").hasClass("completion")) {
		       		$(this).removeClass("completion").addClass("select_day");
		        }
			    // noCompletion
		        if ($(".custom_calendar_table .noCompletion").hasClass("noCompletion")) {
		          	$(this).removeClass("noCompletion").addClass("select_day");
	            	var noCompletion = "";
	            	// 예약된 시간
	            	if (noCompletionDate.length > 0) {
	            		$("#noReserve").html("<div id='noReserve'></div>");
	            		noCompletion += "<table border='1'>";
	            		noCompletion += "	<tr>";
	            		noCompletion += "		<td colspan='10'>케어 미진행 일정</td>";	
	            		noCompletion += "	</tr>";	            	
	            		noCompletion += "	<tr>";            			
	            		noCompletion += "		<td>예약일</td>";	
	            		noCompletion += "		<td colspan='10'>"+date.format('YYYY-MM-DD')+"</td>";	
	            		noCompletion += "	</tr>";	            	
	            		noCompletion += "	<tr>";
	        			for(var i=0; i<noCompletionDate.length; i++){
	        				noCompletion += "	<td>예약된 일정</td>";
	        				noCompletion += "	<td>"+noCompletionDate[i].reserve_hour+"시</td>";
	        				noCompletion += "	<td>케어 종목</td>";
	        				noCompletion += "	<td>"+noCompletionDate[i].reserve_major+"</td>";
	       					noCompletion += "	<td>";
	       					noCompletion += "		<button type='button' onclick='viewReserveInfo("+noCompletionDate[i].reserve_no+","+idValue+","+noCompletionDate[i].reserve_hour+",\""+noCompletionDate[i].reserve_major+"\")'>예약상세보기</button>";
	       					noCompletion += "	</td>";
	       					noCompletion += "	<td>";
	       					noCompletion += "		<button type='button' onclick='insertCompletionForm("+noCompletionDate[i].reserve_no+","+idValue+","+noCompletionDate[i].reserve_hour+",\""+noCompletionDate[i].reserve_major+"\")'>예약 진행 완료 내역 입력하기</button>";
	       					noCompletion += "	</td>";
	       					noCompletion += "</tr>";
	       					noCompletion += "<tr>";
	       				}
	           		}
	            	noCompletion += "</tr>";
	           		noCompletion += "</table>";
	               	$("#noCompletion").html(noCompletion);
				}
		        if ($(".custom_calendar_table .default").hasClass("default")) {
		           	$(this).removeClass("default").addClass("select_day");
		        }
			});
		}
	}
	
	/** 케어진행한 예약 정보 확인
		thisDate = Int
		reserve_hour = Int
		reserve_no = Int
		reserve_major = String
	*/
	function viewReserveInfo(reserve_no, thisDate, reserve_hour, reserve_major) {
		var reserveInfo = "";
		for(var i=0; i<noCompletionList.length; i++) {
			console.log(noCompletionList[i].reserve_no);
			if(noCompletionList[i].reserve_no === reserve_no) {
				reserveInfo += "<table border='1'>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td colspan='4'>예약된 일정 상세보기</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>회원이름(닉네임)</td>";
				reserveInfo += "		<td colspan='3'>"+noCompletionList[i].user_name+"("+noCompletionList[i].user_nick+")</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>주문자(예약당시 입력된 이름)</td>";
				for(var j=0; j<gdPayHistoryList.length; j++) {
					if(noCompletionList[i].reserve_no === gdPayHistoryList[j].reserve_no) {
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
						reserveInfo += "	<td>결제번호<button id='paidReserve' type='button' onclick='thisPaidRserve("+noCompletionList[i].reserve_no+","+gdPayHistoryList[j].merchant_uid+")'>함께 결제된 다른 예약 확인</button></td>";
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].merchant_uid+"</td>";
						reserveInfo += "</tr>";
						break;
					}
				}
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약일</td>";
				reserveInfo += "		<td colspan='3'>"+moment(String(noCompletionList[i].reserve_date)).format('YYYY-MM-DD')+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약시간</td>";
				reserveInfo += "		<td colspan='3'>"+noCompletionList[i].reserve_hour+"시</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약종목</td>";
				reserveInfo += "		<td colspan='3'>"+noCompletionList[i].reserve_major+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tbody id='thisPaidRserve'>";
				reserveInfo += "	</tbody>";
				reserveInfo += "</table>";
				break;
			}
		}
		$('#viewReserveInfo').html(reserveInfo);
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
					for(var j=0; j<noCompletionList.length; j++) {
						if(noCompletionList[j].reserve_no === reserve_no) {
							paidOthers += "<tr>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_major+"</td>";
							paidOthers += "		<td>현재 선택된 예약건</td>";
							paidOthers += "</tr>";
						}
						if(noCompletionList[j].reserve_no !== reserve_no) {
							paidOthers += "<tr>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_major+"</td>";
							paidOthers += "		<td><button type='button' onclick='move("+noCompletionList[j].reserve_date+")'>이동</button></td>";
							paidOthers += "</tr>";
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
		// 
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
			}
			if(Number(moveMonth) > Number(thisCalMonth)) {
				var num = Number(moveMonth) - Number(thisCalMonth);
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + num, nowDate.getDate());
				calendarMaker($("#calendarForm"), nowDate);
				$('#'+date+'').trigger('click');
			}
			if(Number(moveMonth) < Number(thisCalMonth)) {
				var num = Number(thisCalMonth) - Number(moveMonth);
				nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - num, nowDate.getDate());
				calendarMaker($("#calendarForm"), nowDate);
				$('#'+date+'').trigger('click');
			}
		}
		
	}
	
	/** 상세보기 페이지 지우기
	*/
	function viewReserveInfoDelete() {
		$('#viewReserveInfo').html('<div id="viewReserveInfo"></div>');
	}
	
	/** 케어 미진행 페이지 지우기
	*/
	function noCompletionDelete() {
		$('#noCompletion').html('<div id="noCompletion"></div>');
	}
	
	/** 예약확인 내역 입력
		reserve_no = Int
		date = Int
		reserve_hour = int
		reserve_major = String
	*/
	function insertCompletionForm(reserve_no, date, reserve_hour, reserve_major) {
		viewReserveInfoDelete();
		noCompletionDelete();
		var insertCompletion = "";
			insertCompletion += "<table border='1'>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<th colspan='4'>예약 완료 확인 입력</th>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td colspan='4'>예약 정보</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "		<td>예약자</td>";
		for(var j=0; j<gdPayHistoryList.length; j++) {
			if(reserve_no === gdPayHistoryList[j].reserve_no) {
				insertCompletion += "	<td colspan='4'>"+gdPayHistoryList[j].buyer_name+"</td>";
				insertCompletion += "</tr>";
				insertCompletion += "<tr>";
				insertCompletion += "	<td>연락처(이메일)</td>";
				insertCompletion += "	<td colspan='4'>"+gdPayHistoryList[j].buyer_tel+"("+gdPayHistoryList[j].buyer_email+")</td>";
				insertCompletion += "</tr>";
				insertCompletion += "<tr>";
				insertCompletion += "	<td>출장요청주소</td>";
				insertCompletion += "	<td colspan='4'>"+gdPayHistoryList[j].buyer_addr+"</td>";
				insertCompletion += "</tr>";
				insertCompletion += "<tr>";
				break;
			}
		}
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>예약일</td>";
			insertCompletion += "		<td colspan='4'>"+date+"</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>예약시간</td>";
			insertCompletion += "		<td>"+reserve_hour+"</td>";
			insertCompletion += "		<td>예약종목</td>";
			insertCompletion += "		<td>"+reserve_major+"</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>케어 진행가드너</td>";
			insertCompletion += "		<td colspan='4'>"+gd_name+"</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>케어 진행 내용</td>";
			insertCompletion += "		<td colspan='3'><p><textarea cols='55' rows='10'></textarea></p></td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td rowspan='4'>첨부파일</td>";
			insertCompletion += "		<td colspan='3'>최소 한 개 이상의 파일을 업로드해주세요 (3개까지 업로드 가능합니다.)</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td colspan='4'><input type='file' id='file' multiple></td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td colspan='4'><input type='submit' onclick='insertCompletion();' value='저장'></td>";
			insertCompletion += "	</tr>";
			insertCompletion += "</table>";
		$('#insertCompletion').html(insertCompletion);
	}
	function insertCompletion() {
		var fileInput = ('#file').files // fileClass 선택
		console.log(fileInput[0]);
		console.log(fileInput[1]);
		if( fileInput.length > 0 ){
			for( var i = 0; i < fileInput.length; i++ ){
				console.log(fileInput.files[i].name); // 파일명 출력
			}
		}
	}
</script>
</head>
<body>
	<h1>예약 진행 완료</h1>
	<div>
		<!-- 상단 -->
		<div>
			<!-- 달력 -->
			<div>
				<div id="calendarForm"></div>
			</div>
			<!-- 케어 미진행 -->
			<div>
				<div id="noCompletion"></div>
			</div>
			<!-- 케어진행 -->
			<div>
				<div id="completion"></div>
			</div>
		</div>
		
		<!-- 하단 -->
		<div>
			<!-- 예약상세보기 -->
			<div>
				<div id="viewReserveInfo"></div>
			</div>
			<!-- 예약입력 -->
			<div>
				<form id="frm" method="post" onsubmit="return false;" enctype="multipart/form-data" >
					<div id="insertCompletion"></div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>