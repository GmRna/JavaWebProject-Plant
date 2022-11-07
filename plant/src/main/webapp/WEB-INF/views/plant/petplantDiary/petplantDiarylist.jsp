<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 관찰일지 리스트</title>
<link rel="stylesheet" href="/plant/css/petplant/petdiary/main.css"  type="text/css"/>

<script type="text/javascript">
function getnameDiary() {
}
function gowrite() {
	location.href = "/plant/petplantDiary/writeDiary.do";
}
</script>
<style type="text/css">
#writeBtn {
	float: right;
}
</style>

</head>
<body class="homepage is-preload">
<div id="page-wrapper">

<section id="main">
	<div class="container">
		<article id="portfolio" class="wrapper style3">
			<div class="container">
				<header>
					<h2>관찰일지</h2>
					<button id="writeBtn"onclick="gowrite()">새로 쓰기</button>
				</header>
				
				<br><br><br>
				
				<div class="row">
					<c:forEach items="${diarylist}" var="diarylist">
						<div class="col-4 col-6-medium col-12-small">
							<section class="box">
								<a href="#" class="image featured"><img src="<%=request.getContextPath()%>/upload/${diarylist.user_plantfile_real}"/></a>
								<form action="listdetDiary.do" method="post" >
									<h3><a href="#">${diarylist.user_plantname}</a></h3>
									<input type="hidden" name="diary_no" value="${diarylist.diary_no}">
									<input type="hidden" name="diary_gno" value="${diarylist.diary_gno}">
									<input type="hidden" name="user_plantname" value="${diarylist.user_plantname}">
									<button type="submit" class="getnameDiary" id="getnameDiary" >더보기</button>
								</form>
							</section>
						</div>
					</c:forEach>
				</div>
			</div>
		</article>
	</div>
</section>
	
</div>
</body>
</html>