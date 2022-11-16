<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 도감 요청 게시판 view</title>

<link rel="stylesheet" href="/plant/css/reset.css"/>
<link rel="stylesheet" href="/plant/css/contents.css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
body{
	padding-top: 70px;
    height: 90%;
}

#titleDiv{
	background: #89AD98;
	color: white;
}
.title{
border-top: 1px solid #221f1f;
}

.sub{
    width: 50%;
    position: relative;
    margin: auto;
    margin-top: 90px;
}
#titleDiv .viewcount, #titleDiv dd.date{
	color: #fff;
}
#view{
	border: none;
}


</style>

</head>
<script type="text/javascript">
function modifyReq(pbreq_no) {
	$("#frm").submit();
}

function listReq() {
	location.href = "/plant/plantbookreq/listBookreq.do";
}
function replyReq(pbreq_no) {
	location.href = "/plant/plantbookreq/adminreplyBookreq.do?pbreq_no="+pbreq_no;
}
</script>
<body>

<div class="sub">
	<form id="frm" method="post" action="modifyBookreq.do" enctype="multipart/form-data">
		<input type="hidden" name="pbreq_no" value="${reqlist.pbreq_no}">
		<input type="hidden" name="user_no" value="${reqlist.user_no}">
	        <div class="size">
	            <div class="bbs">
	                <div class="view" id="view">
	                    <div class="title">
							<dl id="titleDiv">
	                        	<dd class="viewcount"> 
									<c:if test="${reqlist.pbreq_status == 1}">
										요청 중
									</c:if>
									<c:if test="${reqlist.pbreq_status == 2}">
										완료
									</c:if>
									<c:if test="${reqlist.pbreq_status == 3}">
										반려
									</c:if>
								</dd>
									<dt id="title"> ${reqlist.pbreq_title} </dt>
								<dd class="date"> 
									작성일 : 
									<fmt:formatDate value="${reqlist.pbreq_regdate }" pattern="yyyy-MM-dd" />
									&nbsp;
								</dd>
								<dd class="viewcount"> 조회수 :</dd> &nbsp;&nbsp; 
								<dd class="viewcount"> 품종 : ${reqlist.pbreq_type} </dd>
								<c:if test="${reqlist.pbreq_admin ne 1}">
								</c:if>
		    				</dl>
						</div>
						<div class="cont"><p>${reqlist.pbreq_content}</p> </div>
						<dl class="file">
						    <dt>첨부파일 </dt>
						    <dd><img src="<%=request.getContextPath() %>/upload/${reqlist.filename_real }"></dd>
						</dl>
		    		</div>
		    	</div>
			</div>
	</form>
		</div>
	
	<div class='btnSet'>	
		<a class='btn btn-info m-btn--air' onclick="listReq()">목록으로 가기</a>
		<c:if test="${reqlist.user_no eq loginUserInfo.user_no}">
			<a class='btn btn-info m-btn--air' onclick="modifyReq(${reqlist.pbreq_no})">수정</a>
			<a class='btn btn-info m-btn--air' onclick="deleteReq(${reqlist.pbreq_no})">삭제</a>
		</c:if>		
		<c:if test="${!empty loginAdminInfo}">
			<a class='btn btn-info m-btn--air' onclick="replyReq(${reqlist.pbreq_no})">답변</a>
			<a class='btn btn-info m-btn--air' onclick="deleteReq(${reqlist.pbreq_no})">삭제</a>
		</c:if>		
	</div>
</body>
</html>