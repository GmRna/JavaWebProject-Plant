<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, gd-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>내 정보 수정하기</title>
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
    		if ($("#gd_id").val().trim() == '') {
    			alert('아이디(이메일)을 입력해 주세요');
    			$("#gd_id").focus();
    			
    			return;
    		}
    		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    		if(!reg_email.test($("#gd_id").val())) {
    			alert('아이디(이메일) 형식이 올바르지 않습니다.');
    			return;
    		}
    		var isCon = true;
    		if (!isCon) return;
    		if ($("#gd_pwd").val().trim() == '') {
    			alert('비밀번호를 입력해 주세요');
    			$("#gd_pwd").focus();
    			return;
    		}
    		var reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    		if( !reg_pwd.test($("#gd_pwd").val()) ) {
    			alert("비밀번호는 영문,숫자,특수문자 조합으로 8자 이상 입력하세요.");
    			return;
    		}
    		if ($("#gd_pwd").val() != $("#gd_pwd2").val()) {
    			alert('비밀번호를 확인해주세요.');
    			$("#gd_pwd2").focus();
    			return;
    		}
    		if ($("#gd_name").val().trim() == '') {
    			alert('이름을 입력해 주세요');
    			$("#gd_name").focus();
    			return;
    		}
    		if ($("#gd_regnum").val().trim() == '') {
    			alert('주민등록번호를 입력해 주세요');
    			$("#gd_regnum").focus();
    			return;
    		}
    		if ($("#gd_hp").val().trim() == '') {
    			alert('전화번호를 입력해 주세요');
    			$("#gd_hp").focus();
    			return;
    		}
    		
    		/*
    		var arr1 = $("input[id='certificate']");
            var gd_certificate = [];
            for( var i=0; i<arr1.length; i++ ) {
                if( arr1[i] == true ) {
                    gd_certificate.push(arr1[i].value);
                }
            }
            
            var arr2 = $("input[id='career']");
            var gd_career = [];
            for( var i=0; i<arr2.length; i++ ) {
                if( arr2[i] == true ) {
                    gd_career.push(arr2[i].value);
                }
            }
            */
            
    		$("#frm").submit();
    	}
    	
    	$(function(){
    		$("#dupCheckBtn").click(function(){
    			if ($("#gd_id").val().trim() == '') {
    				alert('아이디(이메일)을 입력해 주세요'); 
    				$("#gd_id").focus();
    			} else {
	    			$.ajax({
	    				url : 'emailDupCheck.do',
	    				data:{id:$("#gd_id").val()},
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

    	})
    </script>
    
    <!-- 이력 -->
    <script>
        $(function() {   
        	
            $(".add_btn2").click(function() {
                var html = '<tr class="addtr extendTr">';
                html += '        <th></th>';
                html += '        <td class="padding_t">';
                html += '            <input type="text" name="gd_career" id="career">';
                html += '        </td>';
                html += '        <td>';
                html += '            <a href="javascript:;" class="minus_btn"><img src="../img/minus_ico.png"/></a>';
                html += '        </td>';
                html += '    </tr>';
                $(".addtr2").append(html);
                $(".minus_btn").off('click'); 
                $(".minus_btn").click(function() {
                    var idx = $(this).index('.minus_btn'); 
                    $(".extendTr").eq(idx).remove();
                });
            }); 
            $(".minus_btn2").click(function() {
                var idx = $(this).index('.minus_btn'); 
                $(".extendTr").eq(idx).remove();
            });
        }) 
    </script>
    
    <!-- 자격증 -->
    <script>
        $(function() {       
            $(".add_btn").click(function() {
                var html = '<tr class="addtr extendTr">';
                html += '        <th></th>';
                html += '        <td class="padding_t">';
                html += '            <select name="gd_certificate" id="certificate">';
                html += '                <option value="없음">없음</option>';
                html += '                <option value="1급 산림치유지도사">1급 산림치유지도사</option>';
                html += '                <option value="2급 산림치유지도사">2급 산림치유지도사</option>';
                html += '                <option value="나무의사">나무의사</option>';
                html += '                <option value="농림토양평가관리산업기사">농림토양평가관리산업기사</option>';
                html += '                <option value="농화학기술사">농화학기술사</option>';
                html += '                <option value="목재교육전문가">목재교육전문가</option>';
                html += '                <option value="버섯산업기사">버섯산업기사</option>';
                html += '                <option value="버섯종균기능사">버섯종균기능사</option>';
                html += '                <option value="산림교육전문가(숲 해설가)">산림교육전문가(숲 해설가)</option>';
                html += '                <option value="산림기사">산림기능사</option>';
                html += '                <option value="산림기사">산림기사</option>';
                html += '                <option value="산림기술사">산림기술사</option>';
                html += '                <option value="산림산업기사">산림산업기사</option>';
                html += '                <option value="수목치료기술자">수목치료기술자</option>';
                html += '                <option value="시설원예기사">시설원예기사</option>';
                html += '                <option value="시설원예기술사">시설원예기술사</option>';
                html += '                <option value="시설원예산업기사">시설원예산업기사</option>';
                html += '                <option value="식물보호기사">식물보호기사</option>';
                html += '                <option value="식물보호기술사">식물보호기술사</option>';
                html += '                <option value="식물보호산업기사">식물보호산업기사</option>';
                html += '                <option value="유기농업기능사">유기농업기능사</option>';
                html += '                <option value="유기농업기사">유기농업기사</option>';
                html += '                <option value="유기농업산업기사">유기농업산업기사</option>';
                html += '                <option value="임산가공기사">임산가공기사</option>';
                html += '                <option value="임산가공기능사">임산가공기능사</option>';
                html += '                <option value="임산가공산업기사">임산가공산업기사</option>';
                html += '                <option value="임업종묘기능사">임업종묘기능사</option>';
                html += '                <option value="임업종묘기사">임업종묘기사</option>';
                html += '                <option value="원예기능사">원예기능사</option>';
                html += '                <option value="자연생태복원기사">자연생태복원기사</option>';
                html += '                <option value="자연생태복원기술사">자연생태복원기술사</option>';
                html += '                <option value="자연생태복원산업기사">자연생태복원산업기사</option>';
                html += '                <option value="자연환경관리기술사">자연환경관리기술사</option>';
                html += '                <option value="조경기능사">조경기능사</option>';
                html += '                <option value="조경기사">조경기사</option>';
                html += '                <option value="조경산업기사">조경산업기사</option>';
                html += '                <option value="종자기능사">종자기능사</option>';
                html += '                <option value="종자기사">종자기사</option>';
                html += '                <option value="종자기술사">종자기술사</option>';
                html += '                <option value="종자산업기사">종자산업기사</option>';
                html += '                <option value="토양환경기사">토양환경기사</option>';
                html += '                <option value="토양환경기술사">토양환경기술사</option>';
                html += '                <option value="화훼장식기능사">화훼장식기능사</option>';
                html += '                <option value="화훼장식기사">화훼장식기사</option>';
                html += '                <option value="화훼장식산업기사">화훼장식산업기사</option>';
                html += '            </select>';
                html += '        </td>';
                html += '        <td>';
                html += '            <a href="javascript:;" class="minus_btn"><img src="../img/minus_ico.png"/></a>';
                html += '        </td>';
                html += '    </tr>';
                $(".addtr1").append(html);
                $(".minus_btn").off('click'); 
                $(".minus_btn").click(function() {
                    var idx = $(this).index('.minus_btn'); 
                    $(".extendTr").eq(idx).remove();
                });
            }); 
            
        }) 
    </script>
    
    <!-- 우편번호 -->
    <script>
		function gd_postcode(){
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
			  document.getElementById('gd_postcode').value = data.zonecode;
			  document.getElementById("gd_addr1").value = fullAddr;
			  // 커서를 상세주소 필드로 이동한다.
			  document.getElementById("gd_addr2").focus();
			}
			 
			}).open();
		}
	</script>
</head>

  <style>
        td{padding:5px;}
  </style>
  
<body>
	<div class="sub">
		<div class="size">
			<h3 class="sub_title">내 정보 수정하기</h3>
			<form name="frm" id="frm" action="edit.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="gd_no" value="${vo.gd_no }"/>
			<table class="board_write">
				<caption>내 정보 수정하기</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                	<tr>
                            <th>*아이디(이메일)</th>
                            <td>
                                <input type="text" name="gd_id" id="gd_id" class="inNextBtn" value="${vo.gd_id }" style="float:left;">
                            </td>
                    </tr>
                    <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="gd_pwd" id="gd_pwd" value="${vo.gd_pwd }" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span> </td>
                    </tr>
					<tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" name="gd_pwd2" id="gd_pwd2" style="float:left;"></td>
                    </tr>
                    <tr>
                        <th>*복구 이메일</th>
                            <td><input type="text" name="gd_email" id="gd_email" value="${vo.gd_email }" style="float:left;"> <span class="ptxt">복구 이메일은 비밀번호 찾기에 활용됩니다.</span> </td>
                    </tr>
                    <tr>
                        <th>*이름</th>
                            <td>
                            	<input type="text" name="gd_name" id="gd_name" value="${vo.gd_name }" style="float:left;"> 
                            </td>
                    </tr>
                    <tr>
                        <th>*주민등록번호</th>
                            <td>
                                <input type="text" name="gd_regnum" id="gd_regnum" value="${vo.gd_regnum }" style="float:left;">
                            </td>
					</tr> 
                    <tr>
						  <th class="first">*주소</th>
						  <td colspan="3" class="last">
						      <input type="text" id="gd_postcode" name="gd_postcode" placeholder="우편번호" value="${vo.gd_postcode }" readonly="readonly"/> 
								<a href="javascript:void(0);" onclick="gd_postcode();return false;" class="btn btn-info m-btn--air">우편번호찾기</a>
						  <br>
						  <span style="line-height:50%"><br></span>
							  <input type="text" id="gd_addr1" name="gd_addr1" placeholder="법정주소" value="${vo.gd_addr1 }" readonly="readonly" style="width:350px" />
							  <input type="text" id="gd_addr2" name="gd_addr2" placeholder="상세주소" value="${vo.gd_addr2 }" style="width:350px" />
						  </td>
						</tr>
                    <tr>
                    	<th>*연락처</th>
                        	<td>
                                <input type="text" name="gd_hp" id="gd_hp" value="${vo.gd_hp }"  maxlength="15" style="float:left;">
                            </td>
                    </tr>
                    <tr>
                    	<th>*출장가능지역</th>
                            <td>
                            <select name="gd_ableaddr" id="gd_ableaddr">
                            <option value="서울">서울</option>
                            <option value="인천">인천</option>
                            <option value="대구">대구</option>
                            <option value="부산">부산</option>
                            <option value="광주">광주</option>
                            <option value="대전/세종">대전/세종</option>
                            <option value="경기북부">경기 북부</option>
                            <option value="경기남부">경기 남부</option>
                            <option value="강원영서">강원 영서</option>
                            <option value="강원영동">강원 영동</option>
                            <option value="충청북도">충청북도</option>
                            <option value="충청남도">충청남도</option>
                            <option value="전라북도">전라북도</option>
                            <option value="전라남도">전라남도</option>
                            <option value="경상북도">경상북도</option>
                            <option value="경상남도">경상남도</option>
                            <option value="제주도">제주도</option>
                            </select> 
                            </td>
					</tr>
					<tbody class="addtr2">
                    <tr>
                    	<th>*이력</th>              		            		
                         	<c:set var="text2" value="${fn:split(vo.gd_career,',')}" />
                         	<td>
                         		<a href="javascript:;" class="add_btn2"><img src="../img/sum	_ico.png"/></a>
                         	</td>
							<c:forEach var="gd_career" items="${text2}" varStatus="varStatus">
								<tr class="addtr extendTr">
	                         		<th></th>
	                         			<td class="padding_t">
											<input type="text" name="gd_career" id="career" value="${gd_career}" style="float:left;"><br>
	                         			</td>
		                         		<td>
	                            	 		<a href="javascript:;" class="minus_btn2"><img src="../img/minus_ico.png"/></a>
	    	                     		</td>
	                     		</tr>
							</c:forEach>
                    </tr>
                    </tbody>
                    <tr>
                    	<th>*프로필 사진</th>
                            <td>
                                <input type="file" name="picorg" id="gd_picorg" style="float:left;">
                            </td>
                    </tr>
                	</tbody>
                </table>
                <table id="tbl" class="board_write" summary = "옵션 선택">
                <caption>가드너 회원가입</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody class="addtr1">
                    <tr>
                        <th>자격증</th>
	                        <c:if test="${vo.gd_certificate == null }" >
                        		<td class="padding_t">
				                	<select name="gd_certificate" id="certificate">
		                                <option value="없음">없음</option>
										<option value="1급 산림치유지도사">1급 산림치유지도사</option>
										<option value="2급 산림치유지도사">2급 산림치유지도사</option>
										<option value="나무의사">나무의사</option>
										<option value="농림토양평가관리산업기사">농림토양평가관리산업기사</option>
										<option value="농화학기술사">농화학기술사</option>
										<option value="목재교육전문가">목재교육전문가</option>									
		                                <option value="버섯산업기사">버섯산업기사</option>
										<option value="버섯종균기능사">버섯종균기능사</option>
										<option value="산림교육전문가(숲 해설가)">산림교육전문가(숲 해설가)</option>
										<option value="산림기능사">산림기능사</option>
										<option value="산림기사">산림기사</option>
										<option value="산림기술사">산림기술사</option>
										<option value="산림산업기사">산림산업기사</option>
										<option value="수목치료기술자">수목치료기술자</option>
										<option value="시설원예기사">시설원예기사</option>
										<option value="시설원예기술사">시설원예기술사</option>									
		                                <option value="시설원예산업기사">시설원예산업기사</option>
										<option value="식물보호기사">식물보호기사</option>
										<option value="식물보호기술사">식물보호기술사</option>
										<option value="식물보호산업기사">식물보호산업기사</option>
										<option value="유기농업기능사">유기농업기능사</option>
										<option value="유기농업기사">유기농업기사</option>
										<option value="유기농업산업기사">유기농업산업기사</option>
										<option value="임산가공기사">임산가공기사</option>
										<option value="임산가공기능사">임산가공기능사</option>
										<option value="임산가공산업기사">임산가공산업기사</option>									
		                                <option value="임업종묘기능사">임업종묘기능사</option>
										<option value="임업종묘기사">임업종묘기사</option>
										<option value="원예기능사">원예기능사</option>
										<option value="자연생태복원기사">자연생태복원기사</option>
										<option value="자연생태복원기술사">자연생태복원기술사</option>
										<option value="자연생태복원산업기사">자연생태복원산업기사</option>
										<option value="자연환경관리기술사">자연환경관리기술사</option>
										<option value="조경기능사">조경기능사</option>
										<option value="조경기사">조경기사</option>
										<option value="조경산업기사">조경산업기사</option>
										<option value="종자기능사">종자기능사</option>
										<option value="종자기사">종자기사</option>
										<option value="종자기술사">종자기술사</option>
										<option value="종자산업기사">종자산업기사</option>
										<option value="토양환경기사">토양환경기사</option>
										<option value="토양환경기술사">토양환경기술사</option>
										<option value="화훼장식기능사">화훼장식기능사</option>
										<option value="화훼장식기사">화훼장식기사</option>
										<option value="화훼장식산업기사">화훼장식산업기사</option>
                            		</select>                  	    	
                       			</td>
	                        </c:if>	                        
	                        <c:if test="${vo.gd_certificate ne null}">
	                        <c:set var="text" value="${fn:split(vo.gd_certificate,',')}" />
	                        <c:forEach var="gd_certificate" items="${text}" varStatus="varStatus">	                           		                 
		                        <td class="padding_t">                        
		                            <select name="gd_certificate" id="certificate">
										<option  <c:if test="${fn:contains(gd_certificate,'1급 산림치유지도사') }">select="selected"</c:if> value="1급 산림치유지도사">1급 산림치유지도사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'2급 산림치유지도사') }">select="selected"</c:if> value="2급 산림치유지도사">2급 산림치유지도사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'나무의사') }">select="selected"</c:if> value="나무의사">나무의사</option>									
										<option  <c:if test="${fn:contains(gd_certificate,'농림토양평가관리산업기사') }">select="selected"</c:if> value="농림토양평가관리산업기사">농림토양평가관리산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'농화학기술사') }">select="selected"</c:if> value="농화학기술사">농화학기술사</option>			
										<option  <c:if test="${fn:contains(gd_certificate,'목재교육전문가') }">select="selected"</c:if> value="목재교육전문가">목재교육전문가</option>
										<option  <c:if test="${fn:contains(gd_certificate,'버섯산업기사') }">select="selected"</c:if> value="버섯산업기사">버섯산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'버섯종균기능사') }">select="selected"</c:if> value="버섯종균기능사">버섯종균기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'산림교육전문가(숲 해설가)') }">select="selected"</c:if> value="산림교육전문가(숲 해설가)">산림교육전문가(숲 해설가)</option>
										<option  <c:if test="${fn:contains(gd_certificate,'산림기능사') }">select="selected"</c:if> value="산림기능사">산림기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'산림기사') }">select="selected"</c:if> value="산림기사">산림기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'산림기술사') }">select="selected"</c:if> value="산림기술사">산림기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'산림산업기사') }">select="selected"</c:if> value="산림기능사">산림산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'수목치료기술자') }">select="selected"</c:if> value="수목치료기술자">수목치료기술자</option>
										<option  <c:if test="${fn:contains(gd_certificate,'시설원예기사') }">select="selected"</c:if> value="시설원예기사">시설원예기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'시설원예기술사') }">select="selected"</c:if> value="시설원예기술사">시설원예기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'시설원예산업기사') }">select="selected"</c:if> value="시설원예산업기사">시설원예산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'식물보호기사') }">select="selected"</c:if> value="식물보호기사">식물보호기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'식물보호기술사') }">select="selected"</c:if> value="식물보호기술사">식물보호기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'식물보호산업기사') }">select="selected"</c:if> value="식물보호산업기사">식물보호산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'유기농업기능사') }">select="selected"</c:if> value="유기농업기능사">유기농업기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'유기농업기사') }">select="selected"</c:if> value="유기농업기사">유기농업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'유기농업산업기사') }">select="selected"</c:if> value="유기농업산업기사">유기농업산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'임산가공기사') }">select="selected"</c:if> value="임산가공기사">임산가공기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'임산가공기능사') }">select="selected"</c:if> value="임산가공기능사">임산가공기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'임산가공산업기사') }">select="selected"</c:if> value="임산가공산업기사">임산가공산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'임업종묘기능사') }">select="selected"</c:if> value="임업종묘기능사">임업종묘기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'임업종묘기사') }">select="selected"</c:if> value="임업종묘기사">임업종묘기사</option>							
										<option  <c:if test="${fn:contains(gd_certificate,'원예기능사') }">select="selected"</c:if> value="원예기능사">원예기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'자연생태복원기사') }">select="selected"</c:if> value="자연생태복원기사">자연생태복원기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'자연생태복원기술사') }">select="selected"</c:if> value="자연생태복원기술사">자연생태복원기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'자연생태복원산업기사') }">select="selected"</c:if> value="자연생태복원산업기사">자연생태복원산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'자연환경관리기술사') }">select="selected"</c:if> value="자연환경관리기술사">자연환경관리기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'조경기능사') }">select="selected"</c:if> value="조경기능사">조경기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'조경기사') }">select="selected"</c:if> value="조경기사">조경기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'조경산업기사') }">select="selected"</c:if> value="조경산업기사">조경산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'종자기능사') }">select="selected"</c:if> value="종자기능사">종자기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'종자기사') }">select="selected"</c:if> value="종자기사">종자기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'종자기술사') }">select="selected"</c:if> value="종자기술사">종자기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'종자산업기사') }">select="selected"</c:if> value="종자산업기사">종자산업기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'토양환경기사') }">select="selected"</c:if> value="토양환경기사">토양환경기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'토양환경기술사') }">select="selected"</c:if> value="토양환경기술사">토양환경기술사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'화훼장식기능사') }">select="selected"</c:if> value="화훼장식기능사">화훼장식기능사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'화훼장식기사') }">select="selected"</c:if> value="화훼장식기사">화훼장식기사</option>
										<option  <c:if test="${fn:contains(gd_certificate,'화훼장식산업기사') }">select="selected"</c:if> value="화훼장식산업기사">화훼장식산업기사</option>
		                            </select>                            
		                       	</td>
	                       	</c:forEach>
	                       	
                       	</c:if>
                       	<td>  
                            <a href="javascript:;" class="add_btn"><img src="../img/sum_ico.png"/></a>
                        </td>
                    </tr>
                </tbody>
                
            	</table>
                <table class="board_write">
                    <caption>가드너 회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                		<tr>
                            <th>*주 케어 종목</th>
                            <td>
                            
                				<label>
				                    <input type="checkbox" name="gd_major1" class="chk" value="분재갈이">
				                    <span class="label label-info"><small>분재 갈이</small></span>
				                </label>
 
				                <label>
				                    <input type="checkbox" name="gd_major2" class="chk" value="실내식물관리">
				                    <span class="label label-info"><small>실내 식물관리</small></span>
				                </label>

				                <label>
				                    <input type="checkbox" name="gd_major3" class="chk" value="온라인상담">
				                    <span class="label label-info"><small>온라인 상담</small></span>
				                </label>
				                
				                <label>
				                    <input type="checkbox" name="gd_major4" class="chk" value="병충해관리" >
				                    <span class="label label-info"><small>병충해 관리</small></span>
				                </label>
				                
				                <label>
				                    <input type="checkbox" name="gd_major5" class="chk" value="가지치기" >
				                    <span class="label label-info"><small>가지 치기</small></span>
				                </label>
				                
				                <label>
				                    <input type="checkbox" name="gd_major6" class="chk" value="정원 식물케어" >
				                    <span class="label label-info"><small>정원 식물케어</small></span>
				                </label>
				                
				                <label>
				                    <input type="checkbox" name="gd_major7" class="chk" value="식물생장관리" >
				                    <span class="label label-info"><small>식물 생장관리</small></span>
				                </label>
                            </td>
                        </tr>
                    </tbody>
                </table>                       
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
                    <a href="javascript:;" class="btn" onclick="goSave();">저장</a> 
                    <a href="/plant/gd/myInfo.do" class="btn">취소</a>
                    </div>
                    <div>별표가 있는 항목은 필수 항목입니다.</div>
                </div>
            </div>
        </div>
        
</body>
</html>
