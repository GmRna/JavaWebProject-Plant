<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>가드너 목록</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
</head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>   
<body>  
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">가드너 목록</h3>
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount} 명</strong>  |  ${GdVO.page }/${data.totalPage}페이지</span></p>
                        <caption>가드너 목록</caption>
                        <colgroup>
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>가드너 번호</th>
                                <th>이름</th>
                                <th>아이디</th>
                                <th>비밀번호</th>
                                <th>복구 이메일</th>
                                <th>전화번호</th>
                                <th>출장 지역</th>
                                <th>등록일</th>
                                <th>가입 승인</th>
                            </tr>
                        </thead>
                        <tbody>
						<c:if test="${empty data.list }">
                            <tr>
                                <td class="first" colspan="8">등록된 글이 없습니다.</td>
                            </tr>
						</c:if>
                        <c:forEach var="vo" items="${data.list }" varStatus="status">            
                            <tr>
                                <td>${data.totalCount-status.index-(GdVO.page-1)*GdVO.pageRow }<!-- 총 개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지 당 개수 --></td>
                                <td class="txt_l">
                                    <a href="detail.do?gd_no=${vo.gd_no }">${vo.gd_name} </a>
                                </td>
                                <td>
                                	${vo.gd_id }
                                </td>
                                <td>
                                    ${vo.gd_pwd }
                                </td>
                                <td>
                                    ${vo.gd_email }
                                </td>
                                <td>
                                    ${vo.gd_hp }
                                </td>
                                <td>
                                    ${vo.gd_ableaddr }
                                </td>
                                <td class="date">
                               		<fmt:formatDate value="${vo.gd_regdate }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>
                                </td>
                                <c:choose>
                                   	<c:when test="${vo.gd_acc == 0}">
		  	 							<td>승인대기</td>
		  							</c:when>
                                   	<c:when test="${vo.gd_acc == 1}">
		  	 							<td>일반회원</td>
		  							</c:when>
		  							<c:when test="${vo.gd_acc == 2}">
		  	 							<td>승인거절</td>
		  							</c:when>
		  							<c:when test="${vo.gd_acc == 3 }">
		  								<td>탈퇴처리</td>
		  							</c:when>
		  						</c:choose>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="pagenate clear">
	                       <ul class='paging'>
	                        <c:if test="${data.prev == true }">
	                        	<li><a href="list.do?page=${data.startPage-1 }&stype=${param.stype}&sword=${param.sword}"><</a>
	                        </c:if>
	                        <c:forEach var="p" begin="${data.startPage }" end="${data.endPage }">
	                            <li><a href='list.do?page=${p }&stype=${param.stype}&sword=${param.sword}' <c:if test="${noticeVO.page == p }">class='current'</c:if>>${p }</a></li>
	                        </c:forEach>
	                        <c:if test="${data.next == true }">
	                        	<li><a href="list.do?page=${data.endPage+1 }&stype=${param.stype}&sword=${param.sword}">></a>
	                        </c:if>
	                        </ul> 
	                </div>
                
                    <!-- 페이지처리 -->
                    <div class="bbsSearch">
                        <form method="get" name="searchForm" id="searchForm" action="">
                            <span class="srchSelect">
                                <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
                                    <option value="all">전체</option>
                                    <option value="gd_ableaddr">출장 지역</option>
                                </select>
                            </span>
                            <span class="searchWord">
                                <input type="text" id="sval" name="sword" value="${param.sword}"  title="검색어 입력">
                                <input type="button" id="" value="검색" title="검색">
                            </span>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div> 
        
</body>
</html>