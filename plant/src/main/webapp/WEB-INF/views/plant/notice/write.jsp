<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게시판 등록</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
<script>
    	function goSave() {
    		frm.submit();
    	}
    </script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>공지사항</h2>
	  <div class="bbs">
                <form method="post" name="frm" id="frm" action="insert.do" enctype="multipart/form-data" ><!-- enctype="multipart/form-data" -->
                <!-- <input type="hidden" name="member_no" value="${loginInfo.no }"> -->
                    <table class="notice_write">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="notice_title" id="title" class="wid100" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="notice_content" id="notice_content"></textarea>
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
                        <a class="btn" href="/plant/notice/index.do">돌아가기</a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
</body>
</html>
