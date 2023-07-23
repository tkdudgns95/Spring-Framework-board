<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 수정</title>
<script>

	window.onload = () => {
		
		const fileZone = document.querySelector('#fileZone');
		const inputFile = document.querySelector('#inputFile');
		//fileZone을 클릭하면 발생하는 이벤트
		fileZone.addEventListener('click',(e) => {			
			inputFile.click(e);			
		});		
		
		//파일탐색창을 열어 선택한 파일 정보를 files에 할당
		inputFile.addEventListener('change', (e)=> {
			//본 이벤트는 file 타입으로 파일을 받는게 아니라 드래그앤드랍 같이 다른 이벤트 형식을 통해 file을 받는 것으로 이런 경우는 OriginalEvent를 이용하여 파일 정보를 받아야 함.
			const files = e.target.files; 
			fileCheck(files);			
		});
		
		/* 마우스 이벤트 종류
		dragstart	1. 사용자가 객체(object)를 드래그하려고 시작할 때 발생함.
		drag	    2. 대상 객체를 드래그하면서 마우스를 움직일 때 발생함.
		dragenter	3. 마우스가 대상 객체의 위로 처음 진입할 때 발생함.
		dragover	4. 드래그하면서 마우스가 대상 객체의 영역 위에 자리 잡고 있을 때 발생함.
		drop	    5. 드래그가 끝나서 드래그하던 객체를 놓는 장소에 위치한 객체에서 발생함. 리스너는 드래그된 데이터를 가져와서 드롭 위치에 놓는 역할을 함
		dragleave	6. 드래그가 끝나서 마우스가 대상 객체의 위에서 벗어날 때 발생함.
		dragend	    7. 대상 객체를 드래그하다가 마우스 버튼을 놓는 순간 발생함.
		*/
		
		//fileZone으로 dragenter 이벤트 발생시 처리하는 이벤트 핸들러
		fileZone.addEventListener('dragenter', (e) => {
			//e.preventDefault : 웹브라우저의 고유 동작을 중단 
			//e.stopPropagation는 상위 엘리먼트들로의 이벤트 전파를 중단
	    	e.stopPropagation(); 
	    	e.preventDefault();
	    	fileZone.style.border = '2px solid #0B85A1';	    	
		})
		
		//fileZone으로 dragover 이벤트 발생시 처리하는 이벤트 핸들러
		fileZone.addEventListener('dragover',(e) => {
	    	e.stopPropagation();
	    	e.preventDefault();
		});
		
		//fileZone으로 drop 이벤트 발생시 처리하는 이벤트 핸들러
		fileZone.addEventListener('drop',(e) => {
			e.stopPropagation();
	        e.preventDefault();
	    	const files = e.dataTransfer.files;
		    fileCheck(files);
		});
	}
	
	var uploadCountLimit = 5; // 업로드 가능한 파일 갯수
	var fileCount = 0; // 파일 현재 필드 숫자 totalCount랑 비교값
	var fileNum = 0; // 파일 고유넘버
	var content_files = new Array(); // 첨부파일 배열
	var rowCount=0;
	
	const fileCheck = (files) => {
		
		//배열로 변환
		//let filesArr = Array.prototype.slice.call(files);
		let filesArr = Object.values(files); //ECMASCript 2017 버전부터 제공
		
	    // 파일 개수 확인 및 제한
	    if (fileCount + filesArr.length > uploadCountLimit) {
	      	alert('파일은 최대 '+uploadCountLimit+'개까지 업로드 할 수 있습니다.');
	      	return;
	    } else {
	    	 fileCount = fileCount + filesArr.length;
	    }
	
		filesArr.forEach((file) => {
			//FileReader 객체 : 웹애플리키에션이 비동기적으로 웹브라우저에서 파일을 읽을때 사용하며, 
			//<input>태그를 이용하여 사용자가 선택한 파일들의 결과로 반환된 FileList 객체나 
			//Drag & Drop 이벤트로 반환된 DataTransfer 객체로부터 데이터를 얻는다.
		      var reader = new FileReader();
				
			  //file 읽기	
		      reader.readAsDataURL(file);
			  
			  //reader.readAsDataURL(file) 명령 실행으로 파일 읽기 성공적으로 수행되고 난 후 
			  //reader.onload 이벤트 핸들러를 통해 reader.onload 이벤트 핸들러내의 콜백 함수가 비동기적으로 실행됨.
		      reader.onload = (e) => {
		        content_files.push(file);
				
		        if(file.size > 1073741824) { alert('파일 사이즈는 1GB를 초과할수 없습니다.'); return; }
			
		    	rowCount++;
		        var row="odd";
		        if(rowCount %2 ==0) row ="even";
		        
		        let statusbar = document.createElement('div');
		        statusbar.setAttribute('class','statusbar ' + row);
		        statusbar.setAttribute('id','file' + fileNum);
		        
		        //statusbar내의 파일명
		        let filename = "<div class='filename'>" + file.name + "</div>";
		        
		        //statusbar내의 파일 사이즈
		        let sizeStr="";
		        let sizeKB = file.size/1024;
		        if(parseInt(sizeKB) > 1024){
		        	sizeMB = sizeKB/1024;
		            sizeStr = sizeMB.toFixed(2)+" MB";
		        }else sizeStr = sizeKB.toFixed(2)+" KB";	        
		        let size = "<div class='filesize'>" + sizeStr + "</div>";
		        
		        //statusbar내의 삭제 버튼
		        let btn_delete = "<div class='btn_delete'><input type='button' value='삭제' onclick=fileDelete('file" + fileNum + "')></div>";
		       
		        statusbar.innerHTML = filename + size + btn_delete;
		        
		        fileUploadList.appendChild(statusbar);
				
		        fileNum ++;
		        console.log(file);
		      
		      };
		      
	    });
		
		inputFile.value= '';	
	
	}	
	
	const fileDelete = (fileNum) => {
	    var no = fileNum.replace(/[^0-9]/g, "");
	    content_files[no].is_delete = true;
	    
	    document.querySelector('#' + fileNum).remove();
		fileCount --;
	}  
	
	const ModifyForm = async () => {
	
		if(title.value == '') { alert("제목을 입력하세요!!!"); title.focus(); return false;  }
		if(content.value =='') { alert("내용을 입력하세요!!!"); content.focus(); return false;  }
	
		let mForm = document.getElementById('ModifyForm');	
	 	let formData = new FormData(mForm);
		for (var x = 0; x < content_files.length; x++) {
				if(!content_files[x].is_delete) { 
							
					formData.append("SendToFileList", content_files[x]);
				}
		}
	
		let uploadURL = '';
		
		if(content_files.length != 0)
			uploadURL = '/board/fileUpload?kind=U';
		else 			
			uploadURL = '/board/modify';
		
		formData.append("seqno",${view.seqno});
			     
		await fetch(uploadURL, {
			
			method: 'POST',
			body: formData			
			
		}).then((response)=> response.json())
		  .then((data) => {
			  if(data.message == 'good'){
				alert("게시물이 수정되었습니다.");
				document.location.href='/board/view?seqno=${view.seqno}&page=${page}&keyword=${keyword}';
			  }	
		}).catch((error)=> { 
			alert("시스템 장애로 게시물 수정이 실패했습니다.");
			console.log((error)=> console.log("error = " + error))
		}); 
		
	}

</script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: red; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }
#topBanner {
       margin-top:10px;
       margin-bottom:10px;
       max-width: 500px;
       height: auto;
       display: block; margin: 0 auto;
}
.main {

  text-align: center;
}

.FormDiv {
  width:50%;
  height:auto;
  margin: auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align: center;
  border:4px solid gray;
  border-radius: 30px;
}

.writer, .title {
  width: 90%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 10px;
  padding: 5px 5px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.content{
  width: 90%;
  height: 300px;
  padding: 10px;
  box-sizing: border-box;
  border: solid #adadad;
  font-size: 16px;
  resize: both;
}

.btn_write  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: red;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn_cancel{
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: pink;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.fileuploadForm {
 margin: 5px;
 padding: 5px 5px 2px 30px;
 text-align: left;
 width:90%;
 
}

.fileListForm {
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 3px 3px;
  
}

.filename{
  display:inline-block;
  vertical-align:top;
  width:50%;
}

.filesize{
  display:inline-block;
  vertical-align:top;
  color:#30693D;
  width:30%;
  margin-left:10px;
  margin-right:5px;
}

.fileuploadForm {
 margin: 5px;
 padding: 5px 5px 2px 30px;
 text-align: left;
 width:93%; 
}

.fileZone {
  border: solid #adadad;
  background-color: #a0a0a0;
  width: 97%;
  height:80px;
  color: white;
  text-align: center;
  vertical-align: middle;
  padding: 5px;
  font-size:120%;
  display: block;
}

.fileUploadList {
  border: solid #adadad;
  width: 97%;
  height:auto;
  padding: 5px;
  font-size:120%;
  display: block;
}

.btn_delete{
  display: inline-block;
  width: 15%;	
  cursor:pointer;
  vertical-align:top
}

.statusbar{
  border-bottom:1px solid #92AAB0;;
  min-height:25px;
  width:96%;
  padding:10px 10px 0px 10px;
  vertical-align:top;
}
.statusbar:nth-child(odd){
  background:#EBEFF0;
}


</style>

</head>   
<body>

<%

	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	if(userid == null) response.sendRedirect("/");

%>

  	<div>
    	<img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
  	</div>

	<div class='main'>
		<h1>게시물 수정</h1>
		<div class="FormDiv">
			<form id="ModifyForm" method="POST" >
				<input type="text" class="writer" id="writer" value="작성자 : <%=username %> 님" diasabled>
				<input type="text" class="title" id="title" name="title"  value="${view.title}">
				<input type="hidden" name="seqno" value="${view.seqno}">
				<input type="hidden" name="writer" value="${view.writer}">
				<input type="hidden" name="userid" value="${view.userid}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="searchType" value="${searchType}">
				<input type="hidden" name="keyword" value="${keyword}">
				<textarea class="content" id="content" cols="100" rows="500" name="content">${view.content}</textarea>
				<c:if test="${fileListView != null }">
		         	<div id="fileList">	
		         		<p style="text-align:left;">
		        	 		<c:forEach items="${fileListView}" var="file" >
		         				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제 : <input type="checkbox" name="deleteFileList" value="${file.fileseqno}"> 
		         				 ${file.org_filename}&nbsp( ${file.filesize} Byte)<br>
			         		</c:forEach>
		         		</p>
		         	</div>       
		        </c:if>
        		<div class="fileuploadForm">
					<input type="file" id="inputFile" name="uploadFile" style="display:none;" multiple />
					<div class="fileZone" id="fileZone">파일 첨부를 하기 위해서는 클릭하거나 여기로 파일을 드래그 하세요.<br>첨부파일은 최대 5개까지 등록이 가능합니다.</div>
					<div class="fileUploadList" id="fileUploadList"></div>
				</div>	

				<input type="button" class="btn_write" value="수정" onclick="ModifyForm()" />
				<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
			</form>	
		</div>
	</div>

<br><br>
</body>
</html>