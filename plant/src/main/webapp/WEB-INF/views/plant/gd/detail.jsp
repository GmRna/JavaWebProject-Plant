<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, gd-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>가드너 상세정보</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
</head>
<body>
 <div class="sub">
            <div class="size">
                <h3 class="sub_title">가드너 상세정보</h3>
                <div class="bbs">
                    <table class="list">
                        <caption>가드너 상세정보</caption>
                        <colgroup>
                            <col width="*" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                            <tr>							                            
                                <th>번호</th>
                                <td>${vo.gd_no }</td>
                            </tr>
                            <tr>							                            
                                <th>이름</th>
                                <td>${vo.gd_name }</td>
                            </tr>
                            <tr>							                            
                                <th>아이디</th>
                                <td>${vo.gd_id }</td>
                            </tr>
                            <tr>							                            
                                <th>비밀번호</th>
                                <td>${vo.gd_pwd }</td>
                            </tr>
                            <tr>							                            
                                <th>복구이메일</th>
                                <td>${vo.gd_email }</td>
                            </tr>
                            <tr>							                            
                                <th>전화번호</th>
                                <td>${vo.gd_hp }</td>
                            </tr>
                            <tr>							                            
                                <th>주소</th>
                                <td>${vo.gd_addr1 }</td>
                            </tr>
                            <tr>							                            
                                <th>출장지역</th>
                                <td>${vo.gd_ableaddr }</td>
                            </tr>
                            <tr>							                            
                                <th>등록일</th>
                                <td><fmt:formatDate value="${vo.gd_regdate }" pattern="yyyy년 MM월 dd일 HH시 mm분"/></td>
                            </tr>                         
                        </thead>                    
                    </table>
                    </div>
            </div>
        </div> 
	<div class='btnSet'>
		<a class='btn btn-info m-btn--air' href="/plant/gd/access.do?gd_id=${vo.gd_id }">승인 처리</a>
		<a class='btn btn-info m-btn--air' href="/plant/gd/list.do">회원 목록</a>
	</div>
</body>
</html>