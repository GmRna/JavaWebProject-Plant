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
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, gd-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>마이 페이지</title>
    <link rel="stylesheet" href="/plant/css/reset.css"/>
    <link rel="stylesheet" href="/plant/css/contents.css"/>
    <link rel="stylesheet" href="/plant/css/common.css"/>
    <link rel="stylesheet" href="/plant/css/style.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        td{padding:5px;}
  	</style>
</head>
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
 <body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">내 정보</h3>
                <form name="frm" id="frm" action="myInfo.do" method="post" enctype="multipart/form-data">
                <table class="board_write">
                    <caption>내 정보</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>*아이디(이메일)</th>
                            <td>
                            	${vo.gd_id }                            
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td>
                            	${vo.gd_pwd }
                            </td>
                        </tr>
                        <tr>
                            <th>*복구 이메일</th>
                            <td>
                            	${vo.gd_email }
                            </td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td>
                            	${vo.gd_name }
                            </td>
                        </tr>
                        <tr>
                            <th>*주민등록번호</th>
                            <td>
                            	${vo.gd_regnum }
                            </td>
                        </tr>
                        <tr>
						  <th class="first">*주소</th>
						  <td colspan="3" class="last">
						      ${vo.gd_postcode } 
						  <br>
						  <span style="line-height:50%"><br></span>
							  ${vo.gd_addr1 }
							  ${vo.gd_addr2 }
						  </td>
						</tr>
                        <tr>
                            <th>*연락처</th>
                            <td>
                            	${vo.gd_hp }
                            </td>
                        </tr>
                         <tr>
                            <th>*출장가능지역</th>
                            <td>
                            	${vo.gd_ableaddr }
                            </td>
                        </tr>
                        <tr>
                            <th>*이력</th>
                            <td>
                                ${vo.gd_career }
                            </td>
                        </tr>
                        <tr>
                            <th>*프로필 사진</th>
                            <td>
                                ${vo.gd_picorg }
                            </td>
                        </tr>
                </tbody>
                <caption>가드너 회원가입</caption>
				<colgroup>
					<col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody class="addtr1">
                    <tr>
                        <th>자격증</th>
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
                       	<td>  
                            <a href="javascript:;" class="add_btn"></a>
                        </td>
                    </tr>
                </tbody>
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
                    </tbody>
                </table>                   
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
                    <a href="/plant/gd/edit.do" class="btn">수정</a> 
                    <a href="/plant/main/index.do" class="btn">홈 화면</a></div>
                    
                </div>
            </div>
        </div>  
        
        <div class='btnSet'>
		<a class='btn btn-info m-btn--air' onclick="if( confirm('정말 탈퇴하시겠습니까?') ){ href='/plant/gd/delete.do'}">탈퇴</a>
		</div>	  
		 
</body>
</html>
