<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../../common/header.jsp" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>반려식물 게시판 등록</title>

<!-- 
<link rel="stylesheet" type="text/css" href="/plant/css/instagram.css">
 -->
<style>
.insert {
    padding: 20px 30px;
    display: block;
    width: 600px;
    margin: 5vh auto;
    height: 90vh;
    border: 1px solid #dbdbdb;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.insert .file-list {
    height: 200px;
    overflow: auto;
    border: 1px solid #989898;
    padding: 10px;
}
.insert .file-list .filebox p {
    font-size: 14px;
    margin-top: 10px;
    display: inline-block;
}
.insert .file-list .filebox .delete button{
    color: #ff5353;
    margin-left: 5px;
    width: 50px;
    height: 40px;
}
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>

var fileNo = 0;
var filesArr = new Array();


/* 첨부파일 추가 */
function addFile(obj){
    var maxFileCnt = 5;   // 첨부파일 최대 개수
    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
	
    
    // 첨부파일 개수 확인
    if (curFileCnt > remainFileCnt) {
        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
    } 
 
    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {
    	
        const file = obj.files[i];
        
        // 첨부파일 검증
        if (validation(file)) {
            // 파일 배열에 담기
            var reader = new FileReader();
            reader.onload = function (event) {
            	// 파일 이미지 src 담기
            	var imgsrc = event.target.result;
				
				let htmlData = '';
				htmlData += '<div id="file' + fileNo + '" class="filebox">';
	            htmlData += '	<img src="'+imgsrc+'" style="width:90px; height=90px;" >';
	            htmlData += '   <p id="name" class="name">' + file.name + '</p>';
	            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');"><button type="button" class="far fa-minus-square">삭제</button></a>';
	            htmlData += '</div>';
	            $('.file-list').append(htmlData);
	            fileNo++;
				
				filesArr.push(file);
				console.log("file 이 어케 담기는디..?" + file);
            };
            reader.readAsDataURL(file);
            
        } else {
            continue;
        }
    }
    // 초기화
    document.querySelector("input[type=file]").value = "";
}

/* 첨부파일 검증 */
function validation(obj){
    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
    if (obj.name.length > 100) {
        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
        return false;
    } else if (obj.size > (100 * 1024 * 1024)) {
        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
        return false;
    } else if (obj.name.lastIndexOf('.') == -1) {
        alert("확장자가 없는 파일은 제외되었습니다.");
        return false;
    } else if (!fileTypes.includes(obj.type)) {
        alert("첨부가 불가능한 파일은 제외되었습니다.");
        return false;
    } else {
        return true;
    }
}

/* 첨부파일 새로 수정하는거 삭제 */
function deleteFile(num) {
    document.querySelector("#file" + num).remove();
    filesArr[num].is_delete = true;
}

/* 첨부파일 db에서 가져온거 삭제 */
function deleteFileDB(num,file_no,filename_real) {
	$.ajax ({
		url : 'deletefile.do',
		method : 'post',
		data : {
			file_no : file_no,
			filename_real : filename_real
		},
		success: function () {
            alert("등록된 파일 삭제");
        },
        error: function (xhr, desc, err) { 
            alert('에러가 발생 하였습니다.');
            console.log(err);
            return;
        }
	})
	
    document.querySelector("#file" + num).remove();
}


function filecheck() {
    // 첨부파일이 없을 때 
	var form = $(".filebox").val();
    if (form == null) {
    	alert("사진을 등록해 주세요");
    	return fales;
    	
    } else {
    	var form = document.querySelector("#editfrm");
    	var formData = new FormData(form);
    	
    	    for (var i = 0; i < filesArr.length; i++) {
    	        // 삭제되지 않은 파일만 폼데이터에 담기
    	        if (!filesArr[i].is_delete) {
    	            formData.append("file", filesArr[i]);
    	    	    console.log("file?????? : " + filesArr[i]);
    	        }
    	    }
    	    
    	    $.ajax({
    	    	method: 'POST',
    	        url: 'update.do',
    	        dataType: 'json',
    	        data: formData,
    	        async: true,
    	        contentType: false,
    	        processData: false,
    	        //enctype : 'multipart/form-data',
    	        //timeout: 30000,
    	        //cache: false,
    	        //headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
    	        success: function () {
    	            alert("성공");
    	            location.href="list.do";
    	        },
    	        error: function (xhr, desc, err) { 
    	            alert('에러가 발생 하였습니다.');
    	            console.log(err);
    	            return;
    	        }
    	    });
    	   
    }
}


function petlist() {
	location.href = "list.do";
}
</script>
</head>
<body>


<div class="insert">
	<form id="editfrm" method="post" onsubmit="return false;"  enctype="multipart/form-data" >
	    	<input type="hidden" name="pet_no" value="${plist.pet_no}">
	        내용 <textarea name="pet_content" id="pet_content">${plist.pet_content}</textarea>
	        
        	파일 <input type="file" onchange="addFile(this);"  multiple />
        	<!-- 여기에 파일 리스트 불러오기 -->
        	<div class="file-list">
        	<c:forEach items="${flist.flist}" var="flist" varStatus="status">
				<div id="file${status.index}" class="filebox">
		        	<img src="<%=request.getContextPath()%>/upload/${flist.filename_real}" style="width:90px; height:90px;" >
		            <p id="name" class="name"> ${flist.filename_org}</p>
		            <a class="delete" onclick="deleteFileDB(${status.index},${flist.file_no},'${flist.filename_real}');">삭제</a>
				</div>
	        </c:forEach>   
        	</div>
	</form>
	<input type="submit" onclick="filecheck();" value="수정완료">
	<input type="submit" onclick="petlist();" value="목록으로">
</div>

</body>
</html>