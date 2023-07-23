<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 찾기</title>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script>
function IDSearchCheck(){

	if($("#username").val() == "") { alert("이름을 입력하세요."); $("#username").focus();  return false; }
	if($("#telno").val() == '') { alert("전화번호를 입력하세요."); $("#telno").focus(); return false; }
	$("#IDSearchForm").attr("action", "/user/searchID").submit();
}

function press() {
	
	if(event.keyCode == 13){ pwSearchCheck(); }
	
}

</script>
<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: blue; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }
#topBanner {
       margin-top:10px;
       margin-bottom:10px;
       max-width: 500px;
       height: auto;
       display: block; margin: 0 auto;
}
.IDSearchForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
}   
.username, .telno {
  width: 80%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 10px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.btn_IDSearch  {
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
.btn_cancel  {
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
</style>
</head>

<body>

<div align=center>

    <div>
        <img id="topBanner" src ="${pageContext.request.contextPath}/resources/images/logo.jpg" title="서울기술교육센터" >
    </div>

	<form name="IDSearchForm" class="IDSearchForm" id="IDSearchForm" method="post">
        <h1>아이디 찾기</h1>
     	<div class="IDSearchFormDivision">
         	<input type="text" name="username" id="username" class="username" placeholder="이름을 입력하세요.">
         	<input type="text" id="telno" name="telno" class="telno" onkeydown="press(this.form)" placeholder="전화번호를 입력하세요.">
         	<c:if test="${msg == 'ID_NOT_FOUND'}">
         		<p style="text-align: center; color:red;">입력한 조건에 맞는 사용자가 존재하지 않습니다. 다시 입력하세요 !!!</p>
         	</c:if>
         	<input type="button" id="btn_IDSearch" class="btn_IDSearch" value="아이디 찾기" onclick="IDSearchCheck()"> 
            <input type="button" class="btn_cancel" value="취소" onclick='javascript:location.href="/"'> 
     	</div> 
	</form>

</div>

</body>
</html>