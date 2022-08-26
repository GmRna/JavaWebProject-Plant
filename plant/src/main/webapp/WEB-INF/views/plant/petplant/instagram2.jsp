<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instagram</title>
    <link href="/plant/css/instagram.css" rel="stylesheet" type="text/css" />
    <!-- favicon -->
    <link rel="icon" href="img/favicon.png">
    <link rel="instagram-icon" href="img/favicon.png">
    
</head>
<body>
 <main>
      <div class="feeds">
        <!-- article -->
        <article>
          <header>
            <div class="profile-of-article">
              <img class="img-profile pic" src="https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/s320x320/28434316_190831908314778_1954023563480530944_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_ohc=srwTEwYMC28AX8gftqw&oh=98c7bf39e441e622c9723ae487cd26a0&oe=5F68C630" >
              <span class="userID main-id point-span">회원 닉네임</span>
            </div>
            <img class="icon-react icon-more" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/more.png" >
          </header>
          <div class="main-image">
            <img src="https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/90088726_197080594911885_9097741115940523483_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=109&_nc_ohc=GoaP3WqLbWoAX-aF6Sb&oh=417a759b780627bd9f2ee22a5590d99d&oe=5F6B3319"  class="mainPic">
          </div>
          <div class="icons-react">
            <div class="icons-left">
              <img class="icon-react" src="/plant/img/seednotLike.png" >
              <img class="icon-react" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/comment.png" >
              <img class="icon-react" src="img/dm.png" >  
            </div>
            <img class="icon-react" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/bookmark.png" >
          </div>
          <!-- article text data -->
          <div class="reaction">
            <div class="liked-people">
              <img class="pic" src="https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/s150x150/89296253_1521373131359783_504744616755462144_n.jpg?_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_ohc=_9raiaB11CAAX_u7RhK&oh=c162d17b1570f31f94a1a28e19167609&oe=5F6C7A90">
              <p><span class="point-span">좋아요 수 </span>명이 좋아합니다</p>
            </div>
            <div class="description">
              <p><span class="point-span userID">회원 닉네임</span><span class="at-tag">@wkorea @gucci</span> 🌱</p>
            </div>
            <div class="comment-section">
              <ul class="comments">
                <li>
                  <span><span class="point-span userID">postmalone</span>내가 입으면 더 잘어울릴 것 같아</span>
                  <img class="comment-heart" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/bearu/heart.png" >
                </li>
                <!-- input 값 여기에 추가 -->
              </ul>
              <div class="time-log">
                <span>32분 전</span>
              </div>
            </div>
          </div>
          <div class="hl"></div>
          <div class="comment">
            <input id="input-comment" class="input-comment" type="text" placeholder="댓글 달기..." >
            <button type="submit" class="submit-comment" disabled>게시</button>
          </div>
        </article>
      </div>
    
        
    </main>
    <script src="/plant/js/instagram.js"></script>

</body>
</html>