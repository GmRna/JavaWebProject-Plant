<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${empty profile}">
	<div>
		<table border="1">
			<tr>
				<td>해당하는 일정에 예약가능한 가드너가 없습니다.</td>
			</tr>
		</table>
	</div>
</c:if>
<c:forEach var="p" items="${profile}">
	<h2>가드너</h2>
	<div id="${p.gd_no}">
		<table border="1">
			<tr>
				<td>사진</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<img src='<%=request.getContextPath()%>/upload/${p.gd_picreal}' style='width:90px; height:90px;' >
				</td>
			</tr>
			<tr>
				<td>가드너 이름</td>
			</tr>
			<tr>
				<td style="text-align: center;">${p.gd_name}</td>
			</tr>
			<tr>
				<td>연락처</td>
			</tr>
			<tr>
				<td style="text-align: center;">${p.gd_hp}</td>
			</tr>
			<tr>
				<td>평균 별점</td>
			</tr>
			<tr>
				<c:if test="${p.starAverage ne '0'}">
					<td style="text-align: center;">${p.starAverage}점</td>
				</c:if>
				<c:if test="${p.starAverage eq '0'}">
					<td style="text-align: center;">등록된 별점이 없습니다.</td>
				</c:if>
			</tr>
			<!-- 주 케어 종목 -->
			<tr>
				<td>주케어종목</td>
			</tr>
			<tr>
				<td style="text-align: center;">
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
				<td style="text-align: center;">
					<input type="button" id="${p.gd_no}" value="가드너 프로필 상세보기" onclick="javascript:profileView(${p.gd_no});"></input>
				</td>
			</tr>
			<!-- ajax 호출로 불러오기 리뷰와 예약가능시간 - 구현 제외 -->
			<tr>
				<td id="riviewAndReservable"></td>
			</tr>
		</table>
	</div>
</c:forEach>