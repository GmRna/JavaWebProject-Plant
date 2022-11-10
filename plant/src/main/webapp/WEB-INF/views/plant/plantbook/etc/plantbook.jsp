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

nongsaroOpenApiRequest.apiKey = "20220829V3QWZNQC9LIZLZ00UXFORG";//변경할 부분 1 
nongsaroOpenApiRequest.serviceName = "varietyInfo";
nongsaroOpenApiRequest.operationName = "insttList";
nongsaroOpenApiRequest.htmlArea = "nongsaroApiLoadingAreaInstt";
nongsaroOpenApiRequest.callback = "/plant/plantbook/plantbook2.do";//변경할 부분 2  
nongsaroOpenApiRequest.numOfRows = 20;
  
console.log(nongsaroOpenApiRequest.item);  


</script>

</head>
<body>

<div id="nongsaroApiLoadingAreaInstt"></div><!-- 기관명 목록 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea"></div><!-- 메인카테고리 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea1"></div><!-- 미들카테고리 HTML 로딩 영역 -->
<div id="nongsaroApiLoadingArea3"></div><!-- 품종 리스트 HTML 로딩 영역 -->

</body>
</html>
