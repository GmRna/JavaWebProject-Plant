<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/views/plant/include/headHtml.jsp" %>
<script>

function goSave() {
	if ($("#notice_title").val() == "") {
		alert('제목을 입력해 주세요.');
		$("#notice_title").focus();
		return false;
	}

	if ($("#notice_content").val() == "") {
		alert('내용을 입력해 주세요.');
		$("#notice_content").focus();
		return false;
	} 
	$('#frm').submit();
}
</script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">게시물 수정</h3>
    
                <div class="bbs">
                <form method="post" name="frm" id="frm" action="update.do" enctype="multipart/form-data">
                <input type="hidden" name="notice_no" value="${data.notice_no }">
                    <table class="notice_write">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="notice_title" id="title" class="wid100" value="${data.notice_title }"/>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="notice_content" id="content" value="${data.notice_content }"></textarea>
                            </td>
                        </tr>
                        <tr>
							<th>첨부파일</th>
							<td>
								<input type="file" name="filename_org" value="${noticeimg_org}">
							</td>
						</tr>
                        </tbody>
                    </table>
                    <div class="btnSet"  style="text-align:right;">
                        <a class="btn" href="javascript:goSave();">수정</a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        
</body>
</html>
