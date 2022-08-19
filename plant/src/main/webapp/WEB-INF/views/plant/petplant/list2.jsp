<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">

<title>반려식물 게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 체크 박스 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<!-- 사진 캐러셀 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

<!-- 전체 css -->
<!-- <link rel="stylesheet" href="/plant/css/petplant.css"/> -->
<link href="/plant/css/instagram.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
// 전역 변수로 선언 - 함수에 계속 담아서 이동 시키기 때문에 & 그때 그때 마다 저장되는 변수값이 변해서
var petboard;	// 반려식물 게시판 pk, content 배열 

$(function () {
	// 반려식물 TR 클릭 시 
	$("#petplant #petplantImgDiv").click(function(){
		var petplant = $(this).parent();
		var no = petplant.find("input[name='pet_no']").val();
		var user_no = petplant.find("input[name='user_no']").val();
		var like_check = petplant.find("input[name='like_check']").val();
		var countLike = petplant.find("input[name='countLike']").val();
		var content = petplant.find("p[name='pet_content']").text();
		var user_nick = petplant.find("input[name='user_nick']").val();
		var count_reply = petplant.find("input[name='count_reply']").val();
		
		petboard = { "no" : no, "content" : content }; 
		
		console.log("게시판 번호 내용 : "+petboard.no +" : "+ petboard.content +" : "+ user_no);
		
		var imgsrc = "<%=request.getContextPath()%>";
		
		
		$.ajax ({
			url : 'findpetplant.do',
			data : { 
				pet_no : petboard.no,
				pet_content : petboard.content,
				countLike: countLike,
				user_no : user_no,
				like_check : like_check,
				user_nick : user_nick,
				count_reply : count_reply
			},
			//dataType : 'json',
			success : function (data) {
				$("#pet").html(data);
				
				// Swiper 함수 
				var swiper = new Swiper(".mySwiper", {
			        navigation: {
			          nextEl: ".swiper-button-next",
			          prevEl: ".swiper-button-prev",
			        },
			      });
				
				document.getElementById("popup_layer").style.display = "block";
				
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		}); 
		
	}); 
	// 창 밖 누르면 창 꺼짐
	$(document).mouseup(function (e){
		var LayerPopup = $("#popup_layer");
		if(LayerPopup.has(e.target).length === 0){
			document.getElementById("popup_layer").style.display = "none";
		}
	});
	
	
	// 게시판 좋아요 클릭
	$("#petlikediv #petlike").click(function(){ 
		<c:if test="${empty loginInfo}">
			alert('로그인 후 이용해주세요');
			location.href="/plant/user/login.do";
		</c:if>
		
		var petlike = $(this).parent().parent().parent();
		var no =  petlike.find("input[name='pet_no']").val();
		var likesrc = petlike.find("#likeicon");
		var spanlike = petlike.children().find("#countLike"); 
		var countlike = petlike.children().find("#countLike").text(); 
		
		console.log("no : " + no + " src : " + likesrc + " countlike : " + countlike);	// 찍힘
		
		
		$.ajax({
			url : 'checkLike.do',
			method : 'post',
			data : { "no" : no},
			dataType : 'json',
			success : function (like) {
				if (like == 1 ){
					$(likesrc).attr('src','/plant/img/seedLike.png');
					countlike = parseInt(countlike) + 1;
					$(spanlike).text(countlike);					 
				} else {
					$(likesrc).attr('src','/plant/img/seednotLike.png');
					countlike = parseInt(countlike) - 1;
					$(spanlike).text(countlike);	
				}
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		}) 
	
		
	});
	
	
});



// 댓글 작성 폼
function addfrmreply() {
	// 게시판 번호
	console.log("게시판 번호 : "+petboard.no);
	
	var h ='';
		h += '<div class="addfrmreply" id="addfrmreply">';
		h += '	<form id="reply" method="post" action="insertReply.do">';	
		h += ' 		<h5> 댓글 작성하기 </h5>';
		h += '		<button type="button" onclick="delReplyfrm()">댓글창닫기</button>';
		h += ' 		<input type="hidden" name="pet_no" value="'+petboard.no+'"> ';
		h += '		<div class="checkbox"><input type="checkbox" name="ppr_secretCheck" id="check" value="on"> <label for="check">비밀댓글</label></div>';
		h += ' 		<p><textarea name="ppr_content" class="ppr_content" id="ppr_content"></textarea>';
		h += '		<button type="button" class="submitreply" onclick="addreply()">완료</button></p>';
		h += '</form></div>';
		
/* 	$("input:checkbox[name=ppr_secretCheck]").val();
		console.log(); */
	// 내용 div 뒤에 
	$("#content").after(h); 
	// 댓글쓰기 버튼 숨기기
	document.querySelector("#addreplyBtn").style.display = 'none';
	$("#ppr_content").focus();
	
}

//댓글-답글 달기폼
function addfrmrereply(replyno,replygno){
	
	var h ='';
		h += '<div class="addfrmrereply " id="addfrmrereply'+replyno+'">';
		h += '	<form method="post" name="rereply" action="insertreReply.do">';		
		h += ' 		<h5> 답글 작성하기 </h5>';
		h += '		<div class="checkbox"><input type="checkbox" name="ppr_secretCheck" id="check"> <label for="check">비밀댓글</label></div>';
		h += ' 			<input type="hidden" name="pet_no" value="'+petboard.no+'"> ';
		h += ' 			<input type="hidden" name="ppr_gno" value="'+replygno+'"> ';
		h += ' 			<p><textarea name="ppr_content" class="ppr_content" id="ppr_content"></textarea>';
		h += '			<button type="button" class="addrereply" onclick="addrereply('+replyno+')">완료</button>';
		h += '			<button type="button" onclick="delrereplyfrm('+replyno+')">답글창닫기</button>';
		h += '</form></div>';
		
	$("#rereplyfrm" + replyno).after(h);
	console.log("댓글 그룹 번호 : " + replygno);
	
	$("#ppr_content").focus();
	document.querySelector("#addrereplyBtn"+replyno).style.display = 'none';
	
}

//댓글 달기 창 삭제
function delReplyfrm() {
	var frm = document.getElementById("addfrmreply");  
	frm.remove();
	document.querySelector("#addreplyBtn").style.display = '';
} 
// 답글 달기 창 삭제
function delrereplyfrm(replyno) {
	var frm = document.getElementById("addfrmrereply" +replyno); 
	frm.remove();
	document.querySelector("#addrereplyBtn" + replyno).style.display = '';
} 



// 답글 저장
function addrereply(replyno) {
	var frm = $("form[name='rereply']")[0];
	var formData = new FormData(frm);
	//console.log(frm);
	
	// 답글 창 닫기
	delrereplyfrm(replyno);
		
	$.ajax ({
		method : 'post',
		url : 'insertRereply.do', 
		data : formData,
		processData: false,
        contentType: false,
		success : function (res) {
			alert("답글 작성 완료");
			replyload();
			
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log("에러 err : "+err);
            console.log("에러 xhr : "+xhr);
            return; 
        }
	}); 
}


//반려식물 댓글 답글 저장 후 load 
function replyload() {
	$.ajax ({
		url : 'replyload.do',
		data : {"no" : petboard.no},
		dataType : 'json',
		success : function (data) {
			var h = "";
			if (data.reply.list == 0){
				h += '<p><h5> 댓글 리스트가 안불러와졌음 </h5></p>';
			}else {
				for(var i=0; i<data.reply.list.length; i++ ){
					
					replygno = data.reply.list[i].ppr_gno;
					replyno = data.reply.list[i].ppr_no;
					
					h += '<div id="popup_reply">';
					h += '	<div id="rereplyfrm'+ replyno+'">';
					 	if (data.reply.list[i].ppr_nested !=0 ){
							for(var j =0; j<data.reply.list[i].ppr_nested; j++){
								h += '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0';   
							}
						}
					 	if((data.reply.list[i].ppr_secretCheck)==("on")){
							h += '비밀 댓글 입니다.';
					 	}else {
					 		h += '댓글내용 : '+data.reply.list[i].ppr_content+'';
					 	}
					h += '		<h5>'+data.reply.list[i].ppr_regdate+'</h5>';
					h += '			<span id="addrereplyBtn'+replyno+'" onclick="addfrmrereply('+replyno+','+replygno+')">답글쓰기</span>';
					h += '<p></p>';
					h += '	</div>'; 
					h += '</div>'; 
					
					// 전에 댓글있던 div를 지정
					var poreply = document.querySelector("#popup_reply");
					// 거기에 h로 바꾸고
					$(poreply).html(h);
					// 댓글달기 버튼 다시 나타나게
					document.querySelector("#addreplyBtn").style.display = '';
					
				}
 			}
	
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	}) 
}

</script>


</head>
<body>
<h2>반려식물 게시판 ${loginInfo.user_id}</h2>

<div class="popup_layer" id="popup_layer" style="display: none;">
	<div class="popup_box">
    	<div style="height: 10px; width: 375px; float: top;">
      	</div>
      	<!--팝업 컨텐츠 영역-->
      	<div class="popup_cont">
        	<div id="pet" ></div>
    	</div>
	</div>
</div>


	<main>
      <div class="feeds" id="petplant" >
      	<c:forEach items="${list}" var="list">
       
        <!-- article 프로필 사진 및 아이디-->
	        <article>
	          <header>
	            <div class="profile-of-article">
	              <img class="img-profile pic" src="https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/s320x320/28434316_190831908314778_1954023563480530944_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_ohc=srwTEwYMC28AX8gftqw&oh=98c7bf39e441e622c9723ae487cd26a0&oe=5F68C630" >
	              <span class="userID main-id point-span" >${list.user_nick }</span>
	            </div>
	            <img class="icon-react icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
	          </header>
	          
	          <!-- 넘겨줘야할 vo -->
		      <input type="hidden" name="pet_no" value="${list.pet_no }">
		      <input type="hidden" name="user_no" value="${list.user_no }">
		      <input type="hidden" name="like_check" value="${list.like_check }">
		      <input type="hidden" name="countLike" value="${list.countLike }">
		      <input type="hidden" name="user_nick" value="${list.user_nick }">
		      <input type="hidden" name="count_reply" value="${list.count_reply }">
		          
	          <!-- 상세 페이지 창 띄우는 이미지 petplantImgDiv -->
	          <div id="petplantImgDiv">
				  <!-- 이미지 -->		       
		          <div class="main-image">
		          <c:set var="pets" value="${fn:split(list.filename_real,',')}"></c:set>
				  	<c:forEach items="${pets}" var="pets" begin="0" end="0">
						<img class="pet_img"  src="<%=request.getContextPath()%>/upload/${pets}">
					</c:forEach>
		          </div>
			  </div>
		     	  
		          <div class="icons-react">
		            <div class="icons-left" id="petlikediv">
		            	<div id="petlike">
			           		<c:choose>	
								<c:when test="${list.like_check == 1}">
									<img id="likeicon" class="icon-react" src="/plant/img/seedLike.png" >
								</c:when>
								<c:otherwise>
									<img id="likeicon" class="icon-react" src="/plant/img/seednotLike.png" >
								</c:otherwise>
							</c:choose>
						</div>
		              <img class="icon-react" src="/plant/img/free-icon-oval-empty-outlined-speech-bubble-54467.png" >
		            </div>
		            <img class="icon-react" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/bookmark.png" >
		          </div>
		          
		          <!-- article text data -->
		          <div class="reaction">
			          <div class="liked-people">
			          	<p><span class="point-span" id="countLike">${list.countLike}</span>명이 좋아합니다</p>
			          </div>
		            <!-- 내용 -->
		          	<div class="description">
		            	<span class="point-span userID">${list.user_nick }</span><p name="pet_content">${list.pet_content }</p>
		          	</div>
		            <br>

		             <!-- 댓글 수 -->
		             <div class="comment-section">
			         	<div class="time-log">
		                	<span>댓글 수 ${list.count_reply}개</span>
		              	</div>
		             </div>
		             <br>
		          </div>
		    	
	        </article>
        </c:forEach>
      </div>
    </main>
    
    <%-- 
	<table border="1" >
		<c:forEach items="${list}" var="list">
			<tr id="petplant">
				<td>
					<div >
						<input type="hidden" name="pet_no"value="<c:out value='${list.pet_no }'/>" ><br>
						<textarea style="display:none;" name="pet_content" readonly="readonly">${list.pet_content }</textarea><br>
						게시판 번호 : ${list.pet_no} <br>
						<p id="pet_content">내용 : ${list.pet_content }</p> <br>
						<c:set var="pets" value="${fn:split(list.filename_real,',')}"></c:set>
					
						<c:forEach items="${pets }" var="pets" begin="0" end="0">
							<img class="pet_img"  src="<%=request.getContextPath()%>/upload/${pets}">
						</c:forEach>
					</div>
				</td>
			</tr>
			
			<tr id="pet_like">
				<td>
					<span class="replyLikeDiv" id="replyLikeDiv">
						<c:choose>	
							<c:when test="${list.like_check == 1}">
								<img id="likeicon" class="likeicon" src="/plant/img/seedLike.png" >
							</c:when>
							<c:otherwise>
								<img id="likeicon" class="likeicon" src="/plant/img/seednotLike.png" >
							</c:otherwise>
						</c:choose>
							<input type="hidden" name="pet_no" value="<c:out value='${list.pet_no }'/>" >
							<span id="countLike" name="countLike">${list.countLike}</span> 
					</span>
					<span class="">
					
					</span>
				</td>
			</tr>
		</c:forEach>
	</table>
	 --%>
	

</body>
</html>