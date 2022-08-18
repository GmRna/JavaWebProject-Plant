<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<c:forEach var="p" items="${profile}">
		<h2>가드너</h2>
		<div id="${p.gd_no}" class="profileView" onclick="javascript:profileView()">
			<table border="1">
				<tr>
					<td>사진</td>
				</tr>
				<tr>
					<td>${p.gd_picorg}</td>
				</tr>
				<tr>
					<td>가드너 이름</td>
				</tr>
				<tr>
					<td>${p.gd_name}</td>
				</tr>
				<tr>
					<td>연락처</td>
				</tr>
				<tr>
					<td>${p.gd_hp}</td>
				</tr>
				<tr>
					<td>별점</td>
				</tr>
				<tr>
					<c:if test="${p.starAverage ne '0'}">
						<td>${p.starAverage}</td>
					</c:if>
					<c:if test="${p.starAverage eq '0'}">
						<td>등록된 별점이 없습니다.</td>
					</c:if>
				</tr>
				<!-- 주 케어 종목 -->
				<tr>
					<td>주케어종목</td>
				</tr>
				<tr>
					<td>
						<c:if test="${!empty p.gd_major1}">
						${p.gd_major1}
						</c:if>
						<c:if test="${!empty p.gd_major2}">
						,${p.gd_major2}
						</c:if>
						<c:if test="${!empty p.gd_major3}">
						,${p.gd_major3}
						</c:if>
						<c:if test="${!empty p.gd_major4}">
						,${p.gd_major4}
						</c:if>
						<c:if test="${!empty p.gd_major5}">
						,${p.gd_major5}
						</c:if>
						<c:if test="${!empty p.gd_major6}">
						,${p.gd_major6}
						</c:if>
						<c:if test="${!empty p.gd_major7}">
						,${p.gd_major7}
						</c:if>
					</td>
				</tr>
				<tr>
					<td><input type="button" id="${p.gd_no}" value="대표후기 및 예약가능시간 확인"
						onclick="javascript:riviewAndReservable(this)"></input></td>
					<!-- ajax 호출로 불러오기 -->
				</tr>
				<tr>
					<td id="riviewAndReservable">
			</table>
		</div>
	</c:forEach>
</body>
</html>