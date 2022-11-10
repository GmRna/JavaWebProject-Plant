<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<div class="feeds" id="petplant" >
	<!-- article -->
	<article  id="petplantDiv">
		<header>
	  		<!-- 게시판 작성자 회원 정보 -->
			<div class="profile-of-article">
				<img class="img-profile pic" src="<%=request.getContextPath()%>/upload/${petboard.user_plantfile_real}" >
	            <span class="userID main-id point-span"> 
	            ${petboard.user_nick} 
	            <%-- 로그인 회원 번호 : ${loginInfo.user_no} 작성자 회원 번호 : ${petboard.user_writeNo } --%>
	            </span>
			</div>
			<!-- ... 아이콘 -->
			<!-- 더보기 버튼  -->
			<div id="icon-view-view">
				<img class="icon-react icon-more" id="icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
				<div id="reportList${petboard.pet_no}"></div>
				<!-- 더보기 버튼 클릭 시 나오는 레이어 -->
				<div class="moreDiv" id="moreDiv${petboard.pet_no}" style="display:none;" >
					<c:if test="${loginUserInfo.user_no eq petboard.user_writeNo }">
						<span id="icon-edit" ><img class="icon-edit" id="icon-edit" src="/plant/img/petplant/edit.png" >수정하기</span>
					</c:if>
					<c:if test="${empty loginUserInfo or loginUserInfo.user_no ne petboard.user_writeNo}">
						<span id="icon-siren"><img class="icon-siren" id="icon-siren" src="/plant/img/petplant/siren.png" >신고하기</span>
					</c:if>
				</div>
			</div>
        </header>
        
        <!-- 사진  swiper -->
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<c:forEach items="${list.flist}" var="pic" >
					<div class="swiper-slide">
						<!-- 등록한 사진 목록 -->
						<img class="pet_img"  src="<%=request.getContextPath()%>/upload/${pic.filename_real}">
					</div>
				</c:forEach>
			</div>
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
		
		<!-- class="icons-react" -->
        <div class="icons-react">
			<div class="icons-left">
	          	<input type="hidden" name="pet_no" value="${petboard.pet_no}"> 
	         		<!-- 게시판 좋아요 눌렀는지 않눌럿는지 체크 -->
	         		<c:choose>	
						<c:when test="${petboard.like_check == 1}">
							<img id="likeicon" class="icon-react" src="/plant/img/petplant/seedLike.png" >
						</c:when>
						<c:otherwise>
							<img id="likeicon" class="icon-react" src="/plant/img/petplant/seednotLike.png" >
						</c:otherwise>
					</c:choose>
			</div>
			<div class="icon-react" id="petputDiv">
            	<c:if test="${pppcheck == 0 }">
			  		<img class="icon-react save" src="/plant/img/petplant/save1.png" >
			  	</c:if>
            	<c:if test="${pppcheck == 1 }">
			  		<img class="icon-react save" src="/plant/img/petplant/save2.png" >
			  	</c:if>
			</div>
        </div>
        
        
		<!-- article text data -->
		<div class="reaction">
			<div class="liked-people">
				<p><span class="point-span" id="countlike"> ${petboard.countLike} </span>명이 좋아합니다</p> 
			</div>
			<!-- 내용 -->
			<div class="description">
				<span class="point-span userID">${petboard.user_nick}</span><p name="pet_content">${petboard.pet_content}</p>
			</div>
		</div>    
		
		<!-- 댓글 id="replydiv" -->
		<div id="replydiv" >
			<div class="reaction reply">
			<!-- 댓글 수 -->
			    <div class="time-log">
				<span>댓글 수 ${petboard.count_reply}개</span>
				</div>
			</div>
   
			<div class="hl"></div>
			<!-- 게시판에 대한 reply 작성창 -->
			<form action="" method="post" id="replyfrm">
				<div class="comment">
					<span class="check" >
						<input type="checkbox" name="ppr_secretCheck" id="check" value="on"> <label for="check" >비밀댓글</label>
					</span>
			       	<input id="input-comment2" name="ppr_content" class="input-comment" type="text" placeholder="댓글 달기..." >
			       	<input type="hidden" name="pet_no" value="${petboard.pet_no }">
			       	<c:if test="${empty loginUserInfo}">
			      	 	<button type="button" class="submit-comment" onclick="addreplylogin()" >게시</button>
			       	</c:if>
			       	<c:if test="${!empty loginUserInfo}">
			       		<button type="button" class="submit-comment" onclick="addreply()" >게시</button>
			       	</c:if>
				</div>
			</form>
			
			<div class="hl"></div> 
  			<br>
  			
			<div class="reaction reply">        
				<!-- 댓글 내용 반복 -->
				<div class="comment-section">
				    <c:forEach items="${list.rlist}" var="rlist">
						<ul class="comments" id="comments${rlist.ppr_no}">
							<li>
								<span>
					            	<c:if test="${rlist.ppr_nested != 0 }">
								     	<c:forEach begin="1" end="${rlist.ppr_nested}">
								        	<span>&nbsp;&nbsp;&nbsp;${rlist.ppr_nested}</span>
								    	</c:forEach>
								    </c:if>
									<span class="point-span userID">${rlist.user_nick}</span>
									<input type="hidden" name="ppr_no" value="${rlist.ppr_no}">
				               		<c:if test="${empty list.rlist}">
				               			등록된 댓글이 없습니다.
				            		</c:if>
				               		<c:if test="${rlist.ppr_secretCheck eq '0'}">
				               			${rlist.ppr_content}
				               		</c:if>
				               		<c:if test="${rlist.ppr_secretCheck eq null}">
				               			${rlist.ppr_content}
				               		</c:if>
				               		<c:if test="${rlist.ppr_secretCheck eq 'on'}">
				               			<c:if test="${loginUserInfo.user_no eq petboard.user_writeNo}">
				               				<img class="comment-lock" src="/plant/img/petplant/padlock.png" > ${rlist.ppr_content}
				               			</c:if>
				               			<c:if test="${loginUserInfo.user_no ne petboard.user_writeNo}">
				               				<c:if test="${loginUserInfo.user_no eq rlist.user_no}">
				               					<img class="comment-lock" src="/plant/img/petplant/padlock.png" > ${rlist.ppr_content}
				               				</c:if>
				               				<c:if test="${loginUserInfo.user_no ne rlist.user_no}">
				               					<img class="comment-lock" src="/plant/img/petplant/padlock.png" > 비밀 댓글 입니다.
				               				</c:if>
				               			</c:if>
				               		</c:if>
								</span> 
								<c:choose>	
							  		<c:when test="${rlist.like_replycheck == 1}">
										<img id="hearticon" class="comment-heart" src="/plant/img/petplant/redheart.png" >
									</c:when>
									<c:otherwise>
				                   		<img id="hearticon" class="comment-heart" src="/plant/img/petplant/heart.png">
									</c:otherwise>
							  	</c:choose>
							</li>
			                <li>
				                <span class="time-log">
				                <c:if test="${rlist.ppr_nested != 0 }">
							     	<c:forEach begin="1" end="${rlist.ppr_nested}">
							        	&nbsp;&nbsp;&nbsp;${rlist.ppr_nested}
							    	</c:forEach>
							    </c:if>
									<span><fmt:formatDate value="${rlist.ppr_regdate}" pattern="yyyy MM dd" /></span>
									<c:choose>
										<c:when test="${rlist.user_no == loginUserInfo.user_no}">
											<c:if  test="${rlist.ppr_content eq '삭제된 댓글입니다' }">
											</c:if>
											<c:if  test="${rlist.ppr_content ne '삭제된 댓글입니다' }">
												<span id="addrereplyBtn" onclick="addfrmrereply(${rlist.ppr_no},${rlist.ppr_gno},${rlist.ppr_order},${rlist.ppr_nested})">&nbsp;&nbsp;&nbsp;답글쓰기</span>
												<span id="modreplyBtn" onclick="modfrmreply(${rlist.ppr_no},${rlist.user_no},'${rlist.ppr_content}','${rlist.ppr_secretCheck}');">&nbsp;&nbsp;&nbsp;수정</span>
												<span id="delreplyBtn" onclick="delfrmreply(${rlist.ppr_no})">&nbsp;&nbsp;&nbsp;삭제</span>
											</c:if>
										</c:when>
										<c:when test="${petboard.user_writeNo eq loginUserInfo.user_no}">
											<span id="addrereplyBtn" onclick="addfrmrereply(${rlist.ppr_no},${rlist.ppr_gno},${rlist.ppr_order},${rlist.ppr_nested})">&nbsp;&nbsp;&nbsp;답글쓰기</span>
											<span id="delreplyBtn" onclick="delfrmreply(${rlist.ppr_no})">&nbsp;&nbsp;&nbsp;삭제</span>
										</c:when>
										<%-- <c:when test="${rlist.ppr_content eq '삭제된 댓글입니다' }">
										</c:when> --%>
										<c:otherwise>
											<span id="addrereplyBtn" onclick="addfrmrereply(${rlist.ppr_no},${rlist.ppr_gno},${rlist.ppr_order},${rlist.ppr_nested})">&nbsp;&nbsp;&nbsp;답글쓰기</span>
										</c:otherwise>
									</c:choose>
				                </span>
			               </li>
						</ul>
					</c:forEach>
				</div>
			</div>
		</div>  
	</article>
</div>

<script>
console.log("petboard.like_check : " +petboard.like_check);

// 좋아요 클릭
$(function () {
	var board_no = 0;
	
	/* // 게시판 좋아요 클릭
	$(".icons-left #likeicon").click(function(){ 
		
		<c:if test="${empty loginUserInfo}">
			alert('로그인 후 이용해주세요 팝업 좋아요');
			location.href="/plant/user/login.do";
			return false;
		</c:if>
		
		var no =  $(this).parent().find("input[name='pet_no']").val();
		var likeicon = $(this);
		
		console.log('listIdx:'+listIdx);
		
		var countlike = $(this).parents().find("#countlike").text();
		var spanlike = $(this).parents().find("#countlike");
		
		var update_bottom =$(".countLike").eq(listIdx);
		var update_bottom_count =$(".countLike").eq(listIdx).text();
		
		console.log("no : " + no + " countlike : " + countlike + " update_bottom_count : " + update_bottom_count);	
		
		$.ajax({
			url : 'checkLike.do',
			method : 'post',
			data : { "no" : no },
			dataType : 'json',
			success : function (like) {
				if (like == 1 ){
					$(likeicon).attr('src','/plant/img/petplant/seedLike.png');
					countlike = parseInt(countlike) + 1;
					$(spanlike).text(countlike);
					
					$(".seedImage").eq(listIdx).attr('src','/plant/img/petplant/seedLike.png');
					update_bottom_count = update_bottom_count + 1;
					$(update_bottom).text(update_bottom_count);
					
				} else {
					$(likeicon).attr('src','/plant/img/petplant/seednotLike.png');
					countlike = parseInt(countlike) - 1;
					$(spanlike).text(countlike);
					
					$(".seedImage").eq(listIdx).attr('src','/plant/img/petplant/seednotLike.png');
					update_bottom_count = update_bottom_count - 1;
					$(update_bottom).text(update_bottom_count);
				} 
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
	}); */
	
	// 댓글 좋아요
	$(".comments #hearticon").click(function(){ 
		
		<c:if test="${empty loginUserInfo}">
			alert('로그인 후 이용해주세요 댓글 좋아요');
			location.href="/plant/user/login.do";
		</c:if>

		var replyLike= $(this).parent();
		var ppreply_no = replyLike.find("input[name='ppr_no']").val(); 
	 	var hearticon = $(this);
		//var likesrc = hearticon.find("#hearticon");
		
		console.log(" : " + ppreply_no);
		
		$.ajax({
			url : 'checkLikeReply.do',
			method : 'post',
			data : { 
				ppreply_no : ppreply_no
			},
			dataType : 'json',
			success : function (like) {
				console.log("like + " + JSON.stringify(like));
				if (like == 1 ){
					$(hearticon).attr('src','/plant/img/petplant/redheart.png');  
					console.log("좋아요 + ");
				} else {
					$(hearticon).attr('src','/plant/img/petplant/heart.png');
					console.log("좋아요 - ");
				}
			}, error: function (xhr, desc, err) {
		           alert('에러가 발생');
		           console.log(err);
		           return; 
		       }
		}) 
	});
	
	
	// 게시판 더보기 버튼 - 수정 및 신고 
	$("#icon-view-view #icon-more").click(function () {
		
		
		var petplant = $(this).parent().parent().parent();
		board_no = petplant.find("input[name='pet_no']").val();
		
		document.getElementById("moreDiv"+board_no).style.display = "";
		
		console.log("board_no : " + board_no + " 이건 상세보기");
		
<<<<<<< HEAD
=======
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
		
>>>>>>> branch 'Project' of https://github.com/GmRna/JavaWebProject-Plant.git
	}) 
	
<<<<<<< HEAD
	
	// 신고 레이어 뜸
	$(".moreDivPop #icon-siren").click(function() {
		document.getElementById("moreDivPop"+board_no).style.display = "none";
		var report_tablename = "petplant";
		
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
	$(".moreDivPop #icon-edit").click(function () {
		location.href = "editpet.do?pet_no="+board_no;
	})
	
	// 레이어 창 꺼짐
	$(document).mouseup(function (e){
		var LayerPopup = $(".moreDivPop"+board_no);
		if(LayerPopup.has(e.target).length === 0){
			document.getElementById("moreDivPop"+board_no).style.display = "none";
		}
	});
	
	
	$(".input-comment").click(function () {
		$(".submit-comment").css('color','#0095f6');
	})
=======
>>>>>>> branch 'Project' of https://github.com/GmRna/JavaWebProject-Plant.git
	
	
	
})
</script>