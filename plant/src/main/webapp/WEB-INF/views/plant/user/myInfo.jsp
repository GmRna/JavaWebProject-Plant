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
    <title>마이 페이지</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <style>
        td{padding:5px;}
  	</style>
</head>
<script>
		function user_postcode(){
			new daum.Postcode({
			oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			 
			  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			  var fullAddr = ''; // 최종 주소 변수
			  var extraAddr = ''; // 조합형 주소 변수
			 
			  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			      fullAddr = data.roadAddress;
			  } else { // 사용자가 지번 주소를 선택했을 경우(J)
			      fullAddr = data.jibunAddress;
			  }
			 
			  // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			  if(data.userSelectedType === 'R'){
			      //법정동명이 있을 경우 추가한다.
			      if(data.bname !== ''){
			          extraAddr += data.bname;
			      }
			      // 건물명이 있을 경우 추가한다.
			      if(data.buildingName !== ''){
			          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			      }
			      // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
			      fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			  }
			 
			  // 우편번호와 주소 정보를 해당 필드에 넣는다.
			  document.getElementById('user_postcode').value = data.zonecode;
			  document.getElementById("user_addr1").value = fullAddr;
			  // 커서를 상세주소 필드로 이동한다.
			  document.getElementById("user_addr2").focus();
			}
			 
			}).open();
		}

</script>
 <body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">내 정보</h3>
                <form name="frm" id="frm" action="join.do" method="post" enctype="multipart/form-data">
                <table class="board_write">
                    <caption>내 정보</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                    	<tr>
                            <th>*닉네임</th>
                            <td>
                            	${vo.user_nick }	              
                            </td>
                        </tr>
                        <tr>
                            <th>*아이디(이메일)</th>
                            <td>
                            	${vo.user_id }                            
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <th>*복구 이메일</th>
                            <td>
                            	${vo.user_email }
                            </td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td>
                            	${vo.user_name }
                            </td>
                        </tr>
                        <tr>
                            <th>*주민등록번호</th>
                            <td>
                            	${vo.user_regnum }
                            </td>
                        </tr>
                        <tr>
						  <th class="first">*주소</th>
						  <td colspan="3" class="last">
						      ${vo.user_postcode } 
						  <br>
						  <span style="line-height:50%"><br></span>
							  ${vo.user_addr1 }
							  ${vo.user_addr2 }
						  </td>
						</tr>
                        <tr>
                            <th>*연락처</th>
                            <td>
                            	${vo.user_hp }
                            </td>
                        </tr>
                        <tr>
                            <th>반려식물 이름</th>
                            <td>
                                ${vo.user_plantname }
                            </td>
                        </tr>
                        <tr>
                            <th>반려식물 종류</th>
                            <td>
                                ${vo.user_planttype }
                            </td>
                        </tr>
                        <tr>
                    	<th>반려식물 사진</th>
                            <td>
                                ${vo.user_plantfile_org }
                            </td>
                    	</tr>
                        <tr>
                            <th>*관심있는 식물</th>
                            <td>
                                ${vo.user_favrplant }
                            </td>
                        </tr>
                        <tr>
                            <th>*공개범위</th>
                            <td>
                           		<c:if test="${vo.user_open == 0}">
                           		전체
                           		</c:if>
                           		<c:if test="${vo.user_open == 1}">
                           		닉네임과 프로필 사진 및 반려식물 정보
                           		</c:if>
                           		<c:if test="${vo.user_open == 2	}">
                           		닉네임과 프로필 사진
                           		</c:if>
                            </td>
                        </tr>
                    </tbody>
                </table>
                        <input type="hidden" name="checkEmail" id="checkEmail" value="0"/>
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
                    <a href="/plant/user/edit.do" class="btn">수정</a> 
                    <a href="/plant/main/index.do" class="btn">홈 화면</a></div>
                    
                </div>
            </div>
        </div>  
        
        <div class='btnSet'>
		<a class='btn btn-info m-btn--air' onclick="if( confirm('정말 탈퇴하시겠습니까?') ){ href='/plant/user/delete.do?user_no=${vo.user_no }'}">탈퇴</a>
		</div>	  
		 
</body>
</html>