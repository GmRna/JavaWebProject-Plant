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
    <title>게시판 상세</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">공지게시판</h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                                <dt>제목 : ${data.notice_title }</dt>
                                <dd class="date">작성일 : ${data.notice_regdate } </dd>
                                <dd class="viewcount">조회수 : ${data.notice_viewcount } </dd>
                            </dl>
                        </div>
                        <div class="cont"><p>${data.notice_content } </p> </div>
                       <dl class="file">
                            <dt>첨부파일 </dt>
                            <dd>
                            <a href="/plant/common/download.jsp?oName=${URLEncoder.encode(data.filename_org,'UTF-8')}&sName=${data.filename_real}" 
                            target="_blank">${data.filename_org } </a></dd>
                        </dl>
                                    
                        <div class="btnSet clear">
                            <div class="fl_l">
                            <a href="/plant/notice/index.do" class="btn">목록으로</a></div>
                            <a href="/plant/notice/edit.do?notice_no=${data.notice_no }" class="btn">수정하기</a></div>
                            <a href="/plant/notice/delete.do?notice_no=${data.notice_no }" class="btn">삭제하기</a></div>
                        </div>
                
                    </div>
                </div>
            </div>
        </div>
        
</body>
</html>