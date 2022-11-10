<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="petplantheader.jsp" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>반려식물 게시판 등록</title>

<link href="/plant/css/petplant/instagram.css" rel="stylesheet" type="text/css" />
<style>
.insert {
    padding: 60px 30px;
    display: block;
    width: 700px;
    height: 65vh;
    margin: 12vh auto;
    border: 1px solid #dbdbdb;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    background-color: #fff;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%,10%);
}

.insert .file-list {
    overflow: auto;
    padding: 10px;
    display: flex;
	box-shadow: 0 1px 1px rgb(0 0 0 / 5%);    
    
}

/* .insert .file-list .filebox span {
    font-size: 14px;
    margin-top: 10px;
}
 */

.insert .file-list .filebox .delete .Ximg{
    color: #ff5353;
    margin-left: 5px;
    width: 20px;
    height: 20px;
    position: fixed;
}

.write{
	position: relative;
}

.content{
 	width: 640px;
	height: 200px;
/*     margin: 5vh auto;*/    
	border-radius:8px;
	border-color : #dbdbdb;
	padding: 10px;
	box-shadow: 0 1px 1px rgb(0 0 0 / 5%);    
	
}

.filebox{
	width: 120px;
	height: 100px;
	justify-content: space-between;
}

.save{
	float: right;
	color : #fff;
	background-color: #0095f6;
	border: 0;
    width: 60px;
    height: 28px;
    border-radius: 6px;
	box-shadow: 0 3px 3px rgb(0 0 0 / 5%);    
}

.img{
	width:90px; 
	height:90px; 
	box-shadow: 0 3px 3px rgb(0 0 0 / 5%);    
	
}

.list{
	float: right;
    color: #fff;
    background-color: #afacac;
    border: 0;
    width: 70px;
    height: 28px;
    border-radius: 6px;
    box-shadow: 0 3px 3px rgb(0 0 0 / 5%);
    margin-right: 10px;    
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
	            htmlData += '	<img class="img" src="'+imgsrc+'">';
	            // 파일이름
	            //htmlData += '   <span id="name" class="name">' + file.name + '</span>';
	            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');">';
	            htmlData += '		<span type="button" class="far fa-minus-square"><img class="Ximg" src="/plant/img/petplant/X.png"></span>';
	            htmlData += '	</a>';
	            htmlData += '</div>';
	            $('.file-list').append(htmlData);
	            fileNo++;
				
				filesArr.push(file);
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
    const fileTypes = [ 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif'];
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

/* 첨부파일 삭제 */
function deleteFile(num) {
    document.querySelector("#file" + num).remove();
    filesArr[num].is_delete = true;
}


function filecheck() {
    // 첨부파일이 없을 때 
	var form = $(".filebox").val();
    if (form == null) {
    	alert("사진을 등록해 주세요");
    	return fales;
    	
    } else {
    		
    	var form = $('form')[0];
    	var formData = new FormData(form);

    	    for (var i = 0; i < filesArr.length; i++) {
    	        // 삭제되지 않은 파일만 폼데이터에 담기
    	        if (!filesArr[i].is_delete) {
    	            formData.append("file", filesArr[i]);
    	    	    console.log("file?????? : " + filesArr[i]);
    	        }
    	    }
    	    //var pet_content = $("#pet_content").val();
    	    //var data = formData + pet_content;
    	    //console.log("찍히니?2 : " + pet_content);
    	    
    	    $.ajax({
    	    	method: 'POST',
    	        url: 'insert.do',
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

<div class="write">
	<div class="insert">
	    <form id="form" method="post" onsubmit="return false;"  enctype="multipart/form-data" >
	        
	        	<input type="file" onchange="addFile(this);"  multiple />
	        	<div class="file-list"></div>
	    <textarea name="pet_content" id="pet_content" class="content" placeholder="내용을 작성해주세요"></textarea>
	    </form>
	    <input type="submit" onclick="filecheck();" class="save" value="저장">
	    <input type="submit" onclick="petlist();" class="list" value="목록으로">
	</div>
</div>
</body>
</html>