<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>질문게시판 상세</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function del(quest_no) {
    		if (confirm('삭제하시겠습니까?')) {
    			location.href='delete.do?quest_no='+quest_no;
    		}
    	}
    	
    	function getComment(page) {
    		$.ajax({
    			url : "/plant/questcomment/list.do",
    			data : {
    				quest_no : ${data.quest_no},
    				tablename : 'quest',
    				page : page
    			},
    			success : function(res) {
    				$("#commentArea").html(res);
    			}
    		});
    	}
        $(function(){
    		getComment(1);
    	});
        function goSave() {
    		<c:if test="${empty loginInfo}">
    		alert('댓글은 로그인 후 작성 가능합니다.')
    		location.href = '/plant/member/login.do';
    		</c:if>
    		
    		<c:if test="${!empty loginInfo}">
    		if (confirm('댓글을 저장하시겠습니까?')) {
        		$.ajax({
        			url :  "/plant/questcomment/insert.do",
        			data : {
        				quest_no : ${data.quest_no},
        				tablename : 'quest',
        				content : $("#contents").val(),
        				user_no : ${loginInfo.no}
        			},
        			success : function(res) {
        				if (res.trim() == "1") {
        					alert('정상적으로 댓글이 등록되었습니다.');
        					$("#contents").val('');
        					getComment(1);
        				}
        			}
        		});
    		}
    		</c:if>
    	}
        
    	function commentDel(no){
    		if(confirm("댓글을 삭제하시겠습니까?")){
    			$.ajax ({
    				url : '/plant/questcomment/delete.do?no='+no,
    				success : function(res){
    					if (res.trim() == "1"){
    					alert('댓글 삭제 완료');
    					getComment(1);
    					}
    				}
    			})
    		}
    	}
    	
  
    </script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title"><a href="index.do" class="index">질문게시판</a></h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                              <dt>${data.quest_title }</dt>
                                <dd class="date">작성일 : ${data.quest_regdate } </dd>
                                <dd class="viewcount"> 조회수 : ${data.quest_viewcount }</dd>
                            </dl>
                        </div>
                        <div class="cont"><p>${data.quest_content }</p> </div>
                        <dl class="file">
                            <dt>첨부파일 </dt>
                            <dd>
                            <a href="/plant/common/download.jsp?oName=${URLEncoder.encode(data.quest_filenameorg,'UTF-8')}&sName=${data.quest_filenamereal}" 
                            target="_blank">${data.quest_filenameorg } </a></dd>
                        </dl>
                                    
                        <div class="btnSet clear">
                            <div class="fl_l">
                            	<a href="edit.do?quest_no=${data.quest_no}" class="btn">수정</a>
                            	<a href="delete.do?quest_no=${data.quest_no}" class="btn">삭제</a>
                            	<a href="index.do" class="btn">목록으로</a>
                            </div>
                        </div>
                
                    </div>
                    <div>
                    <form method="post" name="frm" id="frm" action="" enctype="multipart/form-data" >
                        <table class="quest_write">
                            <colgroup>
                                <col width="*" />
                                <col width="100px" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <td>
                                    <textarea name="contents" id="contents" style="height:50px;"><c:if test="${empty loginInfo}">로그인이 필요합니다.</c:if></textarea>
                                </td>
                                <td>
                                    <div class="btnSet"  style="text-align:right;">
                                        <a class="btn" href="javascript:goSave();">저장 </a>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        </form>

                        <div id="commentArea"></div>
                    </div>
                </div>
            </div>
            </div>
        
</body>
</html>