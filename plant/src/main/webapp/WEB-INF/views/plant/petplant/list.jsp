<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 <%@include file ="petplantheader.jsp" %>
 
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
<link href="/plant/css/petplant/instagram.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
// 전역 변수로 선언 - 함수에 계속 담아서 이동 시키기 때문에 & 그때 그때 마다 저장되는 변수값이 변해서
var petboard;	// 반려식물 게시판 pk, content 배열
var listIdx = 0;

$(function () {
	// 반려식물 TR 클릭 시 
	$("#petplant #petplantImgDiv, .icons-react .icons-left #petreplydiv").click(function (){
		
		listIdx = $(this).index("#petplant #petplantImgDiv");
		
		var petplant = $(this).parent();
		var pet_no = petplant.find("input[name='pet_no']").val();
		var user_writeNo = petplant.find("input[name='user_writeNo']").val();
		
		petboard = { 
				"pet_no" : pet_no, 
				"user_writeNo" : user_writeNo
		}; 
		
		console.log("게시판 번호 내용 : "+petboard.pet_no +" : "+ petboard.pet_content +" : "); 

		var imgsrc = "<%=request.getContextPath()%>"; 
		 
		$.ajax ({
			url : 'findpetplant.do',
			data : { 
				pet_no : pet_no,
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
	$("#petlike #likeicon").click(function(){ 
		
		<c:if test="${empty loginUserInfo}">
			alert('로그인 후 이용해주세요like');
			return false;
		</c:if>
		
		var petlike = $(this).parent().parent().parent().parent();
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
					$(likesrc).attr('src','/plant/img/petplant/seedLike.png');
					countlike = parseInt(countlike) + 1;
					$(spanlike).text(countlike);
				} else {
					$(likesrc).attr('src','/plant/img/petplant/seednotLike.png');
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
				url : '/plant/report.do',
				method : 'get',
				data : {
					board_no : board_no,
					report_tablename : report_tablename,
				},
				success : function (data) {
					$("#report_popup_layer").remove();
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
		
		// 수정 하는 jsp로 넘어감 
		$(".moreDiv #icon-delete").click(function () {
			alert("삭제하시겠습니까?");
			$.ajax ({
				url : 'delete.do',
				data : { pet_no : board_no},
				success : function(data) {
		            console.log("성공");
				}, error: function (xhr, desc, err) {
		            alert('에러가 발생');
		            console.log(err);
		            return; 
		        }
			})
		})
		
		// 레이어 창 꺼짐
		$(document).mouseup(function (e){
			var LayerPopup = $(".moreDiv"+board_no);
			if(LayerPopup.has(e.target).length === 0){
				document.getElementById("moreDiv"+board_no).style.display = "none";
			}
		});
		
	}) 
	
	// 담기
	$(".icons-react #petputDiv").click(function () {
		<c:if test="${empty loginUserInfo}">
			alert('로그인 후 이용해주세요 put');
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
					$(petputDiv).attr('src','/plant/img/petplant/save2.png');
				} else {
					$(petputDiv).attr('src','/plant/img/petplant/save1.png');
				}
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
		
	})
	 $(window).scroll(function() {
        var scrolltop = $(document).scrollTop();
        var height = $(document).height();
        var height_win = $(window).height();
        
     	if (Math.round( $(window).scrollTop()) == $(document).height() - $(window).height()) {
        	moreList();
    	}  
     	
	});
	
})

var page = 0; 

function moreList() {
	var container = $("#container");
	
	if (page == 0) {
		page = ${petplantVO.page}+1;
		console.log("page 1 "+ page);
	}
	
	$.ajax ({
		url : '/plant/plant/list2.do',
		data : {
			page : page
		},
		success : function(data) {
			container.append(data);
			if (page == ${list.endPage }){
				endpage();
			}
			page = page+1;
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	}) 
	
}

function endpage() {
	$(window).scroll(function() {
        var scrolltop = $(document).scrollTop();
        var height = $(document).height();
        var height_win = $(window).height();
     	if (Math.round( $(window).scrollTop()) == $(document).height() - $(window).height()) {
			console.log("끝 "+ page + "endPage" + ${list.endPage });
			alert("마지막 게시글 입니다.");
    	}  
	});
}
</script>


</head>
<body>
<h2>반려식물 게시판 ${loginUserInfo.user_id}</h2>

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
<main id="container">
	<c:forEach items="${list.list}" var="list">
	<div class="feeds" id="petplant" >
    	<!-- article 프로필 사진 및 아이디-->
     		<article id="petarticle">
     		<div id="item">
				<header>
					<div class="profile-of-article">
						<img class="img-profile pic" src="<%=request.getContextPath()%>/upload/${list.user_plantfile_real}" >
						<span class="userID main-id point-span" >${list.user_nick }</span>
					</div>
					<!-- 더보기 버튼  -->
					<div id="icon-react">
						<img class="icon-react icon-more" id="icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
						<div id="reportList${list.pet_no}"></div>
						<!-- 더보기 버튼 클릭 시 나오는 레이어 -->
						<div class="moreDiv" id="moreDiv${list.pet_no}" style="display:none;" >
							<c:if test="${loginUserInfo.user_no eq list.user_writeNo }">
								<span id="icon-edit" ><img class="icon-edit" id="icon-edit" src="/plant/img/petplant/edit.png" >수정하기</span>
								<span id="icon-delete" ><img class="icon-edit" id="icon-delete" src="/plant/img/petplant/edit.png" >삭제하기</span>
							</c:if>
							<c:if test="${empty loginUserInfo or loginUserInfo.user_no ne list.user_writeNo}">
								<span id="icon-siren"><img class="icon-siren" id="icon-siren" src="/plant/img/petplant/siren.png" >신고하기</span>
							</c:if>
						</div>
					</div>
				</header>
       
				<!-- 넘겨줘야할 vo -->
				<input type="hidden" name="pet_no" value="${list.pet_no }">
				<input type="hidden" name="user_writeNo" value="${list.user_writeNo }">
				<input type="hidden" name="like_check" value="${list.like_check }">
			    <input type="hidden" name="user_nick" value="${list.user_nick }">
			    <input type="hidden" name="count_reply" value="${list.count_reply }">
			    <input type="hidden" name="user_plantfile_real" value="${list.user_plantfile_real}">
        
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
   	  			<!-- 아이콘들 -->
				<div class="icons-react">
			        <div class="icons-left" id="petlikediv">
			        	<input type="hidden" name="pet_no" value="${list.pet_no }">
				<input type="hidden" name="user_writeNo" value="${list.user_writeNo }">
			        	<!-- 좋아요 아이콘 -->
						<div id="petlike">
							<c:choose>	
								<c:when test="${list.like_check == 1}">
									<img id="likeicon" class="icon-react seedImage" src="/plant/img/petplant/seedLike.png" >
								</c:when>
							<c:otherwise>
								<img id="likeicon" class="icon-react seedImage" src="/plant/img/petplant/seednotLike.png" >
							</c:otherwise>
							</c:choose>
						</div>
						<!-- 댓글 아이콘 -->
					    <img class="icons-left" id="petreplydiv" src="/plant/img/petplant/speech-bubble.png" >
					</div>
					<!-- 담기 아이콘 -->
					<div class="icon-react" id="petputDiv" >
			          	<c:if test="${list.ppp_check == 0 }">
					 		<img class="icon-react save" src="/plant/img/petplant/save1.png" >
					 	</c:if>
			          	<c:if test="${list.ppp_check == 1 }"> 
					 		<img class="icon-react save" src="/plant/img/petplant/save2.png" >
					 	</c:if>
					 </div>
				</div>
        
		        <!-- article text data -->
		        <div class="reaction">
					<div class="liked-people">
						<p><span class="point-span countLike" id="countLike">${list.countLike}</span>명이 좋아합니다</p>
					</div>
		          	<!-- 내용 -->
		        	<div class="description" id="description">
		          		<p id="pet_content" class="pet_content"><span class="point-span userID">${list.user_nick }</span>${list.pet_content }</p>
		          		<%-- <span id="pet_contentmore${list.pet_no}" class="pet_contentmore" onclick="morecontent(${list.pet_no })"> more </span> --%>
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
			</div>			
		</article>
	</div>
    </c:forEach>

