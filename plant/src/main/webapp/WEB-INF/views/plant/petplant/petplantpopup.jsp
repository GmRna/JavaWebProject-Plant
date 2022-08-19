<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		      <div class="feeds" id="petplant" >
		        <!-- article -->
			        <article  id="petplantDiv">
			          <header>
			            <div class="profile-of-article">
			              <img class="img-profile pic" src="회원 프로필사진" >
						  <!-- 회원 닉네임 -->
			              <span class="userID main-id point-span">${petboard.user_nick}</span>
			            </div>
			            <!-- ... 아이콘 -->
			            <img class="icon-react icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
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
			          
			          <div class="icons-react">
			            <div class="icons-left">
			           		<!-- 게시판 좋아요 눌렀는지 않눌럿는지 체크 -->
			           		<c:choose>	
								<c:when test="${petboard.like_check == 1}">
									<img id="likeicon" class="icon-react" src="/plant/img/seedLike.png" >
								</c:when>
								<c:otherwise>
									<img id="likeicon" class="icon-react" src="/plant/img/seednotLike.png" >
								</c:otherwise>
							</c:choose>
			              <img class="icon-react" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/comment.png" >
			            </div>
			            <img class="icon-react" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/bookmark.png" >
			          </div>
			          
			          
			        <!-- article text data -->
					<div class="reaction">
						<div class="liked-people">
				    	    <p><span class="point-span"> ${petboard.countLike} </span>명이 좋아합니다</p>
				        </div>
			            <!-- 내용 -->
				        <div class="description">
				        	<span class="point-span userID">${petboard.user_nick}</span><p name="pet_content">${petboard.pet_content}</p>
				        </div>
			       	</div>    
				    
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
					       	<input id="input-comment2" name="ppr_content" class="input-comment" type="text" placeholder="댓글 달기..." >
					       	<input type="hidden" name="pet_no" value="${petboard.pet_no }">
					       	<button type="button" class="submit-comment" onclick="addreply()" >게시</button>
						</div>
					</form>
					<div class="hl"></div> 
				    
				    <br>
						<div class="reaction reply">        
						<!-- 댓글 내용 반복 -->
				       	<div class="comment-section">
					    <c:forEach items="${list.rlist}" var="rlist">
						       	<ul class="comments">
						        	<li>
						            	<span>
						            	<c:if test="${rlist.ppr_nested != 0 }">
									     	<c:forEach begin="1" end="${rlist.ppr_nested}">
									        	<span>&nbsp;&nbsp;&nbsp;${rlist.ppr_nested}</span>
									        </c:forEach>
									     </c:if>
						               		<span class="point-span userID">${rlist.user_nick} 댓글 번호 ${rlist.ppr_no}</span>
						               		<c:choose>
						               			<c:when test="${rlist.ppr_secretCheck eq 'on'}">
						               				<c:if test="${empty loginInfo or loginInfo.user_no != rlist.user_no or loginInfo.user_no != petboard.user_no}">
						               					<img class="comment-lock" src="/plant/img/free-icon-padlock-456112.png" > 비밀 댓글 입니다.
						               				</c:if>
						               			</c:when>
						               			<c:otherwise>
						               				${rlist.ppr_content}
						               			</c:otherwise>
						               		</c:choose>
						               		<span class="time-log">
						               			<span ><fmt:formatDate value="${rlist.ppr_regdate}" pattern="yyyy-MM-dd" /></span>
						               		</span>
						               	</span> 
						               	<c:choose>	
									  		<c:when test="${rlist.like_replycheck == 1}">
												<img id="likeicon" class="comment-heart" src="/plant/img/premium-icon-heart-2589175.png" >
											</c:when>
											<c:otherwise>
						                   		<img class="comment-heart" src="/plant/img/premium-icon-heart-2589197.png">
											</c:otherwise>
									  	</c:choose>
						               </li>
						               <!-- input 값 여기에 추가 -->
						           </ul>
						</c:forEach>
						</div>
					</div>
					</div>  
			       
			       
			       </article>
		      </div>

<script>

//댓글 저장
function addreply() {
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
			//replyload();
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log("에러 err : "+err);
            console.log("에러 xhr : "+xhr);
            return; 
        }
	}); 
	
}
/* 

//반려식물 댓글 답글 저장 후 load 
function replyload() {
	$.ajax ({
		url : 'replyload.do',
		data : { "no" : petboard.no},
		dataType : 'json',
		success : function (data) {
			
				}
 			}
	
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	}) 
}
 */

//댓글 좋아요 클릭
$(document).on("click", "#replyLikeclick div", function(){ 
	
	<c:if test="${empty loginInfo}">
		alert('로그인 후 이용해주세요');
		location.href="/plant/user/login.do";
	</c:if>

	
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


</script>