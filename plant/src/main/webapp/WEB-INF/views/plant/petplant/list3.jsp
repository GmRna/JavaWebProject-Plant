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
<!-- 체크 박스 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">

<!-- 사진 캐러셀 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

<!-- 전체 css -->
<link rel="stylesheet" href="/plant/css/petplant.css"/>

<script>
// 전역 변수로 선언 - 함수에 계속 담아서 이동 시키기 때문에 & 그때 그때 마다 저장되는 변수값이 변해서
var petboard;	// 반려식물 게시판 pk, content 배열 
var replyLikeno;

$(function () {
	// 반려식물 TR 클릭 시 
	$("#petplant td").click(function(){
		var pettd = $(this);
		var no = pettd.find("input[name='pet_no']").val();
		var content =  pettd.find("textarea[name='pet_content']").val();
	
		petboard = {"no" : no, "content" : content }; 
		
		console.log("게시판 번호 내용 : "+petboard);
		
		var imgsrc = "<%=request.getContextPath()%>";
		
		replyLikeno = 0; 
		
		$.ajax ({
			url : 'findpetplant.do',
			data : {"no" : petboard.no},
			dataType : 'json',
			success : function (data) {
				var h = "";
				if(data.list == null || data.list.length == 0) {
					$("#pet").after(h);
				}
				
					h += '<div class="popup_layer" id="popup_layer" style="display: none;">';
					h += '	<div class="popup_box" id="popup_box" >';
					h += '		<div style="height: 10px; width: 375px; float: top;"> ';
					h += '  	</div>';
					h += ' 			<div class="popup_cont" >';
					h += '     			<p><h5> 작성자 : '+petboard.no+'</h5></p>';
					// 사진 캐러셀 --------------------------------------------------
						 	h += '<div class="swiper mySwiper">';
						 	h += '	<div class="swiper-wrapper">';
						for (var i=0; i<data.list.list.length; i++) {
							h += '	<div class="swiper-slide">';
							h += ' 		 <img src="'+imgsrc+'/upload/'+data.list.list[i].filename_real+'">';
							h += '	</div>';
						}
							h += '	</div>';
							h += '		<div class="swiper-button-next"></div>';
							h += '		<div class="swiper-button-prev"></div>';
							h += '</div>';
					h += ' 				<div class="content" id="content" ><p> 내용 : '+petboard.content+'</p></div>';
					h += '				<p><button type="button" id="addreplyBtn" class="addreplyBtn" onclick="addfrmreply()">댓글쓰기</button></p>';
 
					
					// 댓글 폼 -----------------------------------------------------------------------
						if (data.list.rlist == 0){
						 	h += '<div id="popup_reply">';
							h += ' 	<p><h5> 등록된 댓글이 없습니다. </h5></p><br>';
							h += '</div>'; 
						}else {
							for (var i=0; i<data.list.rlist.length; i++) {
								// 댓글 pk, 그룹번호
								replygno = data.list.rlist[i].ppr_gno;
								replyno = data.list.rlist[i].ppr_no;
								
							 	h += '<div id="popup_reply">';
							 	h += '	<div id="rereplyfrm'+ replyno+'" >';
								 	if (data.list.rlist[i].ppr_nested !=0 ){
										for(var j =0; j<data.list.rlist[i].ppr_nested; j++){
											h += '\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0';   
										}
									}
								 	if((data.list.rlist[i].ppr_secretCheck)==("on")){
										h += '<span id=""비밀 댓글 입니다.></span>';
								 	}else { 
								 		h += '<span>댓글내용 : '+data.list.rlist[i].ppr_content+' </span><br>';
								 	}
								
								// 좋아요 -------------------------------------------------------------------------------------
								h += '		<div id="replyLikeclick">';
								h += '			<div class="replyLikeDiv" id="replyLikeDiv'+replyLikeno+'">';
								h += '				<input type="hidden" name="ppr_no" value="'+replyno+'">';
								h += '				<span><img id="likeicon" src="/plant/img/seednotLike.png"></span> <span id="countLike">'+data.list.rlist[i].countLike+'</span>'; 
								h += '			</div>'; 
								h += '		</div>'; 
								h += '		<div>';
								h += '			<h5> 작성일 : '+data.list.rlist[i].ppr_regdate+'</h5>';
												// 답글 작성 폼을 여는거니까 댓글 pk
								h += '			<span id="addrereplyBtn'+replyno+'" onclick="addfrmrereply('+replyno+','+replygno+')"><h5>답글쓰기</h5></span>';
								h += '		</div>';
								h += '		<p></p>';
								h += '	</div>'; 
								h += '</div>'; 
								
								
								replyLikeno++;
							}
			 			}
					h += ' 		</div>';
					h += '	</div>';
					h += '</div>';
					
				$("#pet").after(h);
				
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
		}) 
	})
	// 창 밖 누르면 창 꺼짐
	$(document).mouseup(function (e){
		var LayerPopup = $("#popup_layer");
		if(LayerPopup.has(e.target).length === 0){
			document.getElementById("popup_layer").style.display = "none";
		}
	});
	
	
	// 게시판 좋아요 클릭
	$("#pet_like #replyLikeDiv").click(function(){ 
		
		var petlike= $(this);
		var no = petlike.find("input[name='pet_no']").val();
		var likesrc = petlike.find("#likeicon");
		var spanlike = petlike.find("#countLike"); 
		var countlike = petlike.find("#countLike").text(); 
		
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
	
	// 댓글 좋아요 클릭
	$(document).on("click", "#replyLikeclick div", function(){ 
		
		var replyLike= $(this);
		var rno = replyLike.find("input[name='ppr_no']").val(); 
		var likesrc = replyLike.find("#likeicon");
		var spanlike = replyLike.find("#countLike");  
		var countlike = replyLike.find("#countLike").text();
		
		$.ajax({
			url : 'checkLikeReply.do',
			method : 'post',
			data : { "rno" : rno },
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

// 댓글 저장
function addreply() {
	var frm = $("#reply")[0];
	var formData = new FormData(frm);
	//댓글 창닫기
	delReplyfrm();

	//document.querySelector("#addfrmrereply" + replyno).style.display = '';
	
	$.ajax ({
		method : 'post',
		url : 'insertReply.do', 
		data : formData,
		processData: false,
        contentType: false,
		success : function (res) {
			alert("댓글 작성 완료");
			replyload();
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log("에러 err : "+err);
            console.log("에러 xhr : "+xhr);
            return; 
        }
	}); 
	
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

<div id="pet" ></div>

<div> 
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
							<span id="countLike">${list.countLike}</span> 
					</span>
					<span class="">
					
					</span>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
	
	
<div class="popup_layer1" id="popup_layer" style="display: none;">
	<div class="popup_box">
    	<div style="height: 10px; width: 375px; float: top;">
      	</div>
      	<!--팝업 컨텐츠 영역-->
      	<div class="popup_cont">
        	<h5> 반려식물 팝업 </h5>
    	</div>
	</div>
</div>
	
</body>
</html>