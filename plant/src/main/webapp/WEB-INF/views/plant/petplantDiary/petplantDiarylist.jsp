<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 관찰일지 리스트</title>
</head>
<body class="homepage is-preload">
<div id="page-wrapper">

<section id="main">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Portfolio -->
				<section>
					<header class="major">
						<h2 style="text-align: center;">관찰 일지</h2>
					</header>
					<div class="row">
						<c:forEach items="${diartlist}" var="diartlist">
							<div class="col-4 col-6-medium col-12-small">
								<section class="box">
									<a href="" class="image featured"><img src="<%=request.getContextPath()%>/upload/${diartlist.user_plantfile_real}"/></a>
									<header>
										<h3 style="text-align: center;" >${diartlist.user_plantname}</h3>
									</header>
									<footer>
										<ul class="actions">
											<li><a href="#" class="button alt">더보기</a></li>
										</ul>
									</footer>
								</section>
							</div>
						</c:forEach>
					</div>
				</section>
			</div>
		</div>
	</div>
</section>
	
</div>
</body>
</html>