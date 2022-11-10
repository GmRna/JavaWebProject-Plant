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
<style type="text/css">
.diarybtn{
	float: right;
}
</style>
<script type="text/javascript">
function edit(diary_no) {
	location.href = "/plant/petplantDiary/editDiary.do?diary_no="+diary_no;
}

</script>

</head>
<body class="homepage is-preload">
<div id="page-wrapper">

<section id="main">
	<div class="container">
		<article id="portfolio" class="wrapper style3">
			<div class="container">
				
				<header>
					<form id="frm" action="writedetDiary.do" method="post">
						<input type="hidden" name="diary_no" value="${diarylist.diaryVO.diary_no }">
						<input type="hidden" name="pet_regdate" value="${diarylist.diaryVO.pet_regdate }">
						<input type="hidden" name="user_plantname" value="${diarylist.diaryVO.user_plantname}">
						<input type="hidden" name="user_planttype" value="${diarylist.diaryVO.user_planttype }">
						<input type="hidden" name="diary_gno" value="${diarylist.diaryVO.diary_gno }">
						<button type="submit" class="diarybtn">쓰기</button>
					</form>
					<h2>${diarylist.diaryVO.user_plantname} 의 관찰일지</h2>
				</header>
				<div class="row">
					<c:forEach items="${diarylist.diarylist}" var="diarylist">
						<div class="col-4 col-6-medium col-12-small">
							<section class="box">
								<a href="#" class="image featured"><img src="<%=request.getContextPath()%>/upload/${diarylist.user_plantfile_real}"/></a>
								<h3><a href="#">${diarylist.diary_day}일 째 </a></h3>
								<p>제 목 : ${diarylist.diary_title}</p>
								<p>${diarylist.diary_content}</p>
								<input type="hidden" name="pet_regdate" value="${diarylist.pet_regdate }">
								<input type="hidden" name="user_plantname" value="${diarylist.user_plantname }">
								<input type="hidden" name="user_planttype" value="${diarylist.user_planttype }">
								<input type="hidden" name="diary_gno" value="${diarylist.diary_gno }">
							</section>
							<button onclick="edit(${diarylist.diary_no})">수정하기</button>
							<button onclick="(${diarylist.diary_no})">삭제하기</button>
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