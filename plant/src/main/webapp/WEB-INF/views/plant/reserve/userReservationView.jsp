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

.custom_calendar_table tbody td.reserved {
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
	})
	
	// user_no
	var urlParams = new URL(location.href).searchParams;
	var user_no = urlParams.get('user_no');
	
	// 달력 출력
	var nowDate = new Date();
	
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
	        // 년월 클릭
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
            	res += "<table border='1'>";
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
            			for(var i=0; i<userPayHistory.length; i++){
            				for(var j=0; j<reservedDate.length; j++){
            					if(userPayHistory[i].reserve_cancel === 0 && userPayHistory[i].reserve_no === reservedDate[j].reserve_no){
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
            			for(var i=0; i<userPayHistory.length; i++){
            				for(var j=0; j<reservedDate.length; j++){
            					if(userPayHistory[i].reserve_cancel === 0 && userPayHistory[i].reserve_no === reservedDate[j].reserve_no){
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
		            	for(var i=0; i<gdList.length; i++){
		            		res += "	<td>"
			            	res += "		"+gdList[i].gd_name+"("+gdList[i].gd_hp+")";
			            	res += "	</td>";
            			}
            			res += "	</tr>"; 
		            	res += "	<tr>";
		            	res += "		<td>결제번호</td>";
		            	for(var i=0; i<userPayHistory.length; i++){
		            		res += "	<td>"
			            	res += "		"+userPayHistory[i].merchant_uid+"";
			            	res += "	</td>";
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
	
	// 결제 내역 상세보기
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
						res += "시간:<span>"+reserved[j].reserve_hour+"</span></div>";
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
						res += ", "+reserved[j].gd_no+")'>취소 및 환불</button>";
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
		        			location.reload();
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
		

	  
	// 결제번호 검색
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
</script>
</head>
<body>
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
							<td colspan='4'>결제번호 검색<input onkeyup="filter()" type="text" id="value" placeholder="Type to Search"></td>
								
						</tr>
						<tr>
							<td colspan='4'>결제번호      결제일&nbsp&nbsp결제금액&nbsp&nbsp예약취소</td>
						</tr>
						<c:forEach var="p" items="${userPayHistoryDeduplication}">
							<c:if test='${p.reserve_cancel eq 0 }'>
								<tr class="item">
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
								<tr class="item">
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
				<div></div>
			</div>
		</div>
	</div>
</body>
</html>