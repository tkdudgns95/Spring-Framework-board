<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 미리 보기</title>


</head>
<body>

<script>

	const previewFiles = () => {
		
		const preview = document.querySelector('#preview');
		const files = document.querySelector('input[type=file]').files;
		
		const readAndPreview = (file) => {
			
			if(/\.(jpe?g|png|gif)$/i.test(file.name)) {
				
				const reader = new FileReader();
				
				reader.addEventListener('load', function() {
					
					let image = new Image(); //<img ....>
					image.height = 100;
					image.title = file.name;
					image.src = this.result;
					preview.appendChild(image);
					
				});
				
				reader.readAsDataURL(file); // readText
				
			}
		}
		
		if(files) //유사배열 : --> 원래 정식 배열은 아닌데 배열처럼 보이는 거...
		// 정식 배열 : let a = [1,2,3,4,5] 또는 let a = new Array();
		// 정식배열은 배열 객체에서 제공하는 메소드를 사용할 수 있는 반면,
		// 유사배열은 X. 유사배열도 배열 객체에서 지원하는 메소드를 사용할 수 있게끔
		// 해주는 방법이 있음. [] --> Array.prototype
		
			[].forEach.call(files, readAndPreview);
			
	}
	
</script>

<input type="file" id="browse" onchange="previewFiles()" multiple><br>
<div id="preview"></div>


</body>
</html>