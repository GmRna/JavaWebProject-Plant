<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>가드너 예약 결제</title>
<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>
<style type="text/css">
#payTable{
	display: flex;
    flex-direction: column;
}
table th {
	font-size: 20px;
	padding: 10px;
}
table td button {
	font-size: 13px;
}

h4{
	padding-top :20px;
	display: flex;
    justify-content: center;
}

</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- moment.js -->
<script src="https://momentjs.com/downloads/moment.js"></script>
<!-- postCode api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 
	var reservableNoList = new Array();
	<c:forEach var = "r" items ="${selectReserve}" varStatus="status">
		reservableNoList.push({
			reservable_no : ${r.reservable_no}
			, reservable_date : ${r.reservable_date}
			, reservable_hour : ${r.reservable_hour}
		});
	</c:forEach>
	// Reservation 특이사항 
	var reservationList = new Array();
	<c:forEach var = "r" items ="${reservation}" varStatus="status">
		reservationList.push({
			reserve_etc : "${r.reserve_etc}"
		});
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
			res += "<tr>";
			res += "	<td>특이사항</td>";
		for(var i=0; i<reservationList.length; i++) {
			res += "	<td>"+reservationList[i].reserve_etc+"</td>";
		}
			res += "</tr>";
			
		$("#reserveInfo").html(res);
	}
	
	/** 가드너 검색창으로 이동
	*/
	function goSearchGardener() {
		location.href="/plant/reserve/searchGardener.do";
	}
	
	/** 가드너 프로필 상세보기로 이동
	*/
	function goProfileView(gd_no) {
		location.href="/plant/reserve/profileView.do?gd_no="+gd_no+"";
	}
	
	/** 유저 예약확인으로 이동
	*/
	function goUserReservationView(user_no) {
		location.href="/plant/reserve/userReservationView.do?user_no="+user_no+"";
	}
	
	/** 메인 화면으로 이동
	*/
	function goMain() {
		location.href="/plant/main/index.do";
	}
</script>
</head>
<body>
<div class="sub" id="wrapper">
	<h2>결제 내역</h2>
	<h4>예약에 성공하였습니다.</h4>
	<div class="size" id="gdView">	
	<div id="payTable">
		<table border="1" class='default'>
			<tbody>
				<tr>
					<th style='background-color:#89AD98; color:#fff;'colspan='100' style='font-size: 15pt; text-align: center;'>예약 정보</th>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>예약자</td>
					<td colspan="100">${vo.buyer_name}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>닉네임</td>
					<td colspan="100">${user.user_nick}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>주소</td>
					<td colspan="100">${vo.buyer_addr}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>연락처</td>
					<td colspan="100">${vo.buyer_tel}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>가드너 이름</td>
					<td colspan="100">${gd.gd_name}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>가드너 연락처</td>
					<td colspan="100">${gd.gd_hp}</td>
				</tr>
			</tbody>
			<tbody id="reserveInfo">
			</tbody>
			<tbody>
				<tr>
					<th style='background-color:#89AD98; color:#fff;' colspan='100' style='font-size: 15pt; text-align: center;'>결제 정보</th>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>결제번호(예약번호)</td>
					<td colspan="100">${vo.merchant_uid}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>결제수단</td>
					<td colspan="100">${vo.pay_method}</td>
				</tr>
				<tr>
					<td style='background-color:#89AD98; color:#fff;'>총 결제액</td>
					<td colspan="100">${vo.pay_size}</td>
				</tr>
			</tbody>
		</table>
		<table class='default'>
			<tr>
				<td style='text-align: center;'>
					<!-- 홈페이지 이동 -->
					<button type='button' onclick='goMain()'>홈페이지로 이동</button>
					<!-- 가드너 검색창으로 이동 -->
					<button type='button' onclick='goSearchGardener()'>가드너 검색으로 이동</button>
					<!-- 가드너 프로필카드 상세페이지 이동 -->
					<button type='button' onclick='goProfileView(${gd.gd_no})'>가드너 프로필카드 상세페이지</button>
					<!-- 나의 예약확인 페이지 이동 -->
					<button type='button' onclick='goUserReservationView(${user.user_no})'>나의 예약확인 페이지</button>
					</td>
				</tr>
		</table>				
	</div>
	
	
	</div>
</div>
</body>
</html>