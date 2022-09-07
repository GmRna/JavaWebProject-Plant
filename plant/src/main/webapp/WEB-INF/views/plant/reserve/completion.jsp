<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/reserveHeader.jsp" %>
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

.custom_calendar_table tbody td.noCompletion {
	background-color: #ff255d;
	color: #fff;
}

.custom_calendar_table tbody td.completion {
	background-color: #73d5ac;
	color: #000000;
}

.set {
	background-color: #288CFF;
	color: #fff;
}

.file-list {
    height: 200px;
    overflow: auto;
    border: 1px solid #989898;
    padding: 10px;
}
.file-list .filebox p {
    font-size: 14px;
    margin-top: 10px;
    display: inline-block;
}
.file-list .filebox .delete button{
    color: #ff5353;
    margin-left: 5px;
    width: 50px;
    height: 40px;
}

/* The Modal (background) */    
.searchModal {       
	display: none; /* Hidden by default */        
	position: fixed; /* Stay in place */        
	z-index: 10; /* Sit on top */       
	left: 0;        
	top: 0;        
	width: 100%; /* Full width */       
	height: 100%; /* Full height */        
	overflow: auto; /* Enable scroll if needed */        
	background-color: rgb(0,0,0); /* Fallback color */        
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */ 
}     
/* Modal Content/Box */    
.search-modal-content {        
	background-color: #fefefe;        
	margin: 15% auto; /* 15% from the top and centered */       
	padding: 20px;        
	border: 1px solid #888;        
	width: 70%; /* Could be more or less, depending on screen size */ 
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
	var contextPath = "<%=request.getContextPath()%>";
	
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
			, reserve_review : ${c.reserve_review}
			, completion_date : "${c.completion_date}"
			, completion_comment : "${c.completion_comment}"
			, completion_picorg1 : "${c.completion_picorg1}"
			, completion_picreal1 : "${c.completion_picreal1}"
			, completion_picorg2 : "${c.completion_picorg2}"
			, completion_picreal2 : "${c.completion_picreal2}"
			, completion_picorg3 : "${c.completion_picorg3}"
			, completion_picreal3 : "${c.completion_picreal3}"
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
	
	// 리뷰
	var reviewList = new Array();
	<c:forEach items = "${reviewList}" var = "rv">
		reviewList.push({
			reserve_no : ${rv.reserve_no}
			, gd_no : ${rv.gd_no}
			, user_no : ${rv.user_no}
			, review_no : ${rv.review_no}
			, review_date : "${rv.review_date}"
			, review : "${rv.review}"
			, review_answer : "${rv.review_answer}"
			, review_answerdate : "${rv.review_answerdate}"
			, star : ${rv.star}
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
        			"<th colspan='7'>좌우 화살표로 다음(이전월)로 이동 가능하며 초록색은 진행완료된 날을 빨간색은 진료되지 않은 날을 나타냅니다.</th>" +
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
				if (reset == false) {
					flag = confirm("날짜 클릭시 작성된 내용이 모두 초기화 됩니다. 초기화 하시겠습니까?");
				}
				if(flag) {
					insertCompletionDelete(); // 예약 완료 확인 입력 삭제
					reset = true;
					viewDelete() // 상세보기 내역 삭제
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
		            var completion = "";
		            // 진행완료된 예약
		            if (completionDate.length > 0) {
		            	completion += "<table border='1' class='default'>";
		            	completion += "	<tr>";
		            	completion += "		<td colspan='10'>케어 진행완료</td>";	
		           		completion += "	</tr>";	            	
		           		completion += "	<tr>";            			
		           		completion += "		<td>예약일</td>";	
		           		completion += "		<td colspan='10'>"+date.format('YYYY-MM-DD')+"</td>";	
		           		completion += "	</tr>";	            	
		           		completion += "	<tr>";
		        		for(var i=0; i<completionDate.length; i++){
		        			completion += "	<td>예약된 일정</td>";
		       				completion += "	<td>"+completionDate[i].reserve_hour+"시</td>";
		       				completion += "	<td>케어 종목</td>";
		       				completion += "	<td>"+completionDate[i].reserve_major+"</td>";
		       				completion += "	<td>";
		       				completion += "		<button type='button' onclick='viewCompletion("+completionDate[i].reserve_no+")'>예약진행내역상세보기</button>";
		       				if(completionDate[i].reserve_review === 1){
		       					completion += "	<button type='button' onclick='viewReview("+completionDate[i].reserve_no+")'>케어리뷰확인</button>";
		       				}
		       				completion += "	</td>";
		       				completion += "</tr>";
		       				completion += "<tr>";
		     			}
		           	}
		            // 진행완료 안된 예약
		            if (noCompletionDate.length > 0) {
		            	completion += "<table border='1' class='default'>";
		            	completion += "	<tr>";
		            	completion += "		<td colspan='10'>케어 미진행 일정</td>";	
		           		completion += "	</tr>";	            	
		           		completion += "	<tr>";            			 
		           		completion += "		<td>예약일</td>";	
		           		completion += "		<td colspan='10'>"+date.format('YYYY-MM-DD')+"</td>";	
		           		completion += "	</tr>";	            	
		           		completion += "	<tr>";
		        		for(var i=0; i<noCompletionDate.length; i++){
		        			completion += "	<td>예약된 일정</td>";
		       				completion += "	<td>"+noCompletionDate[i].reserve_hour+"시</td>";
		       				completion += "	<td>케어 종목</td>";
		       				completion += "	<td>"+noCompletionDate[i].reserve_major+"</td>";
		       				completion += "	<td>";
		       				completion += "		<button type='button' onclick='viewReserveInfo("+noCompletionDate[i].reserve_no+","+idValue+","+noCompletionDate[i].reserve_hour+",\""+noCompletionDate[i].reserve_major+"\")'>예약상세보기</button>";
		       				completion += "	</td>";
		       				completion += "	<td>";
		       				completion += "		<button type='button' onclick='insertCompletionForm("+noCompletionDate[i].reserve_no+","+idValue+","+noCompletionDate[i].reserve_hour+",\""+noCompletionDate[i].reserve_major+"\")'>예약 진행 완료 내역 입력하기</button>";
		       				completion += "	</td>";
		       				completion += "</tr>";
		       				completion += "<tr>";
		     			}
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
					}
			        if ($(".custom_calendar_table .default").hasClass("default")) {
			           	$(this).removeClass("default").addClass("select_day");
			        }
		            completion += "</tr>";
		            completion += "</table>";
		            $("#noCompletion").html(completion);
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
				reserveInfo += "<table border='1' class='default'>";
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
		$('#view').html(reserveInfo);
	}
	
	/** 케어진행한 예약 정보 확인
		reserve_no = Int
	*/
	function viewCompletion(reserve_no) {
		var reserveInfo = "";
		for(var i=0; i<completionList.length; i++) {
			console.log(completionList[i].reserve_no);
			if(completionList[i].reserve_no === reserve_no) {
				reserveInfo += "<table border='1' class='default'>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td colspan='4'>예약된 일정 상세보기</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>회원이름(닉네임)</td>";
				reserveInfo += "		<td colspan='3'>"+completionList[i].user_name+"("+completionList[i].user_nick+")</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>주문자(예약당시 입력된 이름)</td>";
				for(var j=0; j<gdPayHistoryList.length; j++) {
					if(completionList[i].reserve_no === gdPayHistoryList[j].reserve_no) {
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
						reserveInfo += "	<td>결제번호<button id='paidReserve' type='button' onclick='thisPaidRserve("+completionList[i].reserve_no+","+gdPayHistoryList[j].merchant_uid+")'>함께 결제된 다른 예약 확인</button></td>";
						reserveInfo += "	<td colspan='3'>"+gdPayHistoryList[j].merchant_uid+"</td>";
						reserveInfo += "</tr>";
						break;
					}
				}
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약일</td>";
				reserveInfo += "		<td colspan='3'>"+moment(String(completionList[i].reserve_date)).format('YYYY-MM-DD')+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약시간</td>";
				reserveInfo += "		<td colspan='3'>"+completionList[i].reserve_hour+"시</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>예약종목</td>";
				reserveInfo += "		<td colspan='3'>"+completionList[i].reserve_major+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tbody id='thisPaidRserve'>";
				reserveInfo += "	</tbody>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>케어진행 사항</td>";
				reserveInfo += "		<td colspan='3'>"+completionList[i].completion_comment+"</td>";
				reserveInfo += "	</tr>";
				reserveInfo += "	<tr>";
				reserveInfo += "		<td>케어진행사진</td>";
				if(completionList[i].completion_picorg1 !== null && completionList[i].completion_picorg1 !== '') {
					reserveInfo += "		<td>";
					reserveInfo += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal1+"' style='width:90px; height:90px;' >";
					reserveInfo += "			<p id='name' class='name'>"+completionList[i].completion_picorg1+"</p>";
					reserveInfo += "		</td>";
				}
				if(completionList[i].completion_picorg2 !== null && completionList[i].completion_picorg2 !== '') {
					reserveInfo += "		<td>";
					reserveInfo += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal2+"' style='width:90px; height:90px;' >";
					reserveInfo += "			<p id='name' class='name'>"+completionList[i].completion_picorg2+"</p>";
					reserveInfo += "		</td>";
				}
				if(completionList[i].completion_picorg3 !== null && completionList[i].completion_picorg3 !== '') {
					reserveInfo += "		<td>";
					reserveInfo += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal3+"' style='width:90px; height:90px;' >";
					reserveInfo += "			<p id='name' class='name'>"+completionList[i].completion_picorg3+"</p>";
					reserveInfo += "		</td>";
				}
				reserveInfo += "	</tr>";
				reserveInfo += "</table>";
				break;
			}
		}
		$('#view').html(reserveInfo);
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
							paidOthers += "		<td>"+noCompletionList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+noCompletionList[j].reserve_major+"</td>";
							paidOthers += "		<td><button type='button' onclick='move("+noCompletionList[j].reserve_date+")'>이동</button></td>";
							paidOthers += "</tr>";
							
						}
					}
					for(var j=0; j<completionList.length; j++) {
						if(completionList[j].reserve_no === reserve_no) {
							paidOthers += "<tr>";
							paidOthers += "		<td>"+completionList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+completionList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+completionList[j].reserve_major+"</td>";
							paidOthers += "		<td>현재 선택된 예약건</td>";
							paidOthers += "</tr>";
						}
						if(completionList[j].reserve_no !== reserve_no) {
							paidOthers += "<tr>";
							paidOthers += "		<td>"+completionList[j].reserve_date+"</td>";
							paidOthers += "		<td>"+completionList[j].reserve_hour+"</td>";
							paidOthers += "		<td>"+completionList[j].reserve_major+"</td>";
							paidOthers += "		<td><button type='button' onclick='move("+completionList[j].reserve_date+")'>이동</button></td>";
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
	function viewDelete() {
		$('#view').html('<div id="view"></div>');
	}
	
	/** 예약완료 확인 입력 페이지 지우기
	*/
	// 
	// 삭제 확인을 위한 boolean
	var flag = true;
	function insertCompletionDelete() {
		$('#insertCompletion').html('<div id="insertCompletion"></div>');
		reset = true;
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
	// 예약진행완료 내역 입력을 위한 boolean
	var reset = true;
	function insertCompletionForm(reserve_no, date, reserve_hour, reserve_major) {
		reset = false;
		viewDelete();
		noCompletionDelete();
		var insertCompletion = "";
			insertCompletion += "<table border='1' class='default'>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<th colspan='4'>예약 완료 확인 입력<button type='button' onclick='insertCompletionDelete()'>입력창 닫기</button></th>";
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
			insertCompletion += "		<td>첨부파일추가</td>";			
			insertCompletion += "		<td><input type='file' onchange='addFile(this);' multiple /></td>";			
			insertCompletion += "		<td colspan='2'>최소 한 개 이상의 파일을 업로드해주세요 <br> (3개까지 업로드 가능합니다.)</td>";
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>케어 진행 내용</td>";
			insertCompletion += "		<td colspan='3'>";
			insertCompletion += "			<textarea id='completion_comment' name='completion_comment' cols='55' rows='10'></textarea>";			
			insertCompletion += "		</td>";			
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td>첨부된 파일</td>";
			insertCompletion += "		<td colspan='3'>";
			insertCompletion += "			<div class='file-list'></div>";			
			insertCompletion += "		</td>";			
			insertCompletion += "	</tr>";
			insertCompletion += "	<tr>";
			insertCompletion += "		<td colspan='4'>";
			insertCompletion += "			<input type='submit' onclick='insertCompletion();' value='저장'>";			
			insertCompletion += "			<input type='hidden' id='reserve_no' name='reserve_no' value='"+reserve_no+"'>";
			insertCompletion += "			<input type='hidden' id='gd_no' name='gd_no' value='"+Number(gd_no)+"'>";
		for (var i = 0; i<gdPayHistoryList.length; i++) {
			if(gdPayHistoryList[i].reserve_no === reserve_no) {
			insertCompletion += "			<input type='hidden' id='user_no' name='user_no' value='"+gdPayHistoryList[i].user_no+"'>";
			break;
			}
		}
			insertCompletion += "		저장에 다소 시간이 걸릴 수 있으니 완료창이 뜰 때 까지 기다려주십시오. </td>";
			insertCompletion += "	</tr>";
			insertCompletion += "</table>";
		$('#insertCompletion').html(insertCompletion);
	}
	
	// 첨부파일 추가
	var fileNo = 0;
	var filesArr = new Array();

	/** 첨부파일 추가
	*/
	function addFile(obj){
	    var maxFileCnt = 3;   // 첨부파일 최대 개수
	    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
	    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
	    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
		
	    
	    // 첨부파일 개수 확인
	    if (curFileCnt > remainFileCnt) {
	        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
	    } 
	 
	    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {
	    	
	        const file = obj.files[i];
	        
	        // 첨부파일 검증
	        if (validation(file)) {
	            // 파일 배열에 담기
	            var reader = new FileReader();
	            reader.onload = function (event) {
	            	// 파일 이미지 src 담기
	            	var imgsrc = event.target.result;
					
					let htmlData = '';
					htmlData += '<div id="file' + fileNo + '" class="filebox">';
		            htmlData += '	<img src="'+imgsrc+'" style="width:90px; height=90px;" >';
		            htmlData += '   <p id="name" class="name">' + file.name + '</p>';
		            htmlData += '   <a onclick="deleteFile(' + fileNo + ');"><button type="button">삭제</button></a>';
		            htmlData += '</div>';
		            $('.file-list').append(htmlData);
		            fileNo++;
					
					filesArr.push(file);
	            };
	            reader.readAsDataURL(file);
	            
	        } else {
	            continue;
	        }
	    }
	    // 초기화
	    document.querySelector("input[type=file]").value = "";
	}

	/** 첨부파일 검증
	*/
	function validation(obj){
	    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
	    if (obj.name.length > 100) {
	        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
	        return false;
	    } else if (obj.size > (100 * 1024 * 1024)) {
	        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
	        return false;
	    } else if (obj.name.lastIndexOf('.') == -1) {
	        alert("확장자가 없는 파일은 제외되었습니다.");
	        return false;
	    } else if (!fileTypes.includes(obj.type)) {
	        alert("첨부가 불가능한 파일은 제외되었습니다.");
	        return false;
	    } else {
	        return true;
	    }
	}

	/** 첨부파일 삭제
	*/
	function deleteFile(num) {
	    document.querySelector("#file" + num).remove();
	    filesArr[num].is_delete = true;
	}

	/** 완료내역 비동기송신하여 내역 입력
		reserve_no = int
		date = int
		reserve_hour = int
		reserve_major = int
	*/
	function insertCompletion() {
	    // 첨부파일이 없을 때 
		var form = $(".filebox").val();
	    if (form == null) {
	    	alert("최소 케어진행사진을 1장이상 등록해 주세요");
	    	return fales;
	    	
	    } else {
	    	var form = $('#frm')[0];
	    	var formData = new FormData(form);
	    	for (var i = 0; i < filesArr.length; i++) {
				if (!filesArr[i].is_delete) {
					formData.append("file", filesArr[i]); // 삭제되지 않은 파일만 폼데이터에 담기
				}
			}
	    	    	    	    
			$.ajax({
				method: 'POST'
				, url: 'completion.do'
				, dataType: 'json'
				, data: formData
				, async: true
				, contentType: false
				, processData: false
				, success: function () {
					alert("예약확인내역입력이 완료되었습니다.");
					location.reload();
				}
				, error: function (xhr, desc, err) { 
					alert('에러가 발생 하였습니다.');
					console.log(err);
					return;
				}
			});
	    }
	}
	
	/** 리뷰 확인하기
		reserve_no = Int
	*/
	function viewReview(reserve_no) {
		var reviewForm = "";
			reviewForm += "<div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>케어진행 정보</span>";
			reviewForm += "	</div>";
		for(var i=0; i<completionList.length; i++) {
			if(completionList[i].reserve_no == reserve_no){
				reviewForm += "	<div>";
				reviewForm += "		<span>예약자</span>";
				reviewForm += "		<span>"+completionList[i].user_nick.replace(/(?<=.{1})./gi, "*");+"</span>";
				reviewForm += "	</div>";
				break;
			}	
		}
			reviewForm += "	<div>";
			reviewForm += "		<span>Review</span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
		for(var i=0; i<reviewList.length; i++){
			if(reviewList[i].reserve_no === reserve_no){
				reviewForm += "		<span><textarea id='review' name='review' cols='55' rows='10' readonly>"+reviewList[i].review+"</textarea></span>";
				reviewForm += "	</div>";
				reviewForm += "	<div>";
				reviewForm += "		<span>Star</span>";
				reviewForm += "	</div>";
				reviewForm += "	<div>";
				reviewForm += "		<span>";
				reviewForm += "			<form>";
				if(0 <= reviewList[i].star && reviewList[i].star < 2) {
					reviewForm += "				<input type='radio' name='star' value='1' onclick='return(false)' checked='checked'/>1점";
					reviewForm += "				<input type='radio' name='star' value='2' onclick='return(false)'/>2점";
					reviewForm += "				<input type='radio' name='star' value='3' onclick='return(false)'/>3점";
					reviewForm += "				<input type='radio' name='star' value='4' onclick='return(false)'/>4점";
					reviewForm += "				<input type='radio' name='star' value='5' onclick='return(false)'/>5점";
				}
				if(2 <= reviewList[i].star && reviewList[i].star < 3) {
					reviewForm += "				<input type='radio' name='star' value='1' onclick='return(false)'/>1점";
					reviewForm += "				<input type='radio' name='star' value='2' onclick='return(false)' checked='checked'/>2점";
					reviewForm += "				<input type='radio' name='star' value='3' onclick='return(false)'/>3점";
					reviewForm += "				<input type='radio' name='star' value='4' onclick='return(false)'/>4점";
					reviewForm += "				<input type='radio' name='star' value='5' onclick='return(false)'/>5점";
				}
				if(3 <= reviewList[i].star && reviewList[i].star < 4) {
					reviewForm += "				<input type='radio' name='star' value='1' onclick='return(false)'/>1점";
					reviewForm += "				<input type='radio' name='star' value='2' onclick='return(false)'/>2점";
					reviewForm += "				<input type='radio' name='star' value='3' onclick='return(false)' checked='checked'/>3점";
					reviewForm += "				<input type='radio' name='star' value='4' onclick='return(false)'/>4점";
					reviewForm += "				<input type='radio' name='star' value='5' onclick='return(false)'/>5점";
				}
				if(4 <= reviewList[i].star && reviewList[i].star < 5) {
					reviewForm += "				<input type='radio' name='star' value='1' onclick='return(false)'/>1점";
					reviewForm += "				<input type='radio' name='star' value='2' onclick='return(false)'/>2점";
					reviewForm += "				<input type='radio' name='star' value='3' onclick='return(false)'/>3점";
					reviewForm += "				<input type='radio' name='star' value='4' onclick='return(false)' checked='checked'/>4점";
					reviewForm += "				<input type='radio' name='star' value='5' onclick='return(false)'/>5점";
				}
				if(5 <= reviewList[i].star && reviewList[i].star < 10) {
					reviewForm += "				<input type='radio' name='star' value='1' onclick='return(false)'/>1점";
					reviewForm += "				<input type='radio' name='star' value='2' onclick='return(false)'/>2점";
					reviewForm += "				<input type='radio' name='star' value='3' onclick='return(false)'/>3점";
					reviewForm += "				<input type='radio' name='star' value='4' onclick='return(false)'/>4점";
					reviewForm += "				<input type='radio' name='star' value='5' onclick='return(false)' checked='checked'/>5점";
				}
				reviewForm += "			</form>";
				reviewForm += "		<span>";1
				reviewForm += "	</div>";
				reviewForm += "	<div id='answerForm'></div>";
				if(reviewList[i].review_answer !== null && reviewList[i].review_answer !== ''){
					reviewForm += "	<div>";
					reviewForm += "		<span>답글</span>";
					reviewForm += "	</div>";
					reviewForm += "	<div>";
					reviewForm += "		<span><textarea id='review' name='review' cols='55' rows='10' readonly>"+reviewList[i].review_answer+"</textarea></span>";
					reviewForm += "	</div>";
					break;
				}
			}
		}
			reviewForm += "</div>";
		var submit = "";
			submit += "<div style='cursor:pointer; background-color:#FFB6C1; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='closeModal()'>";
			submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>닫기</span>"
			submit += "</div>"
		for(var i=0; i<reviewList.length; i++){
			if(reviewList[i].reserve_no === reserve_no){
				if(reviewList[i].review_answer === '' || reviewList[i].review_answer === null){
					submit += "<div style='cursor:pointer; background-color:#98FB98; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='answerForm("+reviewList[i].review_no+")'>";
					submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>답글쓰기</span>"
					submit += "</div>"
				}
			}
		}
		$("#reviewForm").html(reviewForm);
		$("#submitForm").html(submit);
		$("#modal").show();
	}
	
	/** 모달창 닫기
	*/
    function closeModal() { 
    	$("#reviewForm").html("<div id='reviewForm' class='col-sm-12'></div>");
		$('.searchModal').hide();    
	};
	
	/** review_no로 답글 입력하기
		review_no = Int
	*/
	function answerForm(review_no) {
		var answer ="";
			answer +="<div>";
			answer +="		<span>답변달기</span>";
			answer +="</div>";
			answer +="<div>";
			answer +="		<span><textarea id='answer' name='answer' cols='55' rows='10'></textarea></span>";
			answer +="</div>";
		$("#answerForm").html(answer);
		var submit = "<div style='cursor:pointer; background-color:#FFB6C1; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='closeModal()'>";
			submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>닫기</span>"
			submit += "</div>"
			submit += "<div style='cursor:pointer; background-color:#98FB98; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='updateAnswer("+review_no+")'>";
			submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>저장</span>"
			submit += "</div>"
		$("#submitForm").html(submit);
	}
	
	/** review_no로 답글 저장
		review_no = Int
	*/
	function updateAnswer(review_no) {
		var answer = $('#answer').val();
		var defind = confirm("답글 내용은 입력시 수정이 불가능합니다. \n 내용 :"+answer+"\n으로 입력하시겠습니까?");
		if(defind) {
			$.ajax({
		    		url : "updateAnswer.do"
		    		, method : "POST"
		   			, data : ({
		   				review_no : review_no
		   				, review_answer : answer
		    		})
		    		, success : function(res) {
		    			console.log(res);
		    			alert("답글이 정상적으로 등록되었습니다.");
		    			$("#reviewForm").html("<div id='reviewForm' class='col-sm-12'></div>");
		    			location.reload();
		   			}
		    		, error : function(res) {
		    			alert("답글등록에 실패했습니다.");
		    		}
		   	});
		}
	}
</script>
</head>
<body>
	<table class='default'>
		<tr><th style='font-size: 20pt; text-align: center;'>가드너 케어 진행 입력 및 리뷰관리</th></tr>
	</table>
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
				<div id="view"></div>
			</div>
			<!-- 예약입력 -->
			<div>
				<form id="frm" method="post" onsubmit="return false;" enctype="multipart/form-data">
					<div id="insertCompletion"></div>
				</form>
			</div>
			<!-- modal insertReview -->
			<div id="modal" class="searchModal">
				<div class="search-modal-content"> 
					<div class="page-header">
						<h1>Review</h1>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="row">
								<div id='reviewForm' class="col-sm-12"></div>
							</div>
						</div>
					</div>
					<hr>
					<div id='submitForm'></div>
				</div>
			</div>
			<!-- modal -->
		</div>
	</div>
</body>
</html>