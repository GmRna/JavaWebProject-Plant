<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	background-color: #73d5ac;
	color: #000000;
}

.set {
	background-color: #288CFF;
	color: #fff;
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
	// 케어진행완료 리스트 출력
	$(function(){
		calendarMaker($("#calendarForm"), new Date());
		completion();
	})
	
	// user_no
	var urlParams = new URL(location.href).searchParams;
	var user_no = urlParams.get('user_no');
	// contextPath
	var contextPath = "<%=request.getContextPath()%>";
	
	// 달력 출력
	var nowDate = new Date();
	
	// 현재 시간
	var nowYear = nowDate.getFullYear();
	var nowMonth = ('0' + (nowDate.getMonth() + 1)).slice(-2);
	var nowDay = ('0' + nowDate.getDay()).slice(-2);
	var dateStr = nowYear + nowMonth + nowDay;
	
	// 유저 결제 내역
	var userPayHistory = new Array();
	<c:forEach items = "${userPayHistory}" var = "p">
		userPayHistory.push({
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
			, reserve_completion : ${p.reserve_completion}
		});
	</c:forEach>
	
	// 가드너 정보 리스트
	var gdList = new Array();
	<c:forEach items = "${gdList}" var = "g">
		gdList.push({
			gd_no : ${g.gd_no}
			, gd_email : "${g.gd_email}"
			, gd_name : "${g.gd_name}"
			, gd_age : ${g.gd_age}
			, gd_hp : ${g.gd_hp}
			, gd_regdate : "${g.gd_regdate}"
			, gd_ableaddr : "${g.gd_ableaddr}"
			, gd_career : "${g.gd_career}"
			, gd_picorg : "${g.gd_picorg}"
			, gd_picreal : "${g.gd_picreal}"
			, gd_certificate : "${g.gd_certificate}"
			, gd_acc : ${g.gd_acc}
			, gd_major1 : "${g.gd_major1}"
			, gd_major2 : "${g.gd_major2}"
			, gd_major3 : "${g.gd_major3}"
			, gd_major4 : "${g.gd_major4}"
			, gd_major5 : "${g.gd_major5}"
			, gd_major6 : "${g.gd_major6}"
			, gd_major7 : "${g.gd_major7}"
			, starAverage : ${g.starAverage}
		});
	</c:forEach>
	
	// 예약된 날짜, 시간, 종목
	var reserved = new Array();
	<c:forEach items = "${reservationList}" var = "r">
		reserved.push({
			reserve_no : ${r.reserve_no}
			, gd_no : ${r.gd_no}
			, user_no : ${r.user_no}
			, reserve_date : ${r.reserve_date}
			, reserve_hour : ${r.reserve_hour}
			, reserve_etc : "${r.reserve_etc}"
			, reserve_time : "${r.reserve_time}"
			, major : "${r.major}"
			, gd_hp : ${r.gd_hp}
			, gd_name : "${r.gd_name}"
		});
	</c:forEach>
	
	// 케어진행 완료 내역
	var completionList = new Array();
	<c:forEach items = "${completion}" var = "c">
		completionList.push({
			reserve_no : ${c.reserve_no}
			, gd_no : ${c.gd_no}
			, user_no : ${c.user_no}
			, gd_name : "${c.gd_name}"
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
	
	// 예약된 날짜, 시간, 종목
	var userPayHistoryDeduplicationList = new Array();
	<c:forEach items = "${userPayHistoryDeduplication}" var = "pd">
		userPayHistoryDeduplicationList.push({
			reserve_no : ${pd.reserve_no}
			, pay_no : ${pd.pay_no}
			, gd_no : ${pd.gd_no}
			, user_no : ${pd.user_no}
			, pay_date : "${pd.pay_date}"
			, pay_size : ${pd.pay_size}
			, buyer_name : "${pd.buyer_name}"
			, buyer_addr : "${pd.buyer_addr}"
			, buyer_postcode : "${pd.buyer_postcode}"
			, buyer_email : "${pd.buyer_email}"
			, buyer_tel : "${pd.buyer_tel}"
			, merchant_uid : "${pd.merchant_uid}"
			, pay_method : "${pd.pay_method}"
			, reserve_cancel : ${pd.reserve_cancel}
		});
	</c:forEach>
	
	// 리뷰
	var reviewList = new Array();
	<c:forEach items = "${reviewList}" var = "rv">
		reviewList.push({
			reserve_no : ${rv.reserve_no}
			, gd_no : ${rv.gd_no}
			, gd_name : "${rv.gd_name}"
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
            			"<th colspan='7'>좌우 화살표로 다음(이전월)로 이동 가능하며 초록색은 예약된날을  나타냅니다.</th>" +
            		"</thead>" +
	            	"<thead  class='cal_week'>" +
	            		"<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
	            	"</thead>" +
	            	"<tbody id='custom_set_date'>" +
	            	// 달력검색을 위한 클래스 생성
	            		"<tr>" +
	            			"<input type='hidden' class='reserved'>"+
	            		"</tr>"+
	            	"</tbody>" +
	            "</table>";
	        return calendar_html_code;
	    }
	    
	    // 클래스 변경하기
	    function classChange() {
	    	// table id값 스캔
			var tdId = $('#custom_set_date').find('td')

	    	// 예약된 내역 date class 값 변경
	    	for(var x=0; x<reserved.length; x++) {
	    		for(var y=0; y<tdId.length; y++) {
	    			// 현재 id 값
	    			var thisId = $(tdId[y]).attr('id');
	    			// 현재 class값
	    			var thisClass = $('#'+thisId+'').attr('class');
	    			if(reserved[x].reserve_date == Number(thisId)) {
	    				$('#'+thisId+'').attr('class','reserved');
	    			}
	    		}
	    	}
	    	// 예약없는 td class값 변경
	    	for(var z=0; z<tdId.length; z++) {
    			// 현재 id 값
    			var thisId = $(tdId[z]).attr('id');
    			// 현재 class값
    			var thisClass = $('#'+thisId+'').attr('class');
    			if(thisClass !== 'reserved'){
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
				// 클릭한 td id값에 맞는 예약된 일자 true 처리
				function rdDate(reserved) {
					if(reserved.reserve_date === Number(idValue)) {
						return true;
					}
				}
				// true인 객체 배열화
				var reservedDate = reserved.filter(rdDate); // 예약 된 일자
	        	var res = "";
        		var date = moment(idValue); // 모맨트 js 활용 하여 데이터 포맷 변경
	        	// select_day 클래스 삭제
	            $(".custom_calendar_table .select_day").removeClass("select_day");
	        	// 삭제 후 예약데이터와 비교하여 다시 클래스 변경
	            classChange();
            	res += "<table border='1' class='default'>";
            	res += "	<tr>";
            	res += "		<td colspan='3'>예약일정 확인</td>";	
            	res += "	</tr>";	            	
            	if ($('#'+idValue+'').attr('class') === 'default') {
            		res += "<td colspan='3'>예약한 일정이 없습니다.</td>"
            	}
	        	// select_day
            	if ($(".custom_calendar_table .select_day").hasClass("select_day")) {
            		$(this).removeClass("select_day").addClass("select_day");
            	}	  
            	if ($(".custom_calendar_table .reserved").hasClass("reserved")) {
            		$(this).removeClass("reserved").addClass("select_day");
            		// 예약된 시간
            		if (reservedDate.length > 0) {
						res += "	<tr>";
		            	res += "		<td>예약일</td>";		
		            	res += "		<td colspan='2'>";
		            	res += "			"+date.format('YYYY-MM-DD')+"";
		            	res += "		</td>";
		            	res += "	</tr>";
		            	res += "	<tr>";
		            	res += "		<td>예약 시간</td>"
            			for(var i=0; i<reservedDate.length; i++){
            				res += "	<td>"+reservedDate[i].reserve_hour+"시</td>";
            			}
		            	res += "	</tr>";
		            	res += "	<tr>";
		            	res += "		<td>케어종목</td>"
            			for(var i=0; i<reservedDate.length; i++){
            				res += "	<td>";
            				res += "		"+reservedDate[i].major+"";
            				res += "	</td>";
            			}
		            	res += "	</tr>";
		            	res += "	<tr>";
		            	res += "		<td>특이사항</td>"
            			for(var i=0; i<reservedDate.length; i++){
            				res += "	<td>"+reservedDate[i].reserve_etc+"</td>";
            			}
		            	res += "	</tr>";
		            	res += "	<tr>";
		            	res += "		<td>출장요청주소</td>"
		            	var addr = false;
            			for(var i=0; i<reservedDate.length; i++){
            				for(var j=0; j<userPayHistory.length; j++){
            					if(userPayHistory[j].reserve_cancel === 0 && userPayHistory[j].reserve_no === reservedDate[i].reserve_no){
            						addr = true
            						break;
            					}
            				}
            				if(addr) {
            					res += "	<td>"+userPayHistory[i].buyer_addr+"</td>";
            				}
            			}
		            	res += "	</tr>";
		            	res += "	<tr>";
		            	res += "		<td>구매자</td>"
		            	var buyer = false;
		            	for(var i=0; i<reservedDate.length; i++){
            				for(var j=0; j<userPayHistory.length; j++){
            					if(userPayHistory[j].reserve_cancel === 0 && userPayHistory[j].reserve_no === reservedDate[i].reserve_no){
            						buyer = true
            						break;
            					}
            				}
            				if(buyer) {
            					res += "	<td>"+userPayHistory[i].buyer_name+"</td>";
            				}
            			}
		            	res += "	</tr>";	
		            	res += "	<tr>";
		            	res += "		<td>가드너 이름 및 연락처</td>";
		            	for(var i=0; i<reservedDate.length; i++){
				            res += "	<td>"
					        res += "		"+reservedDate[i].gd_name+"("+reservedDate[i].gd_hp+")";
					        res += "	</td>";
            			}
            			res += "	</tr>"; 
		            	res += "	<tr>";
		            	res += "		<td>결제번호</td>";
		            	var uid = false;
		            	for(var i=0; i<reservedDate.length; i++){
            				for(var j=0; j<userPayHistory.length; j++){
            					if(userPayHistory[j].reserve_cancel === 0 && userPayHistory[j].reserve_no === reservedDate[i].reserve_no){
            						uid = true
            						break;
            					}
            				}
            				if(uid) {
            					res += "<td>"+userPayHistory[j].merchant_uid+"</td>";
            				}
            			}
            			res += "	</tr>"; 

            		}
            	}
            	if ($(".custom_calendar_table .default").hasClass("default")) {
            		$(this).removeClass("default").addClass("select_day");
            	}
            	res += "</table>";
            	$("#reservableSchedule").html(res);
	        });
	    }
	}
	
	/** 결제내역 상세보기
		merchant_uid = Int
	*/
	function payHistory(merchant_uid) {
		// if문 실행을 위한 boolean
		var check = false;
		var res = "";
			res += "<div>";
			res += "	<div>";
			res += "	<span>결제번호</span>";
			res += "	<span>"+merchant_uid+"</span>";
			res += "	</div>";
			res += "	<div>";
			res += "	<span>예약번호</span>";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				res += "<div><span>"+userPayHistory[i].reserve_no+"</span></div>";
				check = false;
			}
		}
			res += "	</div>";
			res += "	<div>";
			res += "	<span>예약일시</span>";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				for(var j=0; j<reserved.length; j++){
					if(userPayHistory[i].reserve_no === reserved[j].reserve_no){
						res += "<div> 예약일:<span>"+reserved[j].reserve_date+"</span>";
						res += "시간:<span>"+reserved[j].reserve_hour+"</span>&nbsp";
						if(userPayHistory[i].reserve_completion === 1) {
							res += "<span id='completionCheck'>[케어진행 완료]</span></div>";
						}
					}
				}
				check = false;
			}
		}
			res += "	</div>";
			res += "	<div>";
			res += "	<span>케어종목</span>";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				for(var j=0; j<reserved.length; j++){
					if(userPayHistory[i].reserve_no === reserved[j].reserve_no){								
							res += "<div><span>"+reserved[j].major+"</span</div>";
					}
				}
			}
				check = false;
		}
			res += "	</div>";
			res += "	<div>";
			res += "	<span>가드너 이름</span>";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				for(var j=0; j<reserved.length; j++){
					if(userPayHistory[i].reserve_no === reserved[j].reserve_no){
						for(var k=0; k<gdList.length; k++){
							if(reserved[j].gd_no === gdList[k].gd_no){
								res += "<div><span>"+gdList[k].gd_name+"</span></div>";
								check = false;
								break;
							} 
						}
					}
					break;
				}
				break;
			}
		}
			res += "	</div>";
			res += "	<div>";
			res += "	<span>결제가격</span>";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {							
				res += "<div><span>"+userPayHistory[i].pay_size+"</span></div>";
				check = false;
				break;
			} 
		}
			res += "<div>";
			res += "<button type='button' name='결제번호 : "+merchant_uid+"\n";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				for(var j=0; j<reserved.length; j++){
					if(userPayHistory[i].reserve_no === reserved[j].reserve_no){
						res += "예약일:"+reserved[j].reserve_date+"";
						res += "시간:"+reserved[j].reserve_hour+"\n"; 
					}
				}
				check = false;
			}
		}
			res += "'\n";
			res += "value='";
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				res += ","+userPayHistory[i].reserve_no+"";
				check = false;
			}
		}
			res += "' onclick='cancel(this.value, this.name";		
		for(var i=0; i<userPayHistory.length; i++) {
			if(userPayHistory[i].merchant_uid === merchant_uid) {
				check = true;
			}
			if(check) {
				for(var j=0; j<reserved.length; j++){
					if(userPayHistory[i].reserve_no === reserved[j].reserve_no){
						res += ", "+reserved[j].gd_no+")'>취소 및 환불</button><button type='button' onclick='payHistoryDelete()'>결제 상세보기 닫기</button>";
						check = false;
						break;
					}
				}
				break;
			}
		}
			res += "	</div>";
			res += "</div>";
		$('#payHistory').html(res);
	}
	
	// 예약취소
	function cancel(value, name, gd_no) {
		var  date = new Date();
		var year = date.getFullYear();
		var month = ('0' + (date.getMonth() + 1)).slice(-2);
		var day = ('0' + date.getDay()).slice(-2);
		// 현재 시간
		var dateStr = year + month + day;
		
		// 예약일
		var reserveDateStr = name.substring(30,38);
		
		// 결제번호
		var merchant_uid = name.substring(7, 25);
		
		// 결제 가격
		var pay_size = 0;
		var check = false;
		console.log(document.getElementById("completionCheck"));
		// 케어진행 완료 여부 체크
		if(document.getElementById("completionCheck")) {
			alert("해당하는 계약건에 케어진행이 1회 이상 진행되었기 때문에 환불 불가능합니다. \n 자세한 사항은 문의사항으로 남겨주세요");
		}
		if(document.getElementById("completionCheck") == null) {
			console.log(2);
			for(var i=0; i<userPayHistory.length; i++) {
				if(userPayHistory[i].merchant_uid === merchant_uid) {
					check = true;
				}
				if(check) {							
					pay_size += userPayHistory[i].pay_size;
					check = false;
					break;
				} 
			}
			// 유저번호 int로 만들기
			var intUserNo = parseInt(user_no);
			if (Number(dateStr)+7 > Number(reserveDateStr)) {
				alert("예약일이 현재일로부터 7일 이상 남아야 예약 취소가 가능합니다.")
			}
			if (Number(dateStr)+7 <= Number(reserveDateStr)) {
			
				var defind = confirm(""+name+"\n해당하는 예약을 정말로 취소하시겠습니까?\n(취소완료창이 보일때까 기다려주세요)");
			
				// if문 탈출을 위한 flag
				var flag = true;
			
				if(defind == true) {
					var cancelComment = prompt( '취소사유를 입력해주십시오.\n사유가 없으시면 확인을 눌러주시고 취소를 원치 않으시면 취소를 눌러주세요.', '' );
					if(cancelComment == null ) {
						flag = false;
						alert("예약이 취소되지 않았습니다.");
					}
					if(cancelComment == '' ) {
						cancelComment = "없음";
					}
				/* cancelPay(merchant_uid, pay_size); */
					if(flag == true) {
						$.ajax({
		        			type : "POST"
		        			, url : "/plant/reserve/cancel.do"
		        			, data : {
		        				selectReserve : value
		        				, user_no : intUserNo
		        				, gd_no : gd_no
		        				, cancel_comment : cancelComment
		        				, pay_size : pay_size
		        				, merchant_uid : merchant_uid
		        			}
		        			, success : function(res) {
		    	    			alert('예약이 취소 완료되었습니다. 감사합니다.');
			        			console.log(res);
			    			}
		        			, error	: function(error) {
		        				alert("예약 취소중 오류가 발생했습니다.")
		        			}
		      	  		})
					}
				} else if(defind == false || flag == false) {
					alert('예약이 취소되지 않았습니다.')
				}
			}
		}
		
	}

	/** 결제내역 검색엔진
	*/
	function filter(){
		var value, name, item, i;
		value = document.getElementById("value").value.toUpperCase();
		item = document.getElementsByClassName("item");
		  
		for(i=0;i<item.length;i++){
			name = item[i].getElementsByClassName("history");
			if(name[0].innerHTML.toUpperCase().indexOf(value) > -1){
	        	item[i].style.display = "flex";
	        }else{
	        	item[i].style.display = "none";
	        }
	    }
	}
	
	/** 완료 내역 출력(클릭하여 리뷰달기 기능 제공)
	*/
	function completion() {
		var completion ="";
			completion +="<table border='1' class='default'>";
			completion +="		<tr>";
			completion +="			<th>케어진행완료내역</th>";
			completion +="		</tr>";
			completion +="		<tr>";
			completion +="			<td>예약번호</td>";
			completion +="			<td>예약일</td>";
			completion +="			<td>예약시간</td>";
			completion +="			<td>케어종목</td>";
			completion +="			<td>케어진행가드너</td>";
			completion +="			<td>케어내용상세보기</td>";
			completion +="		</tr>";
		for(var i=0; i<completionList.length; i++) {
			completion +="		<tr>";
			completion +="			<td>"+completionList[i].reserve_no+"</td>";
			completion +="			<td>"+moment(String(completionList[i].reserve_date)).format('YYYY-MM-DD')+"</td>";
			completion +="			<td>"+completionList[i].reserve_hour+"시</td>";
			completion +="			<td>"+completionList[i].reserve_major+"</td>";
			completion +="			<td>"+completionList[i].gd_name+"</td>";
			completion +="			<td><button type='button' onclick='completionView("+completionList[i].reserve_no+")'>케어내용상세보기</button></td>";
			completion +="		</tr>";
		}
			completion +="</table>";
		$('#completion').html(completion);
	}
	
	/** 완료 내역 출력(클릭하여 리뷰달기 기능 제공)
		reserve_no = Int
	*/
	function completionView(reserve_no) {
		var view = "";
		for(var i=0; i<completionList.length; i++) {
			if(completionList[i].reserve_no === reserve_no) {
				view +="<table border='1' class='default'>";
				view +="		<tr>";
				view +="			<th colspan='6'>케어내용상세보기 <button type='button' onclick='completionViewDelete()'>상세보기 닫기</button></th>";
				view +="		</tr>";
				view +="		<tr>";
				view +="			<td>예약자(닉네임)</td>";
				view +="			<td colspan='2'>"+completionList[i].user_name+"("+completionList[i].user_nick+")</td>";
				view +="			<td>리뷰남기기</td>";
				if(completionList[i].reserve_review == 0){
					view +="			<td colspan='2'><button type='button' onclick='writeReview("+completionList[i].reserve_no+","+completionList[i].gd_no+","+completionList[i].user_no+")'>리뷰쓰기</button></td>";
				}
				if(completionList[i].reserve_review == 1){
					view +="			<td colspan='2'><button type='button' onclick='reviewView("+completionList[i].reserve_no+","+completionList[i].gd_no+","+completionList[i].user_no+")'>리뷰확인</button>";
					for(var j=0; j<reviewList.length; j++) {
						if(completionList[i].reserve_no === reviewList[j].reserve_no) {
							if(reviewList[j].review_answer !== null && reviewList[j].review_answer !== ''){
								view +="  가드너 답글입력!";
							}
						}
					}
					view +="			</td>";
				}
				view +="		</tr>";
				view +="		<tr>";
				view +="			<td>가드너</td>";
				view +="			<td colspan='5'>"+completionList[i].gd_name+"</td>";
				view +="		</tr>";
				view +="		<tr>";
				view +="			<td>예약일</td>";
				view +="			<td>"+moment(String(completionList[i].reserve_date)).format('YYYY-MM-DD')+"</td>";
				view +="			<td>예약시간</td>";
				view +="			<td>"+completionList[i].reserve_hour+"시</td>";
				view +="			<td>예약시간</td>";
				view +="			<td>"+completionList[i].reserve_hour+"</td>";
				view +="		</tr>";
				view += "	<tr>";
				view += "		<td>케어진행 사항</td>";
				view += "		<td colspan='5'>"+completionList[i].completion_comment+"</td>";
				view += "	</tr>";
				view += "	<tr>";
				view += "		<td>케어진행사진</td>";
				if(completionList[i].completion_picorg1 !== null && completionList[i].completion_picorg1 !== '') {
					if((completionList[i].completion_picorg3 === null || completionList[i].completion_picorg3 === '')
							&& (completionList[i].completion_picorg2 === null || completionList[i].completion_picorg2 === '')) {
						view += "		<td colspan='5'>";
						view += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal1+"' style='width:90px; height:90px;' >";
						view += "			<p id='name' class='name'>"+completionList[i].completion_picorg1+"</p>";
						view += "		</td>";
					}
					if((completionList[i].completion_picorg3 === null || completionList[i].completion_picorg3 === '')
							&& (completionList[i].completion_picorg2 !== null && completionList[i].completion_picorg2 !== '')) {
						view += "		<td colspan='3'>";
						view += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal1+"' style='width:90px; height:90px;' >";
						view += "			<p id='name' class='name'>"+completionList[i].completion_picorg1+"</p>";
						view += "		</td>";
					}
					if(completionList[i].completion_picorg3 !== null && completionList[i].completion_picorg3 !== ''
							&& completionList[i].completion_picorg2 !== null && completionList[i].completion_picorg2 !== '') {
						view += "		<td colspan='1'>";
						view += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal1+"' style='width:90px; height:90px;' >";
						view += "			<p id='name' class='name'>"+completionList[i].completion_picorg1+"</p>";
						view += "		</td>";
					}
				}
				if(completionList[i].completion_picorg2 !== null && completionList[i].completion_picorg2 !== '') {
					view += "		<td colspan='2'>";
					view += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal2+"' style='width:90px; height:90px;' >";
					view += "			<p id='name' class='name'>"+completionList[i].completion_picorg2+"</p>";
					view += "		</td>";
				}
				if(completionList[i].completion_picorg3 !== null && completionList[i].completion_picorg3 !== '') {
					view += "		<td colspan='2'>";
					view += "			<img src='"+contextPath+"/upload/"+completionList[i].completion_picreal3+"' style='width:90px; height:90px;' >";
					view += "			<p id='name' class='name'>"+completionList[i].completion_picorg3+"</p>";
					view += "		</td>";
				}
				view += "	</tr>";
				view +="</table>";
				break;
			}
		}
		$('#completionView').html(view);
	}
	
	/** 결제내역 상세보기 지우기
	*/
	function payHistoryDelete() {
		$('#payHistory').html("<div id='payHistory'></div>");
	}
	
	/** 결제내역 상세보기 지우기
	*/
	function completionViewDelete() {
		$('#completionView').html("<div id='completionView'></div>");
	}
	
	/** 리뷰 입력
		reserve_no = Int
		gd_no = Int
		user_no = Int
	*/
	function writeReview(reserve_no, gd_no, user_no) {
		var reviewForm = "";
			reviewForm += "<div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>케어진행 일시</span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>예약번호 : "+reserve_no+"</span>";
			reviewForm += "	</div>";
		for(var i=0; i<completionList.length; i++) {
			if(completionList[i].reserve_no == reserve_no){
				reviewForm += "	<div>";
				reviewForm += "		<span>예약일 : "+completionList[i].reserve_date+"</span>";
				reviewForm += "		<span>예약시간: "+completionList[i].reserve_hour+"  케어종목: "+completionList[i].reserve_major+"</span>";
				reviewForm += "	</div>";
				break;
			}
		}
			reviewForm += "	<div>";
			reviewForm += "		<span>Review</span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
			reviewForm += "		<span><textarea id='review' name='review' cols='55' rows='10'></textarea></span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>Star</span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>";
			reviewForm += "			<form>";
			reviewForm += "				<input type='radio' name='star' value='1'/>1점";
			reviewForm += "				<input type='radio' name='star' value='2'/>2점";
			reviewForm += "				<input type='radio' name='star' value='3'/>3점";
			reviewForm += "				<input type='radio' name='star' value='4'/>4점";
			reviewForm += "				<input type='radio' name='star' value='5' checked='checked'/>5점";
			reviewForm += "			</form>";
			reviewForm += "		<span>";
			reviewForm += "		<input type='hidden' id='reviewReserveNo' value='"+reserve_no+"'>";
			reviewForm += "		<input type='hidden' id='reviewGdNo' value='"+gd_no+"'>";
			reviewForm += "		<input type='hidden' id='reviewUserNo' value='"+user_no+"'>";
			reviewForm += "	</div>";
			reviewForm += "</div>";
		var submit = "";
			submit += "<div style='cursor:pointer; background-color:#98FB98; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='insertReview()'>";
			submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>저장</span>"
			submit += "</div>"
			submit += "<div style='cursor:pointer; background-color:#FFB6C1; text-align: center; padding-bottom: 10px; padding-top: 10px;' onClick='closeModal()'>";
			submit += "		<span class='pop_bt modalCloseBtn' style='font-size: 13pt;'>닫기</span>"
			submit += "</div>"
		$("#reviewForm").html(reviewForm);
		$("#submitForm").html(submit);
		$("#modal").show();
	}
	
	/** 정보 가져와 review 등록
		reserve_no = String
		gd_no = Int
		user_no = Int
		star = Double
		review = String
	*/
	function insertReview() {
		var reserve_no = $('#reviewReserveNo').val();
		var gd_no = Number($('#reviewGdNo').val());
		var user_no = Number($('#reviewUserNo').val());
		var star = Number($('input[name=star]:checked').val());
		var review = $('#review').val();
		var defind = confirm("댓글 내용은 입력시 수정이 불가능합니다. \n 내용 :"+review+"\n 별점 : "+star+"점\n으로 입력하시겠습니까?");
		if(defind) {
			$.ajax({
		    		url : "insertReview.do"
		    		, method : "POST"
		   			, data : ({
		   				reserve_no : reserve_no
		   				, gd_no : gd_no
		   				, user_no : user_no
		   				, star : star
		   				, review : review
		    		})
		    		, success : function(res) {
		    			console.log(res);
		    			alert("리뷰가 정상적으로 등록되었습니다.");
		    			$("#reviewForm").html("<div id='reviewForm' class='col-sm-12'></div>");
		    			location.reload();
		   			}
		    		, error : function(res) {
		    			alert("리뷰등록에 실패했습니다.");
		    		}
		   	});
		}
	}
	
	/** 모달창 닫기
	*/
    function closeModal() { 
    	$("#reviewForm").html("<div id='reviewForm' class='col-sm-12'></div>");
		$('.searchModal').hide();    
	};
	
	/** 나의 리뷰 확인
	*/
	function reviewView(reserve_no, gd_no, user_no) {
		var reviewForm = "";
			reviewForm += "<div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>케어진행 일시</span>";
			reviewForm += "	</div>";
			reviewForm += "	<div>";
			reviewForm += "		<span>예약번호 : "+reserve_no+"</span>";
			reviewForm += "	</div>";
		for(var i=0; i<completionList.length; i++) {
			if(completionList[i].reserve_no == reserve_no){
				reviewForm += "	<div>";
				reviewForm += "		<span>예약일 : "+completionList[i].reserve_date+"</span>";
				reviewForm += "		<span>예약시간: "+completionList[i].reserve_hour+"  케어종목: "+completionList[i].reserve_major+"</span>";
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
				reviewForm += "		<span>";
				reviewForm += "		<input type='hidden' id='reviewReserveNo' value='"+reserve_no+"'>";
				reviewForm += "		<input type='hidden' id='reviewGdNo' value='"+gd_no+"'>";
				reviewForm += "		<input type='hidden' id='reviewUserNo' value='"+user_no+"'>";
				reviewForm += "	</div>";
				if(reviewList[i].review_answer !== null && reviewList[i].review_answer !== ''){
					reviewForm += "	<div>";
					reviewForm += "		<span>답글</span>";
					reviewForm += "	</div>";
					reviewForm += "	<div>";
					reviewForm += "		<span>가드너 이름 : "+reviewList[i].gd_name+"</span>";
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
		$("#reviewForm").html(reviewForm);
		$("#submitForm").html(submit);
		$("#modal").show();
	}
</script>
</head>
<body>
	<h1>유저 예약 확인</h1>
	<div>
		<!-- 상단 -->
		<div>
			<!-- 달력 -->
			<div>
				<div id="calendarForm"></div>
			</div>
			<!-- 예약내역 확인 -->
			<div>
				<div id="reservableSchedule"></div> 
			</div>
		</div>
		
		<!-- 하단 -->
		<div>
			<!-- 결제 내역 -->
			<div>
				<!-- 결제 내역 -->
				<div>
					<table border="1">
						<tr>
							<td colspan="4">결제내역</td>
						</tr>
						<tr>
							<td colspan='4'>결제번호 검색&nbsp&nbsp&nbsp<input onkeyup="filter()" type="text" id="value" placeholder="Type to Search"></td>
								
						</tr>
						<tr>
							<td colspan='4'>결제정보</td>
						</tr>
						<c:forEach var="p" items="${userPayHistoryDeduplication}">
							<c:if test='${p.reserve_cancel eq 0 }'>
								<tr class="item" style="width: 100%;">
									<td class="history">${p.merchant_uid}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${p.pay_date}" /></td>
									<td>${p.pay_size}</td>
									<td>
										<button 
											type='button'
											name='${p.merchant_uid}'
											onclick='payHistory(this.name)'>상세보기</button>
									</td>
								</tr>
							</c:if>
							<c:if test='${p.reserve_cancel eq 1 }'>
								<tr class="item" style="width: 100%;">
									<td class="history">${p.merchant_uid}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${p.pay_date}" /></td>
									<td>${p.pay_size}</td>
									<td>취소 및 환불 완료</td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</div>
				<div id="payHistory"></div>
			</div>
			<!-- 완료 예약 내역 상세정보 -->
			<div>
				<div id="completion"></div>
				<div id="completionView"></div>
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