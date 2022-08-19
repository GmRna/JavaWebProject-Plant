<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>가드너 예약 결제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://momentjs.com/downloads/moment.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
	var gd_no = "${vo.gd_no}";
	// selectReserve Array 생성 및 값 저장
	var selectReserve = new Array();
	<c:forEach items = "${selectReserve}" var = "r">
		selectReserve.push({
			reservable_no : ${r.reservable_no}
			, reservable_date : ${r.reservable_date}
			, reservable_hour : ${r.reservable_hour}
			, reservable_major : "${r.reservable_major}"
		});
	</c:forEach>
	<c:forEach items = "${vo}" var = "v">
		console.log("메롱")
	</c:forEach>
	// 예약 내용 가져오기
	function reserveInfo() {
		var res = "";
			res += "<tr>";
			res += "	<td>예약일</td>";
		for(var i=0; i<selectReserve.length; i++) {
			res += "	<td>"+selectReserve[i].reservable_date+"</td>";
		}
			res += "</tr>";
			res += "<tr>";
			res += "	<td>예약시간</td>";
		for(var i=0; i<selectReserve.length; i++) {
			res += "	<td>"+selectReserve[i].reservable_hour+"</td>";
		}
			res += "</tr>";
			res += "<tr>";
			res += "	<td>케어내용</td>";
		for(var i=0; i<selectReserve.length; i++) {
			res += "	<td>"+selectReserve[i].reservable_major+"</td>";
		}
			res += "</tr>";
			res += "<tr>";
			res += "	<td>케어당 가격</td>";
			res += "	<td>"+gd_no+"</td>";
			res += "</tr>";
			
			$("#reserveInfo").html(res);
	}
	
	$(function(){	
		reserveInfo();
	});
</script>
</head>
<body>
	<h1> 결제 페이지</h1>
	<!-- 결제페이지 상단 -->
	<div style="float:left; width:100%;">
		<!-- 결제 정보 -->
		<div style="float:left; width:80%;">
			<h3>예약자 정보</h3>
			<table style="width:100%;" border="1">
				<tbody>
					<tr>
						<td>예약자</td>
						<td>
							<input type="text" id="us_name" value="${user.user_name}">
						</td>
					</tr>
					<tr>
						<td>연락처</td>
						<td>
							<input type="text" id="us_name" value="${user.user_hp}">
						</td>
					</tr>
					<tr>
						<td rowspan="3">주소</td>
						<td>
							<input type="text" name="postCode" id="postCode" class="inNextBtn" style="float:left;" value="${user.user_postcode}" readonly>
							<span>
								<a href="javascript:postCode();" style="float:left; width:auto; clear:none;">우편번호</a>
							</span>

						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="addr1" readonly value="${user.user_addr1}">
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="addr2" value="${user.user_addr2}">
						</td>
					</tr>
					<tr>
						<td>특이사항</td>
						<td>
							<textarea id="etc" rows="10px" cols="30px"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<h3>예약정보</h3>
			<table style="width:100%;" border="1">
				<tbody>
					<tr>
						<td>가드너 이름</td>
						<td colspan="100">${data.gd_name}</td>
					</tr>
					<tr>
						<td>가드너 연락처</td>
						<td colspan="100">${data.gd_hp}</td>
					</tr>
				</tbody>
				<tbody id="reserveInfo">
				</tbody>
			</table>
		</div>
		<!-- 결제 총합산 가격 및 내역 -->
		<div style="float:right; margin-right:10px; width:20%;">
		456
		</div>
	</div>
</body>
</html>