<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/reserveHeader.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>가드너 예약 결제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- moment.js -->
<script src="https://momentjs.com/downloads/moment.js"></script>
<!-- postCode api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script>
	$(function(){	
		reserveInfo();
	});
	// 우편번호 API
    function postCode() {
        new daum.Postcode({
            oncomplete: function(data) {        		
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    addr += extraAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postCode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
	// 가드너 번호
	var gd_no = "${gd.gd_no}";
	// 유저 번호
	var user_no = "${user.user_no}";
	// reservableNoList Array 및 소계 가격 리스트 생성 저장
	var reservableNoList = new Array();
	// reservable_no 
	var selectReserve = "";
	<c:forEach var = "r" items ="${selectReserve}" varStatus="status">
		reservableNoList.push({
			reservable_no : ${r.reservable_no}
			, reservable_date : ${r.reservable_date}
			, reservable_hour : ${r.reservable_hour}
			, reservable_major : "${r.reservable_major}"
			, reservable_subTotal : ${total[status.index]}
		});
		selectReserve += ",${r.reservable_no}";
	</c:forEach>

	// 예약 내용 가져오기
	function reserveInfo() {
		var res = "";
			res += "<tr>";
			res += "	<td>예약일</td>";
		for(var i=0; i<reservableNoList.length; i++) {
			res += "	<td>"+moment(reservableNoList[i].reservable_date.toString()).format('YYYY-MM-DD')+"</td>";
		}
			res += "</tr>";
			res += "<tr>";
			res += "	<td>예약시간</td>";
		for(var i=0; i<reservableNoList.length; i++) {
			res += "	<td>"+reservableNoList[i].reservable_hour+"</td>";
		}
			res += "</tr>";
			res += "<tr>";
			res += "	<td>케어내용</td>";
		for(var i=0; i<reservableNoList.length; i++) {
			res += "	<td>"+reservableNoList[i].reservable_major+"</td>";
		}
			res += "</tr>";
			res += "<tr id='subTotal'>";
			res += "	<td>케어당 가격</td>";
		for(var i=0; i<reservableNoList.length; i++) {
			res += "	<td>"+reservableNoList[i].reservable_subTotal+"</td>";
		}
			res += "</tr>";
			
		$("#reserveInfo").html(res);
		totalPrice();
	}
	// 총합계 구하기
	function totalPrice() {
		var sum = 0;
		for(var i=1; i<($("#subTotal td").length); i++) {
			sum += Number($("#subTotal td").eq(i).text());
		}
		var res = "<div id='totalPrice'>"+sum+"원</div>"
		$('#total').html(res);
	}
	
	// 결제 아임 포트 api
	function requestPay() {
	// 가맹정 식별코드
		var IMP = window.IMP;
		IMP.init("imp56776552"); // 예: imp00000000
		
		// 전체가격
		var sum = 0;
		for(var i=1; i<($("#subTotal td").length); i++) {
			sum += Number($("#subTotal td").eq(i).text());
		}
		
	    // IMP.request_pay(param, callback) 결제창 호출
	    IMP.request_pay({ 
			pg: "html5_inicis"
	        , pay_method: "card"
	        , merchant_uid: createPayNum()
	        , name: "가드너 파견 예약"
	        , amount: 100 // 테스트용 추후 sum으로 변경
	        , buyer_email: $("#user_email").val()
	        , buyer_name: $("#user_name").val()
	        , buyer_tel: $("#user_hp").val()
	        , buyer_addr: $("#addr1").val()+$("#addr2").val()
	        , buyer_postcode: $("#postCode").val()
		}
	    ,function(rsp) {
			
			// 결제검증
			$.ajax({
	        	type : "POST"
	        	, url : "/plant/reserve/verifyIamport/" + rsp.imp_uid
	        	, dataType:"JSON"
	        })
	        .done(function(data) {       	
	        	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
	        	if(rsp.paid_amount == data.response.amount){
		        	alert("결제 완료");
		        	var etcVal = $("#etc").val();
		        	var payInfo = "";
		        		payInfo += "<input type='hidden' name='user_no' value='"+user_no+"'>";
		        		payInfo += "<input type='hidden' name='selectReserve' value='"+selectReserve+"'>";
		        		payInfo += "<input type='hidden' name='gd_no' value='"+Number(gd_no)+"'>";
		        		payInfo += "<input type='hidden' name='buyer_name' value='"+data.response.buyerName+"'>";
		        		payInfo += "<input type='hidden' name='buyer_addr' value='"+data.response.buyerAddr+"'>";
		        		payInfo += "<input type='hidden' name='buyer_postcode' value='"+data.response.buyerPostcode+"'>";
		        		payInfo += "<input type='hidden' name='buyer_email' value='"+data.response.buyerEmail+"'>";
		        		payInfo += "<input type='hidden' name='buyer_tel' value='"+data.response.buyerTel+"'>";
		        		payInfo += "<input type='hidden' name='merchant_uid' value='"+data.response.merchantUid+"'>";
		        		payInfo += "<input type='hidden' name='pay_method' value='"+data.response.payMethod+"'>";
		        		payInfo += "<input type='hidden' name='pay_size' value='"+Number(data.response.amount)+"'>";
		        		if(etcVal === '' || etcVal === null) {
		        			payInfo += "<input type='hidden' name='reserve_etc' value='없음'>";
		        		}
		        		if(etcVal !== '' || etcVal !== null) {
		        			payInfo += "<input type='hidden' name='reserve_etc' value='"+etcVal+"'>";
		        		}
	        		$("#param").html(payInfo)
	        		frm.submit();
		        }
			});
		}
		);
	}
	
	// 결제번호 만들기
	function createPayNum(){
		var date = new Date();
		var year = date.getFullYear();
		var month = String(date.getMonth() + 1).padStart(2, "0");
		var day = String(date.getDate()).padStart(2, "0");
		
		let orderNum = year + month + day;
		for(var i=0; i<10; i++) {
			orderNum += Math.floor(Math.random() * 8);	
		}
		return orderNum;
	}
</script>
</head>
<body>
	<table class='default'>
		<tr><th style='font-size: 20pt; text-align: center;'>결제 하기</th></tr>
	</table>
	<!-- 결제페이지 상단 -->
	<div>
		<!-- 결제 정보 -->
		<div>
			<table class='default'>
				<tr>
					<th colspan='100' style='font-size: 15pt; text-align: center;'>예약자 정보</th>
				</tr>
				<tbody>
					<tr>
						<td>예약자</td>
						<td>
							<input style='width: 400px;' type="text" id="user_name" value="${user.user_name}">
						</td>
					</tr>
					<tr>
						<td>연락처</td>
						<td>
							<input style='width: 400px;' type="text" id="user_hp" value="${user.user_hp}">
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input style='width: 400px;' type="text" id="user_email" value="${user.user_email}">
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>
							<input type="text" name="postCode" id="postCode"class="inNextBtn" style="float: left;" value="${user.user_postcode}" readonly>
							&nbsp<button type='button' onclick='postCode()'>우편번호 검색</button>
						</td>
					</tr>
					<tr>
						<td>기본주소</td>
						<td>
							<input style='width: 400px;' type="text" id="addr1" readonly value="${user.user_addr1}">
						</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td>
							<input style='width: 400px;' type="text" id="addr2" value="${user.user_addr2}">
						</td>
					</tr>
				</tbody>
			</table>
			<table class='default'>
				<tr>
					<th colspan='100' style='font-size: 15pt; text-align: center;'>예약 정보</th>
				</tr>
				<tr>
					<td>가드너 이름</td>
					<td colspan="100">${gd.gd_name}</td>
				</tr>
				<tr>
					<td>가드너 연락처</td>
					<td colspan="100">${gd.gd_hp}</td>
				</tr>
				<tbody id="reserveInfo">
				</tbody>
				<tr>
					<td>요청사항</td>
					<td colspan="100">
						<input style='width: 80%; hight:height 50px;' type="text" id="etc">
					</td>
				</tr>
				<tr>
					<td>총 합계 금액</td>
					<td colspan="100" style='font-size: 13pt;text-align: center;'><div id="total"></div></td>
				</tr>
				<tr>
					<td>카드 결제</td>
					<td colspan="100" style='text-align: center;'><button onclick="requestPay()">결제하기</button></td>
				</tr>
				<tr>
					<td colspan="100">* 본 버전은 테스트 버전이기 때문에 결제액은 100원으로 설정되어있고 다음달 자정에 환불됩니다. *</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div>
		<!-- 파라메터 전달을 위한 form -->
			<form method="post" name="frm" id="frm" action="payConfirm.do">
				<div id="param"></div>
			</form>
	</div>
</body>
</html>