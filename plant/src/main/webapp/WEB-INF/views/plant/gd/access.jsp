<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<form name="frm" id="frm" action="update.do" method="post" enctype="multipart/form-data">
			<table class="board_write">
				<caption>가드너 승인처리</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                	<tr>
                    	<th>아이디(이메일)</th>
                        	<td>
                        	${vo.gd_id }
                        	</td>
                    </tr>
                    <tr>
                        <th>복구 이메일</th>
                        	<td>
                        	${vo.gd_email }
                        	</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                            <td>
                            ${vo.gd_name }
                            </td>
                    </tr>
                    <tr>
                        <th>주민등록번호</th>
                            <td>
                            ${vo.gd_regnum }
                            </td>
					</tr> 
                     <tr>
						  <th class="first">주소</th>
						  <td colspan="3" class="last">
						      ${vo.gd_postcode } 
						  <br>
						  <span style="line-height:50%"><br></span>
							  ${vo.gd_addr1 }
							  ${vo.gd_addr2 }
						  </td>
					</tr>
                    <tr>
                    	<th>연락처</th>
                        	<td>
                                ${vo.gd_hp }
                            </td>
                    </tr>
                    <tr>
                    	<th>출장가능지역</th>
                            <td>
                          		${vo.gd_ableaddr }
                            </td>
					</tr>
                </table>
                <table id="tbl" class="board_write" summary = "옵션 선택">
                <caption>가드너 회원가입</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>            
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
                            <select name="gd_acc" id="acc">
                            <option value="0">승인 대기 중</option>
                        	<option value="1">승인 완료</option>
                        	<option value="2">가입 거부</option>
                        	<option value="3">추방</option>
                            </select> 
                            </td>
                    	</tr>
                    </tbody>
                </table>                       
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
                    <a href="javascript:;" class="btn" onclick="goSave();">저장</a> 
                    <a href="/plant/gd/list.do" class="btn">취소</a>
                    </div>
                </div>
            </div>
        </div>
        
</body>
</html>