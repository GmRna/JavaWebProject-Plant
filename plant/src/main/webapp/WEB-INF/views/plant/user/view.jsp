<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>회원 상세정보</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
</head>
 <div class="sub">
            <div class="size">
                <h3 class="sub_title">회원 상세정보</h3>
                <div class="bbs">
                    <table class="list">
                        <caption>회원 상세정보</caption>
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
                                <th>유저 번호</th>
                                <th>이름</th>
                                <th>아이디</th>
                                <th>비밀번호</th>
                                <th>복구이메일</th>
                                <th>닉네임</th>
                                <th>전화번호</th>
                                <th>주소</th>
                                <th>관심있는 식물</th>
                                <th>등록일</th>
                            </tr>
                        </thead>
                        <tbody>         
                            <tr>
                                <td>${data.totalCount-status.index-(GdVO.page-1)*GdVO.pageRow }<!-- 총 개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지 당 개수 --></td>
                                <td class="txt_l">
                                    <a href="view.do?user_no=${vo.user_no }">${vo.user_name} </a>
                                </td>
                                <td>
                                	${vo.user_id }
                                </td>
                                <td>
                                    ${vo.user_pwd }
                                </td>
                                <td>
                                    ${vo.user_email }
                                </td>
                                <td>
                                    ${vo.user_hp }
                                </td>
                                <td>
                                    ${vo.user_addr1 }
                                </td>
                                <td>
                                    ${vo.user_ableaddr }
                                </td>
                                <td>
                                    ${vo.user_career }
                                </td>
                                <td class="date">
                                	<fmt:formatDate value="${vo.user_regdate }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                

                </div>
            </div>
        </div> 
        
</body>
</html>