<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<p><span><strong>총 ${questcomment.totalCount}개</strong>  |  ${questCommentVO.page }/${questcomment.totalPage }페이지</span></p>
                    <table class="list">
                        <colgroup>
                            <col width="80px" />
                            <col width="*" />
                            <col width="100px" />
                            <col width="200px" />
                        </colgroup>
                        <tbody>
						<c:if test="${empty questcomment.list}">
                            <tr>
                                <td class="first" colspan="8">등록된 댓글이 없습니다.</td>
                            </tr>
						</c:if>
                        <c:if test="${!empty questcomment.list}">
                        <c:forEach var="vo" items="${questcomment.list}">     
                            <tr>
                                <td class="txt_l" style="text-align:left;">
                                	${vo.user_nick }  <c:if test="${loginUserInfo.user_no eq vo.user_no }"><button onclick='commentDel(${vo.no})'>[삭제]</button></c:if>
                                </td>
                                <td colspan="2" class="writer">
                                	${vo.content}
                                </td>
                                <td class="date"><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                   <div class="pagenate clear">
                        <ul class='paging'>
                        <c:if test="${comment.prev == true }">
                        	<li><a href="javascript:getComment(${questcomment.startPage-1 })"><</a>
                        </c:if>
                        <c:forEach var="p" begin="${questcomment.startPage }" end="${questcomment.endPage }">
                            <li><a href='javascript:getComment(${p});' <c:if test="${questcommentVO.page == p }">class='current'</c:if>>${p }</a></li>
                        </c:forEach>
                        <c:if test="${comment.next == true }">
                        	<li><a href="javascript:getComment(${questcomment.endPage+1 })">></a>
                        </c:if>
                        </ul> 
                    </div>