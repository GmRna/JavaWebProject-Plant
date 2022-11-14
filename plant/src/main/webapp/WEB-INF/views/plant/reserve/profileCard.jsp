<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
					<div class="row">
					

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
		<div class="col-4 col-6-medium col-12-small">
	
			<h2>가드너</h2>
			<div id="${p.gd_no}">
			<section class="box" >
				<table  border="1" id="gdprofile">
					<tr style="text-align: center;">
						<td colspan="2">
							프로필 사진<br>
							<img src='<%=request.getContextPath()%>/upload/${p.gd_picreal}' style='width:90px; height:90px;' >
						</td>
					</tr>
					<tr>
						<td style="width: 80px;background-color:#89AD98; color:#fff;">가드너 이름</td>
						<td>${p.gd_name}</td>
					</tr>
					<tr>
						<td style='background-color:#89AD98; color:#fff;'>연락처</td>
						<td >${p.gd_hp}</td>
					</tr>
					<tr>
						<td style='background-color:#89AD98; color:#fff;'>평균 별점</td>
						<c:if test="${p.starAverage ne '0'}">
							<td >${p.starAverage}점</td>
						</c:if>
						<c:if test="${p.starAverage eq '0'}">
							<td >등록된 별점이 없습니다.</td>
						</c:if>
					</tr>
					<!-- 주 케어 종목 -->
					<tr>
						<td style='background-color:#89AD98; color:#fff;'>주케어종목</td>
						<td >
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
					<!-- ajax 호출로 불러오기 리뷰와 예약가능시간 - 구현 제외 -->
				<!-- 	<tr>
						<td id="riviewAndReservable"></td>
					</tr> -->
				</table>
				<br>
				
				<input type="button" id="${p.gd_no}" class="gdprofileMore" value="가드너 프로필 상세보기" onclick="javascript:profileView(${p.gd_no});"></input>
</section>
			</div>
</div>
		</c:forEach>
	</div>
	