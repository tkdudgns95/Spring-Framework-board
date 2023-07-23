<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>임시 패스워드 발급</title>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script>
	$(document).ready(function(){
		$("#btn_goHome").on("click", function(){
			location.href="/"	
		})
	})
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
   
#pwSearchResult {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
}   
#btn_goHome  {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
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

	<div id="pwSearchResult">
     	<br><br><h1>임시 패스워드 : ${password}</h1>
       	<button id="btn_goHome">로그인 창으로 이동</button>
  </div> 

</div>

</body>
</html>