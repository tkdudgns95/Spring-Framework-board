<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
<script>

	window.onload = async() => {
		
		//쿠키 가져오기
		const getCookie = (name) => {
			 const cookies = document.cookie.split(`; `).map((el) => el.split('='));
			 let getItem =[];
			 for (let i = 0; i < cookies.length; i++){
				 if (cookies[i][0] === name){
					 getItem.push(cookies[i][1]);
					 break;
				 }
			 }
			 if (getItem.length > 0) {

				 return decodeURIComponent(getItem[0]);
			 } 
		 }
		let userid = getCookie('userid');
		let password = getCookie('password');
		let authkey = getCookie('authkey');

		//userid 화면 로드시 userid 체크박스 관리
		if(userid !== undefined) {//userid라는 쿠키가 존재
			document.querySelector('#rememberUserid').checked = true;
			document.querySelector('#userid').value = userid;
			
		} else { //userid 쿠키가 없으면?
			document.querySelector('#rememberUserid').checked = false;
			}
		
		 //userid 화면 로드시 패스워드 체크 박스 관리 
		 if(password !== undefined) {//password 쿠키가 존재하면...
			 document.querySelector('#rememberPassword').checked = true;
		 
		 	//Base64 인코딩 된 password를 디코딩
		 	const decrypt = CryptoJS.enc.Base64.parse(password);
		 	const hashData = decrypt.toString(CryptoJS.enc.Utf8);
		 	password = hashData;
		 	
		 	document.querySelector('#password').value = password;
			 
		 } else {// 패스워드 쿠키가 존재하지 않을 경우
			 document.querySelector('#rememberPassword').checked = false;
			 
		 }
		 // 자동로그인 처리
	 if(authkey !== undefined) {
			 
			 let formData = new FormData();
			 formData.append("authkey", authkey);
			 await fetch('/user/login?autologin=PASS', {
				 method : 'POST',
				 body : formData
			 }).then((response) => response.json())
			   .then((data) => {
				   if(data.message =='good'){
					   document.location.href='/board/list?page=1';
				   }else {
					   alert("시스템 장애로 자동 로그인이 실패 했습니다.");
				   }
			   }).catch(error=>{console.log("error = " + error);});
		 } 

	}

 
/*
	$(document).ready(function(){
		
		$("#btn_login").click(function(){

			if($("#userid").val() =='') {
				alert("아이디를 입력하세요");
				return false;
			}
			if($("#password").val() =='') {
				alert("패스워드를 입력하세요");
				return false;
			}
			$("#loginForm").attr("action","loginCheck.jsp").submit();
		});
		
	});
*/


		
		// 자동 로그인 관리
		const checkRememberMe = () => {
			 if (document.querySelector('#rememberMe').checked) {
				 document.querySelector('#rememberUserid').checked = false;
				 document.querySelector('#rememberPassword').checked = false;
			 }
		}
		//아이디 체크 관리
		const checkRememberUserid = () => {
			if (document.querySelector('#rememberUserid').checked)
				document.querySelector('#rememberMe').checked = false;
			 
		}
		//패스워드 체크 관리
		const checkRememberPassword = () => {
			if (document.querySelector('#rememberPassword').checked)
				document.querySelector('#rememberMe').checked = false;
			 
		}
		
	const loginCheck = async() => {
	
	/*
	if(document.loginForm.userid.value == ''){
		alert("아이디를 입력하세요");
		return false;
	}
	if(document.loginForm.password.value == ''){
		alert("패스워드를 입력하세요");
		return false;
	}
	document.loginForm.action = '/user/login';
	document.loginForm.submit();
	
	*/
	// 아이디 유효성 검사
	if(userid.value === '' || userid.value === null){
		alert("아이디를 입력하세요");
		userid.focus();
		return false;
	}
	
	//패스워드 유효성 검사
	if(password.value === '' || password.value === null){
		alert("패스워드를 입력하세요");
		password.focus();
		return false;
	}
	
	//리멤버미 항목 체크 여부를 확인해서 자동 로그인 여부를 결정 
	let formData = new FormData();
	formData.append("userid", userid.value);
	formData.append("password", password.value);
	
	//NEW: 새로 로그인 해서 쿠키 새로 생성 
	//PASS : 이미 쿠키가 생성되어 있는 상태에서 로그인
	await fetch('/user/login?autologin=NEW',{
		method:'POST',
		body:formData
	}).then((response) => response.json())
	  .then((data) => {
		  if(data.message === 'good'){
			  cookieManage(userid.value, password.value, data.authkey);
			  document.location.href='/board/list?page=1';
		  } else if(data.message === 'ID_NOT_FOUND'){
			  msg.innerHTML = '존재하지 않는 아이디 입니다.';
		  } else if(data.message === 'PASSWORD_NOT_FOUND'){
			  msg.innerHTML = '잘못된 패스워드 입니다.';
		  }  else if(data.message === 'bad'){
			  document.location.href = '/user/pwCheckNotice';
		  }  else {
			  alert("시스템 장애로 로그인이 실패했습니다.");
		  }
	  }).catch((error) => {
		  console.log("error =" + error);
	  });
}
	//엔터키 입력시 로그인 처리
	const press = () => {
		 if(event.keyCode == 13){loginCheck();}
	}

	//쿠키 관리 --> 쿠키생성, 쿠키 삭제
	const cookieManage = (userid, password, authkey) => {
		//자동 로그인 쿠키 관리
		if(rememberMe.checked)//쿠키생성
			document.cookie = 'authkey=' + authkey + '; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
		else//쿠키삭제
			document.cookie = 'authkey=' + authkey + '; path=/; max-age=0';
			
		//userid 쿠키 관리
		if(rememberUserid.checked)//쿠키생성
			document.cookie = 'userid=' + userid + '; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
		else//쿠키삭제
			document.cookie = 'userid=' + userid + '; path=/; max-age=0';
			
		//패스워드 쿠키 관리 
		//base64 (양방향 복호화  64비트 알고리즘)
		const key = CryptoJS.enc.Utf8.parse(password);
		const base64 = CryptoJS.enc.Base64.stringify(key);
		password = base64;
		
		if(rememberPassword.checked)//쿠키생성
			document.cookie = 'password=' + password + '; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
		else//쿠키삭제
			document.cookie = 'password=' + password + '; path=/; max-age=0';
		
	}


</script>

<meta charset="utf-8">
<title>로그인</title>

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
.login { 
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px; 
}   
.userid, .username, .userpasswd {
  width: 80%;
  border: none;
  border-bottom: 2px solid #adadad;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
  margin-top: 20px;
}
.bottomText {
  text-align: center;
  font-size: 20px;
}
.login_btn  {
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

 .container {
  padding-top: 1em;
  margin-top: 1em;
  border-top: 
    solid
    1px
    #CCC;
} 
a.button {
  display: block;
  position: center;
  float: center;
  width: 200px;
  padding: 0;
  margin: auto;
  font-weight: 600;
  text-align: center;
  line-height: 50px;
  color: #FFF;
  border-radius: 5px;
  transition: all 0.2s ; 
}
.btnLightBlue {
  background: #5DC8CD;
}

.btnFade.btnLightBlue:hover {
  background: #01939A;
}

.btnLightBlue.btnPush {
  box-shadow: 0px 5px 0px 0px #1E8185;
} 

.btnPush:hover {
  margin-top: 0px;
  margin-bottom: 0px;
}

.btnLightBlue.btnPush:hover {
  box-shadow: 0px 0px 0px 0px #1E8185;
}
</style>
</head>
<body>


<div class="main" align="center">

  <div>
    <img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
  </div>
  
	<div class="login">
		<h1>로그인</h1>
		<form name="loginForm" id="loginForm" class="loginForm" method="POST"> 
			<input type="text" name="userid" id="userid" class="userid" placeholder="아이디를 입력하세요.">
         	<input type="password" id="password" name="password" class="userpasswd" placeholder="비밀번호를 입력하세요.">
         	<p id = "msg" style="color:red; text-align:center"></p>
         	<br>
         	<label><input type="checkbox" id="rememberUserid" onclick="checkRememberUserid()"> 아이디기억</label>
         	<label><input type="checkbox" id="rememberPassword" onclick="checkRememberPassword()"> 패스워드 기억</label>
         	<label><input type="checkbox" id="rememberMe" onclick="checkRememberMe()"> 자동 로그인</label>
         	<br><br>
     		<input type="button" id="btn_login" class="login_btn" value="로그인" onclick="loginCheck()"> 
     		
     		<div class="container">
    		<a href="/user/signup" title="Button push lightblue" class="button btnPush btnLightBlue">회원가입</a>
    		</div>
		</form>
		 
    		<br>
    		
    		<!-- <div class="clear"></div> -->
  		
           <!-- <div class="bottomText">사용자가 아니면 ▶<a href="/user/signup">여기</a>를 눌러 등록을 해주세요.<br><br> -->
           
     	      [<a href="/user/searchID">아이디 찾기</a> | 
     	       <a href="/user/searchPassword">패스워드</a>  찾기]  <br><br>    
    	  </div>  
    	  
   
    	  
	</div>

</div>

</body>
</html>