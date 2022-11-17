<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>질문 게시판 답변 등록</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script>
    	function goSave() {
    		frm.submit();
    	}
    </script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">질문 게시판 답변 등록</h3>
    
                <div class="bbs">
                <form method="post" name="frm" id="frm" action="reply.do" enctype="multipart/form-data" ><!-- enctype="multipart/form-data" -->
                	<input type="hidden" name="questreply_gno" value="${data.questreply_gno }">
                	<input type="hidden" name="questreply_ono" value="${data.questreply_ono }">
                	<input type="hidden" name="questreply_nested" value="${data.questreply_nested }">
                <!-- <input type="hidden" name="member_no" value="${loginInfo.no }"> -->
                    <table class="board_write">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="questreply_title" id="title" class="wid100" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="questreply_content" id="content"></textarea>
                            </td>
                        </tr>
                        <tr>
                        	<th>첨부파일</th>
                        	<td>
                        		<input type="file" name="filename">
                        	</td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btnSet"  style="text-align:right;">
                        <a class="btn" href="javascript:goSave();">저장 </a>
                        <a class="btn" href="javascript:history.back();">목록으로 </a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>