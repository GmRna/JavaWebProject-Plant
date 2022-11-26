<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.*" %>
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
    <title>질문 게시판 상세</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function del(no) {
    		if (confirm('삭제하시겠습니까?')) {
    			location.href='delete.do?questreply_no='+questreply_no;
    		}
    	}
    	function getComment(page) {
    		console.log(${data.questreply_no});
    		$.ajax({
    			url : "/plant/questcomment/list.do",
    			data : {
    				quest_no : ${data.questreply_no},
    				tablename : 'quest_reply',
    				page : page
    			},
    			success : function(res) {
    				$("#commentArea").html(res);
    			}
    		});
    	}
    	$(function(){
    		getComment(1);
    		
    		// 신고하기
    		var board_no = ${data.questreply_no};
    		$("#reportBtn").click(function() {
    			$.ajax ({
    				url : '/plant/report.do',
    				method : 'get',
    				data : {
    					board_no : ${data.questreply_no},
    					report_tablename : "quest_reply",
    				},
    				success : function (data) {
    					$("#reportList").after(data);
    		            console.log("????????????????????");
    				}, error: function (xhr, desc, err) {
    		            alert('에러가 발생');
    		            console.log(err);
    		            return; 
    		        }
    			})		
    		})
    		
    	});
    	function goSave() {
    		<c:if test="${empty loginUserInfo}">
	    		alert('댓글은 로그인 후 작성 가능합니다.');
	    		location.href = '/plant/user/login.do';
    		</c:if>
    		
    		if (confirm('댓글을 저장하시겠습니까?')) {
	    		$.ajax({
	    			url : "/plant/questcomment/insert.do",
	    			data : {
	    				quest_no : ${data.questreply_no},
	    				tablename : 'quest_reply',
	    				content : $("#contents").val(),
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
    	}
    	function commentDel(no) {
    		if (confirm("댓글을 삭제하시겠습니까?")) {
    			$.ajax({
    				url : '/plant/questcomment/delete.do?no='+no,
    				success : function(res) {
    					if (res.trim() == '1') {
    						alert('댓글이 정상적으로 삭제되었습니다.');
    						getComment(1);
    					}
    				}
    			})
    		}
    	}
    	
    	function goReply(no) {
    		<c:if test="${empty loginUserInfo}">
    			alert('답변 작성은 로그인 후 작성 가능합니다.');
    			location.href = '/plant/user/login.do';
			</c:if>
    		<c:if test="${!empty loginUserInfo}">
				location.href = "reply.do?questreply_no="+no;
			</c:if>
		}
    	function goLogin() {
    		location.href = '/plant/user/login.do';
		}
    	
    	
    </script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">질문 게시판</h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                                <dt>${data.questreply_title } </dt>
                                <dd class="date"><fmt:formatDate value="${data.questreply_regdate }" pattern="yyyy-MM-dd"/></dd>
                           		<dd class="viewcount"> 조회수 : ${data.questreply_viewcount }</dd>
                            </dl>
                        </div>
                        <div class="cont">
                        	<p>${data.questreply_content }</p> 
                        </div>
                        
                        <!-- report -->
                        <div id="reportList"></div>
                        
                        <dl class="file">
                            <dt>첨부파일 </dt>
                            <dd>
                            <a href="/plant/common/download.jsp?oName=${URLEncoder.encode(data.filename_org,'UTF-8')}&sName=${data.filename_real}" 
                            target="_blank">${data.filename_org } </a></dd>
                        </dl>
                                    
                        <div class="btnSet clear">
                            <div class="fl_l">
                            <c:if test="${loginUserInfo.user_no == data.user_no}">
                            	<a href="edit.do?questreply_no=${data.questreply_no}" class="btn">수정</a>
                               	<a href="delete.do?questreply_no=${data.questreply_no}" class="btn">삭제</a>
                            </c:if>
                            <c:if test="${loginUserInfo.user_no != data.user_no}">
                            	<a onclick="goReply(${data.questreply_no})" class="btn">답변</a>
                            </c:if>
                            	<a href="index.do" class="btn">목록으로</a>
                            </div>
                        </div>
                
                    </div>
                    <div>
                    <form method="post" name="frm" id="frm" action="" enctype="multipart/form-data" >
                        <table class="board_write">
                            <colgroup>
                                <col width="*" />
                                <col width="100px" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <td>
                                	<c:if test="${empty loginUserInfo}">
                                		<p onclick="goLogin()" style="text-align: center; padding-bottom: 10px; padding-left: 100px;">댓글 작성은 로그인이 필요합니다.</p>
                                   	</c:if>
                                   	<c:if test="${!empty loginUserInfo}">
	                                	<textarea name="contents" id="contents" style="height:50px;"></textarea>
                                   	</c:if>
                                </td>
                                <td>
                                    <div class="btnSet"  style="text-align:right;">
                                    	<c:if test="${!empty loginUserInfo}">
                                        	<a class="btn" href="javascript:goSave();">저장</a>
                                        </c:if>
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