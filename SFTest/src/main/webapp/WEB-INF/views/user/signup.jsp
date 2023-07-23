<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
<link rel="stylesheet" href="/resources/css/board.css">

<script>

window.onload = () => {
//-------------------------------------
//var objDragAndDrop = $(".ImageRegistration");
	var imgCheck = "N";
	var imgZone = document.querySelector('#imageZone');
	var fileEvent = document.querySelector('#imageFile');
	


	//ImageZone 영역 클릭 시 파일이벤트 처리. 자바스크립에서 이번트 발생 시 이벤트 정보를 담고 있는 event(e)라는 객체를 자동 생성.
	imgZone.addEventListener('click', (e) => {
			fileEvent.click(e) //사용자가 만든 UI를 통해 <input type="file">을 클릭하는 것과 같은 효과를 내게 됨
		});
		
	
	//파일 선택창 열기 이벤트. 자바스크립트에서는 객체는 객체 자신과 더불어서 prototype이라고 하는 본인 객체의 도플갱어 형태의 객체를 같이 생성.
	fileEvent.addEventListener('change', (e) => { //파일선택해서 파일을 가져오는 거
			const files = e.target.files; //선택한 파일 정보가 e.target.files(배열)에 저장
			showImage(files); //읽어 온 파일을 인자로 받아서 이미지 미리보기를 실행
		});


 
 

/* $('input[type=file]').on("change", function(e) 
       var files = e.originalEvent.target.files;
       imageView(files, objDragAndDrop); */





       const showImage = (files) => {
    		
   		imgZone.innerHTML = '';
   		const imgFile = files[0];
   		
	//if(imgFile.size > 1024*1024) { alert("1MB 이하 파일만 올려주세요."); return false; }
	//e.target.files[0].type.indexOf("")
	if(imgFile.type.indexOf("image") < 0) { alert("이미지 파일만 올려주세요"); return false; }

	const reader = new FileReader(); //new 연산자를 통해서 FileReader() 객체를 reader가 참조(상속)
	reader.onload = function(event){ //아래 img 태그로 만들어진 element에 이미지를 보낼거라는 걸 결정 --> 파일을 읽고나서 해야 할 일...
		imgZone.innerHTML = "<img src='" + event.target.result + "' id='uploadImg' style='width:350px; height:auto;'>";
	};
	
	reader.readAsDataURL(imgFile); //실제로 파일을 읽는 부분은 여기...
	console.log(event.target.result);
	imgCheck = "Y";
}
//-------------------------------------

	btnRegister.addEventListener('click', async () => {

	
	
	//유효성 검사
	if (imgCheck == '' ) { alert("프로필 이미지를 등록하세요."); userid.focus();  return false; }
	if (userid.value == '' ) { alert("아이디를 입력하세요."); userid.focus();  return false; }
	if (username.value == '') { alert("이름을 입력하세요."); username.focus(); return false; }

	const Pass = password.value;
	const Pass1 = password1.value;
	if(Pass == '') { alert("암호를 입력하세요."); password.focus(); return false; }
	if(Pass1 == '') { alert("암호를 입력하세요."); password1.focus(); return false; }
	if(Pass != Pass1) 
		{ alert("입력된 비밀번호를 확인하세요"); password1.focus(); return false; }
	
	// 암호유효성 검사
	//자바스크립트의 정규식(Regular Expression)
	let num = Pass.search(/[0-9]/g); // 0-9까지의 숫자가 들어 있는지 검색. 검색이 안되면 -1을 리턴
 	let eng = Pass.search(/[a-z]/ig); //i : 알파벳 대소문자 구분 없이... 
 	let spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	//특수문자가 포함되어 있는가 검색
	if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }

 	/*
 	document.RegistryForm.action = '/board/signup';
 	document.RegistryForm.submit();
	*/
	
	//$('#RegistryForm').attr('action','/user/signup').submit();
	
	const gender = document.querySelector('input[name=gender]:checked');
	const hobby = document.querySelectorAll('input[name=hobby]:checked');
	let hobbyArray = [];
	for(let i=0; i<hobby.length; i++)
		hobbyArray.push(hobby[i].value);
	const job = document.querySelector('select[name=job] option:checked');
	
	if(gender.value == '') { alert("성별을 선택하세요."); return false; }
	if(hobby.value == '') { alert("취미을 선택하세요."); return false; }
	if(job.value == '') { alert("직업을 선택하세요."); return false; }
	if(description.value == '') { alert("자기소개를 입력하세요."); description.focus(); return false; }
	
	
	if(zipcode.value == '') { alert("우편번호를 입력하세요."); zipcode.focus(); return false; }
	if(addr2.value == '') { alert("상세 주소를 입력하세요."); addr2.focus(); return false; }
	address.value = addr1.value + " " + addr2.value;
 	if(telno.value == '') { alert("전화번호를 입력하세요."); telno.focus(); return false; }
 	//전화번호 문자열 정리
	const beforeTelno = telno.value;
 	const afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim();
 	//console.log("afterTelno : " + afterTelno);
 	telno.value = afterTelno;
 	
	if (email.value == '') { alert("이메일주소를 입력하세요."); email.focus(); return false; } //4.25 javascript 정규식표현 카톡 확인 후 수정
	

	let formData = new FormData(RegistryForm);
	//document.RegistryForm.action = '';
	//document.RegistryForm.sumint(); // --> Form문내의 값들을 serialization해서 전달 jQuery에서 $("RegistryForm").serialize(); 
	
	
	
	/* const data = {
			
			userid: userid.value,
			username: username.value,
			password: password.value,
			gender: gender.value,
			hobby: hobbyArray.toString(),
			job: job.value,
			description: description.value,
			zipcode: zipcode.value,
			address: address.value,
			email: email.value,
			telno: telno.value
			
			
			
	};
	 */
	await fetch('/user/signup', {
		method: 'POST',
		body: formData,
		
	}).then((response) => response.json())
	  .then((data) => {
		  if(data.status === 'good'){
			  alert(decodeURIComponent(data.username) + "님, 회원 가입을 축하 드립니다.");
			  document.location.href="/user/login";
		  } else {
			  alert("서버 장애로 회원 가입에 실패했습니다.");
		  }
	});
	
});
}
	
	
	/*
	console.log("userid = " + $("#userid").val());
	console.log("username = " + $("#username").val());
	console.log("gender = " + $("input[name=gender]").val());
	console.log("hobby = " + $("input[name=hobby]").val());
	console.log("job = " + $("select[name=job]").val());
	*/
	



	//여기부터 onload에서 빼기
const selectAll = (checkElement) => {
	//<input type="checkbox" id="all" name="all" onclick="selectAll(this)">가 
	//ckeck 여부를 확인할 수 있는 값(ckecked==true 또는 ckecked==false)을 보내고
	//이 값이 checkElement에 들어감.
	//checkElement 값을 checkbox.checked에 넣어준다.
	/*
	const checkboxes = document.getElementsByName("hobbies");
	checkboxes.forEach((checkbox) => {
		checkbox.checked = checkElement.checked; 
	});
	*/

	if(document.getElementById('all').checked == true)
		for(var i=0; i<document.getElementsByName('hobby').length; i++)
			document.getElementsByName('hobby')[i].checked = true;
	if(document.getElementById('all').checked == false)
		for(var i=0; i<document.getElementsByName('hobby').length; i++)
			document.getElementsByName('hobby')[i].checked = false;
	
}

const idCheck = async () => {
	
	const userid = document.querySelector("#userid");
	
	await fetch('/user/idCheck',{		
		method: "POST",
		body: userid.value,		
	}).then((response) => response.text())
	  .then((data) => {		     
			const idCheckNotice = document.querySelector('#idCheckNotice');
			if(data == 0)
				idCheckNotice.innerHTML = "사용 가능한 아이디입니다.";
			else {
				idCheckNotice.innerHTML = "이미 사용중인 아이디입니다.";
				//userid.value = '';
				userid.focus();
			}
	  });
	
	// 비동기 처리로 서버로부터 값을 받아 아이디 사용 가능 여부를 확인해서 
	
}

//주소 검색
const searchAddr = () => {


	if(addrSearch.value =='') {
		alert("검색할 주소를 입력하세요.");
		addrSearch.focus();
		return false;
	}

	window.open(
	          "/user/addrSearch?page=1&addrSearch=" + addrSearch.value,
	          "주소검색",
	          "width=900, height=540, top=50, left=50"
	);
	
	
}


</script>

<style>
.ImageZone {
                border: 2px solid #92AAB0;
                width: 60%;
                height: 200px;
                color: #92AAB0;
                text-align: center;
                vertical-align: middle;
                margin: auto;
  				padding: 10px 10px;
                font-size:200%;
                
}
.addrSearch{
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
</style>

</head>
<body>

<div>
	<img id="topBanner" src="/resources/images/logo.jpg">	
</div>

<div class="main">
	<h1>회원 등록</h1><br>
	
	<div class="WriteForm">
		<form id="RegistryForm" name="RegistryForm" method="POST">
			<input type="file" name="fileUpload" id="imageFile" style="display:none;" />
			<br>
    		<div class="imageZone" id="imageZone"> 클릭 후 탐색창에서 사진을 <br>선택해 주세요.</div>
    		<br>
			<input type="text" class="input_field" id="userid" name="userid" placeholder="여기에 아이디를 입력해 주세요." onchange="idCheck()"> <br>
			<span id="idCheckNotice"></span>
			<input type="text" class="input_field" id="username" name="username" placeholder="여기에 이름을 입력해 주세요.">
			<input type="password" class="input_field" id="password" name="password" placeholder="여기에 패스워드를 입력해 주세요.">
			<input type="password" class="input_field" id="password1" name="password1" placeholder="여기에 패스워드를 입력해 주세요.">
			<div style="width:90%; text-align:left; position:relative; left: 35px; border-bottom:2px solid #adadad; margin:10px; padding: 10px;">
				성별 : 
				<label><input type="radio" name="gender" value="남성">남성</label>
				<label><input type="radio" name="gender" value="여성">여성</label><br>
				취미 : 
				<label><input type="checkbox" id="all" name="all" onclick="selectAll(this)">전체선택</label>
				<label><input type="checkbox" name="hobby" value="음악감상">음악감상</label>
				<label><input type="checkbox" name="hobby" value="영화보기">영화보기</label>
				<label><input type="checkbox" name="hobby" value="스포츠">스포츠</label><br>
				직업 : 
				<select name="job">
					<option disabled selected>-- 아래의 내용 중에서 선택 --</option>
					<option value="회사원">회사원</option>
					<option value="공무원">공무원</option>
					<option value="자영업">자영업</option>
				</select>
				<br>
			</div>
			    <input type="text" id="addrSearch" name="addrSearch" class="addrSearch" placeholder="주소를 검색합니다.">
		        <input type="button" id="btn_addrSearch" class="btn_addrSearch" value="주소검색" onclick="searchAddr()">
		        <input type="text" id="zipcode" class="input_field" name="zipcode" placeholder="우편번호가 검색되어 입력됩니다." readonly>
		        <input type="text" id="addr1" class="input_field" name="addr1" placeholder="주소가 검색되어 입력됩니다." readonly>
		        <input type="text" id="addr2" class="input_field" name="addr2" placeholder="상세주소를 입력하세요" >
		        <input type="hidden" id="address" name="address">
		        <input type="text" id="telno" name="telno" class="input_field" placeholder="전화번호를 입력하세요.">
		        <input type="text" id="email" name="email" class="input_field" placeholder="이메일주소를 입력하세요.">
		        <p style="color:red;">일반 사용자 권한으로 등록됩니다.</p>
			<br>
			<textarea class="input_content" id="description" cols="100" rows="500" name="description" placeholder="자기소개를 입력해 주세요.">
			</textarea><br>
			<input type="button" id="btnRegister" class="btn_write" value="여기를 클릭하세요!!!">
			
		</form>
	
	</div>

</div>
<br><br>

</body>
</html>