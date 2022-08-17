<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려식물 게시판 등록</title>
</head>
<body>

<div class="insert">
    <form method="POST" onsubmit="return false;" enctype="multipart/form-data">
        <input type="file" onchange="addFile(this);" multiple />
        <div class="file-list"></div>
    </form>
</div>

</body>
</html>