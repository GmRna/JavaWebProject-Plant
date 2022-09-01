<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 검색</title>

<link href="http://api.nongsaro.go.kr/css/api.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/framework.js"></script>	
<script type="text/javascript" src="http://api.nongsaro.go.kr/js/openapi_nongsaro.js"></script>
	
<script type="text/javascript">
	$.ajax ({
		​​​​​​type : 'get',
		​​​​​​url: "/plant/plant/plantbook2.do",
		​​​​​​data: {
		},
		//dataType : 'json',
		​​​​​​success: function(response){
		​​​​​​​​	console.log(response);
	​​​​​​	}, error: function (xhr, desc, err) {
	        alert('에러가 발생');
	        console.log(err);
	        return; 
	    }
	​​​​})
</script>

</head>
<body>

<div id="nongsaroApiLoadingAreaInstt"></div><!-- 기관명 목록 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea"></div><!-- 메인카테고리 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea1"></div><!-- 미들카테고리 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea3"></div><!-- 품종 리스트 HTML 로딩 영역 -->

</body>
</html>
