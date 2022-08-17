<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 게시판</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript">
$(function () {
	$(".divlikeicon").click(function(){ 
		var petlike= $(this);
		var no = petlike.find("input[name='pet_no']").val();
		
		console.log("no : " + no);	// 찍힘
	})
	
})
</script>
<style type="text/css">

.carousel-container{
  width: 900px;
  margin: 30px auto;
  border: 0px solid #000;
  overflow: hidden;
  position: relative;
}
.carousel-slide{
  display: flex;
  width: 100%;
  height: 450px;
}
#prevBtn{
  position:absolute;
  top: 50%;
  left: 0;
  transform: translate(0%, -50%);
  width: 20px;
  height: 36px;
  background: url(img/carousel_prevBtn.png) no-repeat;
  text-indent: -9999px;
}
#nextBtn{
  position:absolute;
  top: 50%;
  right: 0;
  transform: translate(0%, -50%);
  width: 20px;
  height: 36px;
  background: url(img/carousel_nextBtn.png) no-repeat;
  text-indent: -9999px;
}


</style>
<script type="text/javascript">
</script>
</head>
<body>
	
<%-- 	<div class="carousel-container">
  	<div class="carousel-slide">		 		
	<c:forEach items="${list}" var="list">
		<table border="1">
			<tr>
				<td>
				<img src="<%=request.getContextPath()%>/upload/${list.filename_real}">
				</td>
			</tr>
		</table>
	</c:forEach>
	</div>		
	</div>
	<button id="prevBtn">Prev</button>
  	<button id="nextBtn">Next</button>
  	
  	<script src="/plant/js/index.js"></script> --%>
  	
  	<div class="divlikeicon">
						좋아요<img id="likeicon" src="/plant/img/seednotLike.png" >
							<input type="text" name="pet_no"value="1111" >
					</div>
		<div class="divlikeicon">
						좋아요<img id="likeicon" src="/plant/img/seednotLike.png" >
							<input type="text" name="pet_no"value="2222" >
					</div>
					<div class="divlikeicon">
						좋아요<img id="likeicon" src="/plant/img/seednotLike.png" >
							<input type="text" name="pet_no"value="3333" >
					</div>
					
  	

</body>
</html>