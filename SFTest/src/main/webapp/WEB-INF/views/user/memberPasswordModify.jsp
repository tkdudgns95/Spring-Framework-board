<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>패스워드 변경</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
#topBanner {
  margin-top:10px;
  margin-bottom:10px;
  max-width: 500px;
  height: auto;
  display: block; margin: 0 auto;
}

.registerForm {
  width:900px;
  height:auto;
  padding: 10px, 10px;
  background-color:#FFFFFF;
  border:4px solid gray;
  border-radius: 20px;
} 
.old_userpassword, .new_userpassword {
  width: 80%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.btn_register  {
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

<script>
function register(){
	if($("#old_userpassword") == '') { alert("기존 패스워드를 입력하세요."); $("#old_userpassword").focus(); return false; }
  	var Pass = $("#new_userpassword").val();
	var Pass1 = $("#new_userpassword1").val();
	if(Pass == '') { alert("신규 패스워드를 입력하세요."); $("#new_userpassword").focus(); return false; }
	if(Pass1 == '') { alert("신규 패스워드를 입력하세요."); $("#new_userpassword1").focus(); return false; }
	if(Pass != Pass1) 
		{ alert("입력된 신규패스워드를 확인하세요"); $("#new_userpassword1").focus(); return false; }
	
	// 암호유효성 검사
	var num = Pass.search(/[0-9]/g);
 	var eng = Pass.search(/[a-z]/ig);
 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	
	if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }
 	$("#registerForm").attr("action","/user/memberPasswordModify").submit();	
}

</script>

</head>
<body>

<div>
  <img id="topBanner" src ="${pageContext.request.contextPath}/resources/images/logo.jpg" title="서울기술교육센터" >
</div>  

<div class="main" align="center">
  <div class="registerForm">
	      
    <h1>패스워드 변경</h1>
    <form name="registerForm" id="registerForm" method="post">           
        <input type="password" id="old_userpassword" name="old_userpassword" class="old_userpassword" placeholder="기존 패스워드를 입력하세요.">
        <c:if test="${msg == 'PASSWORD_NOT_FOUND'}"><p style="color:red;text-align:center;">잘못된 패스워드를 입력했습니다.</p></c:if>
        <input type="password" id="new_userpassword" name="new_userpassword" class="new_userpassword" placeholder="신규 패스워드를 입력하세요.">
        <p style="color:red;text-align:center;">※ 8~20이내의 영문자, 숫자, 특수문자 조합으로 암호를 만들어 주세요.</p>
        <input type="password" id="new_userpassword1" name="new_userpassword1" class="new_userpassword" placeholder="신규 패스워드를 한번 더 입력하세요.">
        <input type="button" class="btn_register" value="패스워드 변경" onclick="register()">
        <input type="button" class="btn_cancel" value="취소" onclick="history.back()">
	  </form>

  </div>
</div>
<br><br>
</body>
</html>