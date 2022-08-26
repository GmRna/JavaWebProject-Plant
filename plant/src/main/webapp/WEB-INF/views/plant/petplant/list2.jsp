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
var listIdx = 0;
$(function () {
	
	// 반려식물 TR 클릭 시 
	$("#petplant #petplantImgDiv, #petplant #petreplydiv").click(function(){
			
		listIdx = $(this).index("#petplant #petplantImgDiv");
		
		var petplant = $(this).parent();
		var pet_no = petplant.find("input[name='pet_no']").val();
		var user_writeNo = petplant.find("input[name='user_writeNo']").val();
		var like_check = petplant.find("input[name='like_check']").val();
		
		//var countLike = petplant.find("input[name='countLike']").val();
		
		var countLike = petplant.find("#countLike").text(); 
		var pet_content = petplant.find("p[name='pet_content']").text();
		var user_nick = petplant.find("input[name='user_nick']").val();
		var count_reply = petplant.find("input[name='count_reply']").val();
		
		petboard = { 
				"pet_no" : pet_no, 
				"pet_content" : pet_content,
				"user_writeNo" : user_writeNo,
				"like_check" : like_check,
				"countLike" : countLike,
				"count_reply" : count_reply,
				"user_nick" : user_nick 
		}; 
		
		console.log("게시판 번호 내용 : "+petboard.pet_no +" : "+ petboard.pet_content +" : "); 

		var imgsrc = "<%=request.getContextPath()%>"; 
		 
		$.ajax ({
			url : 'findpetplant.do',
			data : { 
				pet_no : pet_no,
				pet_content : pet_content,
				countLike: countLike,
				like_check : like_check,
				user_nick : user_nick,
				count_reply : count_reply,
				user_writeNo : user_writeNo
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
	// 리로드 해야함@@@@@@@@@@@@@@@@@@@@@@@@ 댓글 등록하고 끄면 댓글 수 안바뀌어잇음

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
			return false;
		</c:if>
		
		var petlike = $(this).parent().parent().parent();
		var no =  petlike.find("input[name='pet_no']").val();
		var likesrc = petlike.find("#likeicon");
		var spanlike = petlike.children().find("#countLike"); 
		var countlike = petlike.children().find("#countLike").text(); 
		
		console.log("no : " + no + " src : " + likesrc );	// 찍힘
		
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
	
	// 게시판 더보기 버튼 - 수정 및 신고 
	$("#icon-react #icon-more").click(function () {
		
		
		var petplant = $(this).parent().parent().parent();
		var board_no = petplant.find("input[name='pet_no']").val();
		var report_tablename = "petplant";
		
		document.getElementById("moreDiv"+board_no).style.display = "";
		
		console.log("board_no : " + board_no + " 이건 그냥 리스트 ");
		
		// 신고 레이어 뜸
		$(".moreDiv #icon-siren").click(function() {
			document.getElementById("moreDiv"+board_no).style.display = "none";
			
			$.ajax ({
				url : 'report.do',
				method : 'get',
				data : {
					board_no : board_no,
					report_tablename : report_tablename,
				},
				success : function (data) {
					$("#reportList"+board_no).after(data);
				}, error: function (xhr, desc, err) {
		            alert('에러가 발생');
		            console.log(err);
		            return; 
		        }
			})		
		})
		
		// 수정 하는 jsp로 넘어감 
		$(".moreDiv #icon-edit").click(function () {
			location.href = "editpet.do?pet_no="+board_no;
		})
		
		// 레이어 창 꺼짐
		$(document).mouseup(function (e){
			var LayerPopup = $(".moreDiv"+board_no);
			if(LayerPopup.has(e.target).length === 0){
				document.getElementById("moreDiv"+board_no).style.display = "none";
			}
		});
		
	}) 
	
	
	$(".icons-react #petputDiv").click(function () {
		<c:if test="${empty loginInfo}">
			alert('로그인 후 이용해주세요');
			location.href="/plant/user/login.do";
			return false;
		</c:if>
		
		var petputDiv = $(this).find(".save");
		var petplant = $(this).parent().parent();
		var pet_no = petplant.find("input[name='pet_no']").val();
		
		console.log("pet_no : " + pet_no + " 담기버튼 ");
		
		$.ajax ({
			url : 'savepetplant.do',
			method : 'post',
			data : {
				pet_no : pet_no				
			},
			dataType : 'json',
			success : function(no) {
				if(no == 1){
					console.log("no : " +no);
					$(petputDiv).attr('src','/plant/img/save2.png');
				} else {
					$(petputDiv).attr('src','/plant/img/save1.png');
				}
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
		
	})
	
	
	
	
	
	
});


//댓글 저장
function addreply() {
	
	<c:if test="${empty loginInfo}">
		alert('로그인 후 이용해주세요');
		location.href="/plant/user/login.do";
		return false;
	</c:if>
	
	var frm = $("#replyfrm")[0];
	var formData = new FormData(frm);

	
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



 //댓글-답글 달기폼
function addfrmrereply(replyno,replygno,replyono,replynested){
	 
	var h ='';
		h += '<div class="addfrmrereply " id="replyfrm'+replyno+'">';
		h += '	<form method="post" name="reply" action="insertreReply.do">';		
		h += '		<div class="comment">';
		h += '			<input type="checkbox" name="ppr_secretCheck" id="check"> <label for="check">비밀댓글</label>';
		h += ' 			<input type="hidden" name="pet_no" value="'+petboard.pet_no+'"> ';
		h += ' 			<input type="hidden" name="ppr_gno" value="'+replygno+'"> ';
		h += ' 			<input type="hidden" name="ppr_order" value="'+replyono+'"> ';
		h += ' 			<input type="hidden" name="ppr_nested" value="'+replynested+'"> ';
		h += ' 			<input id="input-comment2" name="ppr_content" class="input-comment" type="text" placeholder="답글 달기...">';
		h += '			<button type="button" class="addrereply" onclick="addrereply('+replyno+')">완료</button>';
		h += '			<button type="button" onclick="delreplyfrm('+replyno+')">답글창닫기</button>';
		h += '	</div></form>';
		h += '</div>';
		
	$("#comments"+replyno).after(h);
	console.log("댓글 그룹 번호 : " + replygno);
	console.log("댓글 번호 번호 : " + replyno);
	
	$("#ppr_content").focus();
	
} 

// 답글 달기 창 삭제
function delreplyfrm(replyno) {
	var frm = document.getElementById("replyfrm" +replyno); 
	frm.remove();
} 


// 답글 저장
function addrereply(replyno) {
	<c:if test="${empty loginInfo}">
		alert('로그인 후 이용해주세요');
		location.href="/plant/user/login.do";
		return false; 
	</c:if>
	
	var frm = $("form[name='reply']")[0];
	var formData = new FormData(frm);
	//console.log(frm);
	
		
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


// 댓글, 답글 삭제
function delfrmreply(replyno,petboardno) {
	if(confirm("댓글을 삭제 하시겠습니까?")) {
		$.ajax ({
			url : 'delreply.do',
			method: 'post',
			data : {ppr_no : replyno, pet_no : petboardno},
			success : function (data) {
				alert("댓글이 삭제 되었습니다.");
				replyload();
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
	}
}


// 댓글, 답글 수정
function modfrmreply(replyno,replyuserno,replycont,replycheck) {
	
	var h ='';
		h += '<div class="modfrmreply " id="replyfrm'+replyno+'">';
		h += '	<form method="post" name="reply" action="modReply.do">';		
		h += '		<div class="comment">';
		if(replycheck == 'on'){
			h += '		<span class="check"><input type="checkbox" name="ppr_secretCheck" id="check" value="on" checked><label for="check">비밀댓글</label></span>';
		}
		
		if(replycheck == '0'){
			h += '		<span class="check"><input type="checkbox" name="ppr_secretCheck" id="check" value="on"><label for="check">비밀댓글</label></span>';
		}
		
		h += ' 			<input type="hidden" name="pet_no" value="'+petboard.pet_no+'"> ';
		h += ' 			<input type="hidden" name="ppr_no" value="'+replyno+'"> ';
		h += ' 			<input type="text" id="input-comment2" name="ppr_content" class="input-comment" value="'+replycont+'" >';
		h += '			<button type="button" class="addrereply" onclick="modreply('+replyno+')">수정</button>';
		h += '			<button type="button" onclick="delreplyfrm('+replyno+')">답글창닫기</button>';
		h += '		</div>';
		h += '	</form>';
		h += '</div>'; 
		
	$("#comments"+replyno).after(h);
	
	$("#ppr_content").focus();
}


// 댓글, 답글 수정 
function modreply(replyno) {
	<c:if test="${empty loginInfo}">
		alert('로그인 후 이용해주세요');
		location.href="/plant/user/login.do";
		return false;
	</c:if>
	
	var frm = $("form[name='reply']")[0];
	var formData = new FormData(frm);
	
		
	$.ajax ({
		method : 'post',
		url : 'modreply.do', 
		data : formData,
		processData: false,
        contentType: false,
		success : function (res) {
			alert("댓글 수정 완료");
			replyload();
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log("에러 err : "+err);
            console.log("에러 xhr : "+xhr);
            return; 
        }
	}); 
}



function replyload() {
    $(function () {
		$.ajax ({
			url : 'findpetplant.do',
			data : petboard,
			dataTpye : 'json',
			success : function(res) {
				$("#pet").html(res);
			}
		});
	});
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
	              <img class="img-profile pic" src="" >
	              <span class="userID main-id point-span" >${list.user_nick }</span>
	            </div>
	            <!-- 더보기 버튼  -->
	            <div id="icon-react">
	            	<img class="icon-react icon-more" id="icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
	            	<div id="reportList${list.pet_no}"></div>
	            	
	            	<!-- 더보기 버튼 클릭 시 나오는 레이어 -->
	            	<div class="moreDiv" id="moreDiv${list.pet_no}" style="display:none;" >
						<c:if test="${loginInfo.user_no eq list.user_writeNo }">
							<span id="icon-edit" ><img class="icon-edit" id="icon-edit" src="/plant/img/edit.png" >수정하기</span>
						</c:if>
						<c:if test="${empty loginInfo or loginInfo.user_no ne list.user_writeNo}">
						<span id="icon-siren"><img class="icon-siren" id="icon-siren" src="/plant/img/icon-siren.png" >신고하기</span>
						</c:if>
					</div>
	            </div>
	          </header>
	          
	          <!-- 넘겨줘야할 vo -->
		      <input type="hidden" name="pet_no" value="${list.pet_no }">
		      <input type="hidden" name="user_writeNo" value="${list.user_writeNo }">
			  <input type="hidden" name="like_check" value="${list.like_check }">
		      
		      <%-- <input type="hidden" name="countLike" value="${list.countLike }"> --%>
		      
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
									<img id="likeicon" class="icon-react seedImage" src="/plant/img/seedLike.png" >
								</c:when>
								<c:otherwise>
									<img id="likeicon" class="icon-react seedImage" src="/plant/img/seednotLike.png" >
								</c:otherwise>
							</c:choose>
						</div>
					  <!-- 댓글 아이콘 -->
					  <div id="petreplydiv">
		              	<img class="icon-react" src="/plant/img/free-icon-oval-empty-outlined-speech-bubble-54467.png" >
		              </div>
		            </div>
		              <!-- 담기 아이콘 -->
		              <div class="icon-react" id="petputDiv">
		              	<c:if test="${list.ppp_check == 0 }">
					  		<img class="icon-react save" src="/plant/img/save1.png" >
					  	</c:if>
		              	<c:if test="${list.ppp_check == 1 }">
					  		<img class="icon-react save" src="/plant/img/save2.png" >
					  	</c:if>
					  </div>
		          </div>
		          
		          <!-- article text data -->
		          <div class="reaction">
			          <div class="liked-people">
			          	<p><span class="point-span countLike" id="countLike">${list.countLike}</span>명이 좋아합니다</p>
			          </div>
		            <!-- 내용 -->
		          	<div class="description">
		            	<span class="point-span userID">${list.user_nick }</span><p name="pet_content">${list.pet_content }</p>
		          	</div>
		            <br>

		             <!-- 댓글 수 -->
		             <div class="comment-section" id="reply">
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
    

</body>
</html>