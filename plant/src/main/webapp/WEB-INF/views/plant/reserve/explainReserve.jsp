<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가드너 예약 시스템 설명</title>
<link rel="stylesheet" href="/plant/css/header/reserve.css"  type="text/css"/>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
		$("#howUseUser").hide();
		$("#howUseGd").hide();
	})
	function goHowUse(){
        $("#howUse").toggle();
        $("#howUseUser").hide();
		$("#howUseGd").hide();
	}
	
	function goHowUseGd(){
		$("#howUseGd").toggle();
		$("#howUse").hide();
		$("#howUseUser").hide();
	}
	
	function goHowUseUser(){
		$("#howUseUser").toggle();
		$("#howUse").hide();
		$("#howUseGd").hide();
	}
</script>
</head>
<body>
	<div>
		<!-- 가드너 파견 시스템에 대한 설명 -->
		<div id="wrapper">
			<div id="main">
				<button id="" onclick='goHowUse()'>예약시스템 설명</button>
				<button onclick='goHowUseGd()'>가드너 회원 이용 방법</button>
				<button onclick='goHowUseUser()'>일반 회원 이용 방법</button>
			</div>
		
		<!-- 가드너 파견 예약시스템 설명 -->
		<div id="content">
			<div id='howUse'>
				<h2>가드너 파견 예약 시스템</h2>
				<br>
				<h3>Plant의 가드너 파견 서비스는 전문가를 자택으로 파견하여 집안에 있는 식물들을 총합적으로 관리하여 주는 식물관리 서비스 입니다.</h3>
				<p>전문가를 직접 자택에 파견하여 식물을 보고 문제상황에 맞는 적합판 판단을 통해 식물케어를 진행합니다.</p>
				<p>전문가를 자택방문을 원하지 않으시고 단순하게 문제상황의 간단한 진단을 원하시면 원격상담을 통해 자문이 가능합니다.</p>
			</div>
			<!-- 가드너 메뉴바 이용 설명 -->
			<div id='howUseGd'>
				<h2>가드너 메뉴바 이용 설명</h2>
				<br>
				<h3>가드너는 가드너 전용 메뉴바를 통해 자신의 예약과 리뷰와 일정을 관리할 수 있습니다.</h3>
				<h5>나의 예약일정 관리</h5>
				<p>달력을 클릭하여 미리 지정해둔 예약일정을 확인할 수 있고 일정의 수정과 삭제가 가능합니다.</p>
				<p>또한 예약일정도 추가가 가능합니다.</p>
				<p>예약된 일정을 확인하고 예약자의 상세정보를 확인하여 케어진행을 할 수 있습니다.</p>
				<h5>가드너 케어 진행 입력 및 리뷰관리</h5>
				<p>여기서는 케어를 진행 후 케어진행완료를 입력할수 있습니다. (이를 진행해야 정상적으로 케어진행을 확인할 수 있습니다.)</p>
				<p>케어 진행 전에는 반드시 예약자 정보를 확인하고 진행하는 것을 권장합니다.</p>
				<p>케어를 진행 후 케어진행 내용과 예약자 정보를 확인하고 케어진행 완료사진을 최소 1장이상 업로드 해주셔야합니다.</p>
				<p>케어진행이 완료된 내역에 대해서는 예약자가 진행에 대한 리뷰를 남길 수 있으며 가드너는 이를 확인하고 답글을 남길 수 있습니다.</p>
			</div>
			<!-- 유저 메뉴바 이용 설명 -->
			<div id='howUseUser'>
				<h2>유저 메뉴바 이용 설명</h2>
				<br>
				<h3>유저는 검색을 통해 케어를 예약할 수 있고 자신의 예약을 관리할 수 있습니다.</h3>
				<h5>가드너 검색</h5>
				<p>유저는 가드너 검색을 통해서 검색조건을 입력하고 예약을 진행할 수 있습니다.</p>
				<p>검색된 가드너의 프로필 카드에서 대략적인 정보를 확인 후 프로필 카드를 클릭하여 가드너의 상세 정보를 확인 할 수 있습니다.</p>
				<p>상세정보 페이지에서 가드너의 상세정보와 전체적인 예약가능 시간을 확인하고 예약페이지에서 예약일을 선택하여 예약을 진행합니다.</p>
				<p>이후 예약자의 상세정보를 입력 후 결제를 진행 후 결제완료 페이지가 나온다면 정상적으로 예약이 된 것입니다.</p>
				<h5>나의 예약관리</h5>
				<p>여기서는 달력을 클릭하여 나의 예약된 일자를 확인 할 수 있고 예약취소 및 환불처리를 진행할 수 있습니다.</p>
				<p>또한, 결제번호를 검색하여 결제정보를 확인할 수 있습니다.</p>
				<p>케어가 진행이 완료되었다면 가드너와 케어에 대한 리뷰를 남길 수 있고 이는 익명으로 처리됩니다.</p>
				<p>가드너는 남긴 리뷰에 대한 답글을 확인 할 수 있습니다.</p>
			</div>
		</div>
		</div>
	</div>
</body>
</html>