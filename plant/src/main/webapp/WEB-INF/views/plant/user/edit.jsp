<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>내 정보 수정하기</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/common.css"/>
    <link rel="stylesheet" href="/plant/css/style.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    	function goSave() {
    		if ($("#user_id").val().trim() == '') {
    			alert('아이디(이메일)을 입력해 주세요');
    			$("#user_id").focus();
    			return;
    		}
    		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    		if(!reg_email.test($("#user_id").val())) {
    			alert('아이디(이메일) 형식이 올바르지 않습니다.');
    			return;
    		}
    		var isCon = true;
    		if (!isCon) return;
    		if ($("#user_pwd").val().trim() == '') {
    			alert('비밀번호를 입력해 주세요');
    			$("#user_pwd").focus();
    			return;
    		}
    		var reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    		if( !reg_pwd.test($("#user_pwd").val()) ) {
    			alert("비밀번호는 영문,숫자,특수문자 조합으로 8자 이상 입력하세요.");
    			return;
    		}
    		if ($("#user_pwd").val() != $("#user_pwd2").val()) {
    			alert('비밀번호를 확인해주세요.');
    			$("#user_pwd2").focus();
    			return;
    		}
    		if ($("#user_email").val().trim() == '') {
    			alert('복구이메일을 입력해 주세요');
    			$("#user_email").focus();
    			return;
    		}
    		if ($("#user_name").val().trim() == '') {
    			alert('이름을 입력해 주세요');
    			$("#user_name").focus();
    			return;
    		}
    		if ($("#user_regnum").val().trim() == '') {
    			alert('주민등록번호를 입력해 주세요');
    			$("#user_regnum").focus();
    			return;
    		}
    		if ($("#user_postcode").val().trim() == '') {
    			alert('우편번호를 입력해 주세요');
    			$("#user_postcode").focus();
    			return;
    		}
    		if ($("#user_hp").val().trim() == '') {
    			alert('전화번호를 입력해 주세요');
    			$("#user_hp").focus();
    			return;
    		}
    		$("#frm").submit();
    	}
    	$(function(){
    		$("#dupCheckBtn1").click(function(){
    			if ($("#user_nick").val().trim() == '') {
    				alert('닉네임을 입력해 주세요');
    				$("#user_nick").focus();
    			} else {
	    			$.ajax({
	    				url : 'nickDupCheck.do',
	    				data:{id:$("#user_nick").val()},
	    				success:function(res) {
	    					if (res == 'true') {
	    						alert('이미 다른 회원이 사용 중인 닉네임입니다.');
	    					} else {
	    						alert('사용 가능한 닉네임입니다.');
	    					}
	    				}
	    			});
    			}
    		});

    	})
    	$(function(){
    		$("#dupCheckBtn2").click(function(){
    			if ($("#user_id").val().trim() == '') {
    				alert('아이디(이메일)을 입력해 주세요');
    				$("#user_id").focus();
    			} else {
	    			$.ajax({
	    				url : 'emailDupCheck.do',
	    				data:{id:$("#user_id").val()},
	    				success:function(res) {
	    					if (res == 'true') {
	    						alert('이미 다른 회원이 사용 중인 아이디(이메일)입니다.');
	    					} else {
	    						alert('사용 가능한 아이디입니다.');
	    					}
	    				}
	    			});
    			}
    		});
    		
    		
    		// 식물 타입
    		$(".selectList").css('display', 'none');
    		
    		$("#typeList li").on('click', function () {
    			$(".selectList").css('display', 'block');
    		})
    		
    		// 중분류
    		$("#selectType").change(function(){
    			stype = $("#selectType").val();
    			plantTypelist2(stype);
    		});
    		
    		// 소분류 -- 완전히 작물이름
    		$("#selectType2").change(function () {
    			$("#user_planttype").val( $("#selectType2").val()); 
    		})
    	})
    	
    	
    	function plantTypelist(stype) {
			$.ajax ({
				url : '/plant/plantType/plantStypeF.do',   
				method : 'GET', 
				dataTpye : 'json',
				data : { stype : stype },
				success : function(list) {
					$("#selectType").html(list);
				}, error: function (xhr, desc, err) {
					alert('에러가 발생');
					console.log(err);
					return; 
			    }
			})
		}

		function plantTypelist2(stype) {
			console.log("@@@@@2"+stype);
			$.ajax ({
				url : '/plant/plantType/plantStypeF2.do',   
				method : 'GET', 
				dataTpye : 'json',
				data : { stype : stype },
				success : function(list) {
					$("#selectType2").html(list);
				}, error: function (xhr, desc, err) {
					alert('에러가 발생');
					console.log(err);
					return; 
			    }
			})
		}
    </script>

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

</head>
  <style>
        td{padding:5px;}
	#typeList{
		display: -webkit-box;
		list-style: none;
		margin: auto;
	}
  </style>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">내 정보 수정하기</h3>
                <form name="frm" id="frm" action="edit.do" method="post" enctype="multipart/form-data">
                <table class="board_write">
                    <caption>수정</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                    	<tr>
                            <th>*닉네임</th>
                            <td>
                                <input type="text" name="user_nick" id="user_nick" value="${vo.user_nick}" class="inNextBtn" style="float:left;">
                                <span class="nick_check"><a href="javascript:;"  class="btn btn-info m-btn--air" style="float:left; width:auto; clear:none;" id="dupCheckBtn1">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*아이디(이메일)</th>
                            <td>
                                <input type="text" name="user_id" id="user_id" value="${vo.user_id}" readonly="readonly" class="inNextBtn" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="user_pwd" id="user_pwd" value="${vo.user_pwd}" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문, 특수문자 조합으로 8자 이상으로 입력해주세요.</span> </td>
                        </tr>
                        
                        <tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" name="user_pwd2" id="user_pwd2" style="float:left;"></td>
                        </tr>
                        <tr>
                            <th>*복구 이메일</th>
                            <td><input type="text" name="user_email" id="user_email" value="${vo.user_email}" style="float:left;"><span class="ptxt">복구 이메일은 비밀번호 찾기에 활용됩니다.</span> </td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td><input type="text" name="user_name" id="user_name" value="${vo.user_name}" style="float:left;" maxlength="5" required> </td>
                        </tr>
                        <tr>
                            <th>*주민등록번호</th>
                            <td>
                                <input type="text" name="user_regnum" id="user_regnum" value="${vo.user_regnum}" readonly="readonly" style="float:left;">
                            </td>
                        </tr>
                        <tr>
						  <th class="first">*주소</th>
						  <td colspan="3" class="last">
						      <input type="text" id="user_postcode" name="user_postcode" value="${vo.user_postcode}" placeholder="우편번호" readonly="readonly" /> 
								<a href="javascript:void(0);" onclick="user_postcode();return false;" class="btn btn-info m-btn--air">우편번호찾기</a>
						  <br>
						  <span style="line-height:50%"><br></span>
							  <input type="text" id="user_addr1" name="user_addr1" value="${vo.user_addr1}" placeholder="법정주소" style="width:350px" readonly="readonly" />
							  <input type="text" id="user_addr2" name="user_addr2" value="${vo.user_addr2}" placeholder="상세주소" style="width:350px" />
						  </td>
						</tr>
                        <tr>
                            <th>*연락처</th>
                            <td>
                                <input type="text" name="user_hp" id="user_hp" value="${vo.user_hp }"  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>반려식물 이름</th>
                            <td>
                                <input type="text" name="user_plantname" id="user_plantname" value="${vo.user_plantname }"  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>반려식물 품종</th>
                            <td>
	                            <div id="plantType">
									<ul id="typeList">
										<li><a id="FC" onclick="plantTypelist('FC')">식량 작물</a></li>
										<li><a id="IC" onclick="plantTypelist('IC')">특용 작물</a></li>
										<li><a id="VC" onclick="plantTypelist('VC')">채소</a></li>
										<li><a id="FT" onclick="plantTypelist('FT')">과수</a></li>
										<li><a id="FL" onclick="plantTypelist('FL')">화훼</a></li>
										<li><a id="FG" onclick="plantTypelist('FG')">녹비작물</a></li>
									</ul>
									<div class="selectList">
										<select id="selectType">
											<option>선택해주십시오</option>
										</select>
										
										<select id="selectType2">
											<option>선택해주십시오</option>
										</select>
									</div>
								</div>
                                <input type="text" name="user_planttype" id="user_planttype" value="${vo.user_planttype }"  maxlength="25" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                    	<th>반려식물 사진</th>
                            <td>
                                <input type="file" name="picorg" style="float:left;">
                                <input type="hidden" name="user_plantfile_org" value="${vo.user_plantfile_org }">
                            </td>
                    	</tr>
                        <tr>
                            <th>*관심있는 식물</th>
                            <td>
                                <input type="text" name="user_favrplant" id="user_favrplant" value="${vo.user_planttype }" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>*공개범위</th>
                            <td>
                            <select name="user_open" id="user_open">
                            <option value="0">전체</option>
                            <option value="1">닉네임과 프로필 사진 및 반려식물 정보</option>
                            <option value="2">닉네임과 프로필 사진</option>
                            </select> 
                            </td>
                        </tr>
                    </tbody>
                </table>
                        <input type="hidden" name="checkEmail" id="checkEmail" value="0"/>
                </form>
                <!-- //write--->
                <div class="btnSet clear">	
                    <div>
                    <a href="javascript:;" class="btn" onclick="goSave();">저장</a> 
                    <a href="/plant/user/myInfo.do" class="btn">취소</a></div>
                    <div>별표가 있는 항목은 필수 항목입니다.</div>
                </div>
            </div>
        </div>
        
</body>
</html>
