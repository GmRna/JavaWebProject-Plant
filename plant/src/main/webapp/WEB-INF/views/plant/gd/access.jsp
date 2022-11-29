<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, gd-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>가드너 승인처리</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <link rel="stylesheet" href="/plant/css/common.css"/>
    <link rel="stylesheet" href="/plant/css/style.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- 비밀번호 일치, 암호화 -->
    <script>
    	function goSave() {
            
    		$("#frm").submit();
    	}
    </script>
    	
</head>

  <style>
        td{padding:5px;}
  </style>
  
<body>
	<div class="sub">
		<div class="size">
			<h3 class="sub_title">가드너 승인처리</h3>
			<form name="frm" id="frm" action="access.do" method="post">
			<input type="hidden" value="${data.gd_id }" name="gd_id">
			<table class="board_write">
				<caption>가드너 승인처리</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>                	                              
                </table>
                <table id="tbl" class="board_write" summary = "옵션 선택">
                <caption>가드너 회원가입</caption>           
            	</table>
                <table class="board_write">
                    <caption>가드너 회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>회원 승인</th>
                            <td>
                            <select name="gd_acc" id="acc" value="${data.gd_acc}">                    
                            	<option <c:if test="${data.gd_acc == 0 }"> selected="selected" </c:if> value="0">승인 대기 중</option>
                            	<option <c:if test="${data.gd_acc == 1 }"> selected="selected" </c:if> value="1">승인 완료</option>
                            	<option <c:if test="${data.gd_acc == 2 }"> selected="selected" </c:if> value="2">승인 거절</option>
                            	<option <c:if test="${data.gd_acc == 3 }"> selected="selected" </c:if> value="3">탈퇴 처리됨</option>
                            </select> 
                            </td>
                    	</tr>
                    </tbody>
                    
                </table>                       
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
                    <a class="btn" href="javascript:goSave();">저장 </a>
                    <a href="/plant/gd/list.do" class="btn">취소</a>
                    </div>
                </div>
            </div>
        </div>
        
</body>
</html>