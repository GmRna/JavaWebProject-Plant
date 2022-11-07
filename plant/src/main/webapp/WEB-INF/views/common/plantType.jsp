<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<option>선택해주십시오</option>
<c:if test="${msg == '대분류' }">	
<c:forEach items="${stype}" var="type">
	<option id="stype" name="${type.svcCodeNm}">${type.svcCodeNm}</option>
</c:forEach>
</c:if>

<c:if test="${msg == '소분류' }">	
<c:forEach items="${stype}" var="type">
	<option id="stype" name="${type.cntntsSj}">${type.cntntsSj}</option>
</c:forEach>
</c:if>

<br>
<br>